import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fotoverse/utils/colors.dart';
import 'package:fotoverse/widgets/drawer_widget.dart';
import 'package:fotoverse/widgets/text_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
              text: 'Location of the folder',
              fontSize: 18,
              color: primary,
            ),
            subtitle: TextRegular(
              text: 'Location',
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
