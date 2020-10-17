import 'dart:async';
import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:light_lux/equivalent.dart';

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  String _luxString = 'Unknown';
  String _equivalentText = 'Unknown';
  Light _light;
  Color bgColor = Colors.white;
  StreamSubscription _subscription;

  void onData(int luxValue) async {
    // print("Lux value: $luxValue");
    setState(() {
      _luxString = "$luxValue";
      bgColor = Colors.blue.withAlpha(luxValue.clamp(0, 255));
      _equivalentText = EquivalentLuxValue.getEquivalent(luxValue);
    });
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Stack(
        children: [
          Center(
            child: Text(
              _luxString,
              style: TextStyle(
                fontSize: 173,
                fontWeight: FontWeight.w100,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 150,
            child: Text(
              _equivalentText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

// From anywhere in your app, add the following line of code:
// Get.changeThemeMode(newThemeMode);
// https://medium.com/swlh/flutter-dynamic-themes-in-3-lines-c3b375f292e3
