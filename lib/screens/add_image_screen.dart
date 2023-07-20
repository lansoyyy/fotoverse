import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../utils/colors.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  late File _image;
  List _results = [];
  bool imageSelect = false;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model/model.tflite",
        labels: "assets/model/labels.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextBold(text: 'Results:', fontSize: 14, color: Colors.black),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < _results.length; i++)
                  ListTile(
                    title: TextRegular(
                        text: 'Label: ${_results[i]['label']}',
                        fontSize: 14,
                        color: Colors.black),
                    subtitle: TextRegular(
                        text:
                            'Confidence: ${_results[i]['confidence'].toString()}',
                        fontSize: 12,
                        color: Colors.black),
                    trailing: const Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green,
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextBold(
                text: 'Close',
                fontSize: 14,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_results);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: primary,
        ),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: pickImage,
              child: Center(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.file_open_outlined,
                    color: Colors.grey,
                    size: 180,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }
}
