import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:light/light.dart';
import 'package:url_launcher/url_launcher.dart';

import 'equivalent.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  String _luxString = 'Unknown';
  String _equivalentText = 'Unknown';
  late Light _light;
  late double _opacity;
  late StreamSubscription _subscription;

  void onData(int luxValue) async {
    setState(() {
      _luxString = "$luxValue";
      _opacity = newValueFromRange(
          luxValue.clamp(0, 800).toDouble(), 0, 800, 0.1, 1.0);
      _equivalentText = EquivalentLuxValue.getEquivalent(luxValue);
    });
  }

  void stopListening() => _subscription.cancel();

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
    _opacity = 0.0;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async => startListening();

  double newValueFromRange(
          num value, num oldMin, num oldMax, num newMin, num newMax) =>
      (((value - oldMin) * (newMax - newMin)) / (oldMax - oldMin)) + newMin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        // foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (_) =>
                      SimpleDialog(title: const Text('About'), children: [
                        const SimpleDialogOption(
                          child: Text(
                              'Read the ambient light sensor that persist in your phone. It usually used for the Auto-brightness feature.'),
                        ),
                        SimpleDialogOption(
                          child: const Text('View source code'),
                          onPressed: () async {
                            if (!await launchUrl(
                                Uri.parse(
                                    'https://github.com/iqfareez/light_lux_flutter'),
                                mode: LaunchMode.externalApplication)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text('Can\'t launch URL. Unknown error'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                        )
                      ]));
            },
            icon: const Icon(Icons.code),
          )
        ],
      ),
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 800),
            child: Container(
              color: Colors.orange,
            ),
          ),
          Center(
            child: AutoSizeText(
              _luxString,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 173,
                fontWeight: FontWeight.w100,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: MediaQuery.of(context).orientation == Orientation.landscape
                ? 50
                : 110,
            child: Text(
              _equivalentText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
