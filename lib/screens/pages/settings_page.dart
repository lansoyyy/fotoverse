import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fotoverse/screens/pages/feedback_page.dart';
import 'package:fotoverse/screens/pages/help_page.dart';
import 'package:fotoverse/utils/colors.dart';
import 'package:fotoverse/widgets/drawer_widget.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:get_storage/get_storage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: primary,
        title: TextBold(text: 'Settings', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () async {
              final result = await FilePicker.platform.getDirectoryPath();

              setState(() {
                box.write('path', result);
              });
            },
            leading: const Icon(
              Icons.folder,
              color: primary,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: primary,
            ),
            title: TextBold(
              text: box.read('path') ?? 'Select a location',
              fontSize: 18,
              color: primary,
            ),
            subtitle: TextRegular(
              text: 'Location',
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FeedbackPage()));
            },
            leading: const Icon(
              Icons.feedback,
              color: primary,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: primary,
            ),
            title: TextBold(
              text: 'Send a Feedback',
              fontSize: 18,
              color: primary,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HelpPage()));
            },
            leading: const Icon(
              Icons.help,
              color: primary,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: primary,
            ),
            title: TextBold(
              text: 'Help',
              fontSize: 18,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}
