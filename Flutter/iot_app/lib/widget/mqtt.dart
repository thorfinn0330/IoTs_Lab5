import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

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

Future<void> InitMQTT() async {
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
  });
  mqttClient.updates?.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
    final topic = messages[0].topic;
    final message = messages[0].payload.toString();

    //print('Received message from topic $topic: $message');
  });
}
