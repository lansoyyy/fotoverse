import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fotoverse/screens/pages/profile_page.dart';
import 'package:fotoverse/utils/colors.dart';
import 'package:fotoverse/widgets/drawer_widget.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../services/api_service.dart';
import '../widgets/toast_widget.dart';
import 'first_view_image_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    Future quotes = ApiService().getBibleVerses(_results[0]['label']);

    // Future quotes = ApiService().getBibleVerses('peace');

    quotes.then((value) {
      if (value['results'].isNotEmpty) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FirstViewImageScreen(
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
      drawer: const DrawerWidget(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: red,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                    height: 150,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            pickImage(true);
                          },
                          leading: const Icon(Icons.camera),
                          title: TextRegular(
                              text: 'Camera',
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {
                            pickImage(false);
                          },
                          leading: const Icon(Icons.photo),
                          title: TextRegular(
                              text: 'Gallery',
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ],
                    ));
              },
            );
          }),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: primary,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      );
                    }),
                    const SizedBox(
                      width: 10,
                    ),
                    TextBold(
                      text: 'Welcome John,',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: 10,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                      },
                      child: const CircleAvatar(
                        minRadius: 20,
                        maxRadius: 20,
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextBold(
                    text: 'Public Page',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Photos')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text('Error'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          )),
                        );
                      }

                      final data = snapshot.requireData;
                      return Expanded(
                        child: SizedBox(
                          child: GridView.builder(
                            itemCount: data.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                child: Container(
                                  height: 350,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              minRadius: 20,
                                              maxRadius: 20,
                                              backgroundImage: AssetImage(
                                                'assets/images/profile.png',
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            TextBold(
                                              text: data.docs[index]
                                                  ['userName'],
                                              fontSize: 12,
                                              color: primary,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 250,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                                image: NetworkImage(data
                                                    .docs[index]['imageLink']),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImage(bool isCamera) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    File image = File(pickedFile!.path);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    imageClassification(File(croppedFile!.path));
  }
}
