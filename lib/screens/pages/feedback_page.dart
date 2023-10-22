import 'package:flutter/material.dart';
import 'package:fotoverse/utils/colors.dart';
import 'package:fotoverse/widgets/button_widget.dart';
import 'package:fotoverse/widgets/drawer_widget.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:fotoverse/widgets/textfield_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../widgets/toast_widget.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
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
        title: TextBold(
            text: 'Send a Feedback', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldWidget(
                textcolor: primary,
                label: 'Name',
                controller: nameController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                textcolor: primary,
                label: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                maxLine: 10,
                height: 250,
                textcolor: primary,
                label: 'Your Comment',
                controller: commentController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: TextBold(
                      text: 'Cancel',
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                  ButtonWidget(
                    radius: 100,
                    width: 150,
                    labelColor: Colors.white,
                    label: 'Submit',
                    onPressed: () async {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: '2ez4ramos@gmail.com',
                        queryParameters: {
                          'subject': "Receipt",
                          'body':
                              "Name:${nameController.text}\nEmail:${emailController.text}\nFeedback:${commentController.text}\nDate: ${DateTime.now()}",
                        },
                      );

                      if (await canLaunchUrlString(emailLaunchUri.toString())) {
                        await launchUrlString(
                            emailLaunchUri.toString().replaceAll('+', ' '));

                        showToast('Feedback sent succesfully!');

                        nameController.clear();
                        emailController.clear();
                        commentController.clear();
                      } else {
                        throw 'Could not launch email';
                      }
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
