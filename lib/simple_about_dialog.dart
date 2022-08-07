import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SimpleAboutDialog extends StatelessWidget {
  const SimpleAboutDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(title: const Text('About'), children: [
      const SimpleDialogOption(
        child: Text(
            'This app uses your phone\'s sensor to measure the light intensity of your surroundings. It usually used for the Auto-brightness feature.'),
      ),
      SimpleDialogOption(
        child: const Text('View source code'),
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
      )
    ]);
  }
}
