import 'package:flutter/material.dart';
import 'package:iot_app/widget/icon.dart';
import 'button.dart'; // Assuming you use a toggle switch package
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

String hum_value = "90";
void updateHum(int val) {
  hum_value = val.toString();
}

class HumidityProvider with ChangeNotifier {
  String _humValue = "90";

  String get humValue => _humValue;

  void updateHum(int val) {
    _humValue = val.toString();
    notifyListeners(); // Notify listeners about the change
  }
}

class MyFlutterScreen extends StatelessWidget {
  const MyFlutterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => HumidityProvider(),
        child: const MyHomePage(), // Replace with your actual home widget
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "IoT Demo",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 101, 227),
      ),
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff1d6cf3), Color(0xFF19d2fe)])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(97, 95, 217, 248)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset(height: 150, 'images/ii.png'),
                              const Text("25°C",
                                  style: TextStyle(
                                      fontSize: 56,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              const Text(
                                "Nhiệt độ",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(height: 150, 'images/temp_1.png'),
                              Text(
                                  "${context.watch<HumidityProvider>().humValue}%",
                                  style: const TextStyle(
                                      fontSize: 56,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              const Text(
                                "Độ ẩm",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(97, 95, 217, 248)),
                  child: const Column(
                    children: [
                      SwitchScreen(text: "Đèn"),
                      SwitchScreen(text: "Quạt"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(96, 148, 234, 255)),
                  child: const Column(
                    children: [
                      Text("Nhận diện AI ",
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      Text("                     ",
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      Text("Không đeo khẩu trang",
                          style: TextStyle(fontSize: 32, color: Colors.white)),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
