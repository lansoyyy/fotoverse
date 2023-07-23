import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fotoverse/screens/view_image_screen.dart';
import 'package:fotoverse/services/api_service.dart';
import 'package:fotoverse/widgets/toast_widget.dart';
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

    Future quotes = ApiService().getBibleVerses(_results[1]['label']);

    quotes.then((value) {
      if (value['results'].isNotEmpty) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewImageScreen(
                  imageFile: _image,
                  quotes: value['results'],
                )));
      } else {
        showToast('Image not recognized! Try again...');
      }
    });

    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => ViewImageScreen(
    //           imageFile: _image,
    //           quotes: quotes,
    //         )));
  }

  @override
  Widget build(BuildContext context) {
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
      source: ImageSource.camera,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }
}
