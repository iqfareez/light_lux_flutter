import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyUrlLauncher {
  static void launch(BuildContext context, String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Can\'t launch URL. Unknown error'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
