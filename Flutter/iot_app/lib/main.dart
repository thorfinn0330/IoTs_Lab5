import 'package:flutter/material.dart';
import 'package:iot_app/widget/button.dart';
import 'package:iot_app/widget/mqtt.dart';
import 'package:iot_app/widget/screen.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'widget/card_body_widget.dart';
import 'package:getwidget/getwidget.dart';

const server = 'io.adafruit.com';
const port = '1883';
const username = 'thorfinn0330';
const password = 'aio_WBBO39nW9XVMXmgGOZJbHGYMGJ3H';

int getValuePayload(String payload) {
  int nByte = int.parse(payload.substring(
      payload.indexOf("Payload") + 10, payload.indexOf("Payload") + 11));
  final hexString = payload.substring(payload.indexOf("bytes") + 8,
      payload.indexOf("bytes") + 8 + nByte * 3 + (nByte - 2));
  List<String> parts = hexString.split("><");
  int total = 0;
  int base = 1;
  for (int i = 1; i < nByte; i++) {
    base *= 10;
  }
  for (int i = 0; i < parts.length; i++) {
    int temp = (int.parse(parts[i]) - 48) * base;
    base = base ~/ 10;

    total += temp;
  }
  return total;
}

Future<void> main(List<String> args) async {
  print("begin MQTT");
  var mqttClient = MqttServerClient(server, '');

  await mqttClient.connect(username, password);
  if (mqttClient.connectionState == MqttConnectionState.connected) {
    print('Successfully connected to the MQTT broker');
  } else {
    print('Failed to connect to the MQTT broker');
  }
  const topic = 'thorfinn0330/feeds/cambien1';
  const topic2 = 'thorfinn0330/feeds/cambien2';

  // final message = MqttClientPayloadBuilder();

  // message.addString('55');

  // mqttClient.publishMessage(topic, MqttQos.exactlyOnce, message.payload);
  mqttClient.subscribe(topic, MqttQos.atLeastOnce);
  mqttClient.subscribe(topic2, MqttQos.atLeastOnce);

  print("----------------success--------------------");
  mqttClient.updates?.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
    final message = messages[0].payload.toString();
    final message2 = messages[0].topic;

    print('----------------Received message: $message');
    int val = getValuePayload(message);
    print('Topic: $message2 ----------------Value:  $val');
    updateHum(val);
  });
  mqttClient.updates?.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
    final topic = messages[0].topic;
    final message = messages[0].payload.toString();

    //print('Received message from topic $topic: $message');
  });
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyFlutterScreen(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "ToDoList",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Sheduler1Widget(),
            Scheduler2Widget(),
            SwitchScreen(text: "Máy bơm"),
            SwitchScreen(text: "Đèn"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext content) {
              return Container(
                height: 200,
                width: double.infinity,
                color: Colors.pink[100],
                child: Column(
                  children: [
                    const TextField(),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Add Task")),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }
}
