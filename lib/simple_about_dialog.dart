import 'package:flutter/material.dart';
import 'package:light_lux/util/my_url_launcher.dart';

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
        child: const Text('Learn more about Lux (Wikipedia)'),
        onPressed: () {
          MyUrlLauncher.launch(context, 'https://en.wikipedia.org/wiki/Lux');
        },
      ),
      SimpleDialogOption(
        child: const Text('View source code'),
        onPressed: () async {
          MyUrlLauncher.launch(
              context, 'https://github.com/iqfareez/light_lux_flutter');
        },
      )
    ]);
  }
}
