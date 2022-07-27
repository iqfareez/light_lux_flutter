import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Light Lux',
      theme: ThemeData(
        primaryColor: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark().copyWith(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () async {
                if (!await launchUrl(
                    Uri.parse('https://github.com/iqfareez/light_lux_flutter'),
                    mode: LaunchMode.externalApplication)) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Can\'t launch URL. Unknown error'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              icon: const Icon(Icons.code),
            )
          ],
        ),
        body: const AppPage(),
      ),
    );
  }
}
