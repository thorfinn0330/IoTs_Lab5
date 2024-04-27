import 'package:flutter/material.dart';

class HomeWeatherIcon extends StatelessWidget {
  const HomeWeatherIcon({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      padding: const EdgeInsets.all(5),
      child: Image.asset(
        'i/ii.png',
      ), // Image.asset ); // Container
    );
  }
}
