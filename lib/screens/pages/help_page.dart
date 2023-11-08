import 'package:flutter/material.dart';
import 'package:fotoverse/utils/colors.dart';
import 'package:fotoverse/widgets/button_widget.dart';
import 'package:fotoverse/widgets/drawer_widget.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:fotoverse/widgets/textfield_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../widgets/toast_widget.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final box = GetStorage();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: primary,
        title: TextBold(text: 'Help', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: TextBold(
                        text:
                            'Is Fotoverse a free app, or are there in-app purchases?',
                        fontSize: 14,
                        color: Colors.white),
                    children: [
                      TextRegular(
                          text:
                              'Its a free app and you have nothing to purchase about the app.',
                          fontSize: 14,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: TextBold(
                        text:
                            'How do I use Fotoverse to overlay a verse in my photo?',
                        fontSize: 14,
                        color: Colors.white),
                    children: [
                      TextRegular(
                          text:
                              'You can drag the text by just dragging it so you can just put the text on what position youre gonna put.',
                          fontSize: 14,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: TextBold(
                        text:
                            'Are there customization options for the font and size of the verse text?',
                        fontSize: 14,
                        color: Colors.white),
                    children: [
                      TextRegular(
                          text:
                              'Yes there are options that you can customize the font and size.',
                          fontSize: 14,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: TextBold(
                        text:
                            'What platforms and devices is Fotoverse available on?',
                        fontSize: 14,
                        color: Colors.white),
                    children: [
                      TextRegular(
                          text: 'Its available on mobile phones.',
                          fontSize: 14,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: TextBold(
                        text:
                            'Can I choose which Bible verse to overlay on my image?',
                        fontSize: 14,
                        color: Colors.white),
                    children: [
                      TextRegular(
                          text:
                              'Yes you can choose your own bible verse to overlay your image. Whether it is suggested by the app or you can search for a keyword',
                          fontSize: 14,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                isRequred: false,
                maxLine: 10,
                height: 180,
                textcolor: primary,
                label: 'Ask questions here',
                controller: commentController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(
                    radius: 100,
                    width: 150,
                    labelColor: Colors.white,
                    label: 'Submit',
                    onPressed: () async {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: 'rotfotoverse@gmail.com',
                        queryParameters: {
                          'subject': "Receipt",
                          'body':
                              "Name:${nameController.text}\nEmail:${emailController.text}\nFeedback:${commentController.text}\nDate: ${DateTime.now()}",
                        },
                      );

                      await launchUrlString(
                          emailLaunchUri.toString().replaceAll('+', ' '));

                      showToast('Feedback sent succesfully!');

                      nameController.clear();
                      emailController.clear();
                      commentController.clear();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
