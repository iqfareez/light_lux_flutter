import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final url = 'https://github.com/iqfareez/Light-Lux-Flutter';
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
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 1,
          leading: Icon(Icons.lightbulb_outline),
          title: Text('Light Lux'),
          actions: [
            TextButton.icon(
                onPressed: () async {
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Can\'t launch URL. Unknown error'),
                      backgroundColor: Colors.red,
                    ));
                    throw 'Could not launch $url';
                  }
                },
                icon: Icon(Icons.code),
                label: Text('GitHub'))
          ],
        ),
        body: AppPage(),
      ),
    );
  }
}
