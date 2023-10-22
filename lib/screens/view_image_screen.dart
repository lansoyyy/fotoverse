import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fotoverse/services/add_photo.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:fotoverse/widgets/toast_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'dart:io';
import '../services/api_service.dart';
import '../utils/colors.dart';

class ViewImageScreen extends StatefulWidget {
  final List quotes;
  final dynamic imageFile;

  const ViewImageScreen(
      {Key? key, required this.quotes, required this.imageFile})
      : super(key: key);

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  final List<Color> colorsList = [
    Colors.white,
    Colors.black,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];
  String caption = '';

  Color textColor = Colors.white;

  // WidgetsToImageController to access widget
  WidgetsToImageController controller = WidgetsToImageController();
// to save image bytes of widget
  Uint8List? bytes;

  String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
  final FirebaseStorage storage = FirebaseStorage.instance;

  ScreenshotController screenshotController = ScreenshotController();

  double fontSize = 14;

  final box = GetStorage();
  void downloadImage() async {
    if (box.read('path') == null) {
      try {
        // Capture the widget as an image using the screenshotController
        Uint8List? bytes = await screenshotController.capture();

        if (bytes != null) {
          // Save the image to the gallery or storage
          final result = await ImageGallerySaver.saveImage(bytes);

          if (result['isSuccess']) {
            print("Image saved to gallery!");
          } else {
            print("Failed to save image: ${result['errorMessage']}");
          }
        } else {
          print("Failed to capture the widget as an image.");
        }
      } catch (e) {
        print("Error saving image: $e");
      }
    } else {
      try {
        // Capture the widget as an image using the screenshotController
        Uint8List? bytes = await screenshotController.capture();

        if (bytes != null) {
          // Get the documents directory where you want to save the image

          final imagePath = '${box.read('path')}/my_image.png';

          // Write the bytes to a File and save it to the specified location
          final file = File(imagePath);
          await file.writeAsBytes(bytes);

          print("Image saved to $imagePath");
        } else {
          print("Failed to capture the widget as an image.");
        }
      } catch (e) {
        print("Error saving image: $e");
      }
    }
  }

  final searchController = TextEditingController();
  String nameSearched = '';

  List verses = [];

  getVerses(String search) {
    verses.clear();
    Future quotes = ApiService().getBibleVerses(search);

    quotes.then((value) {
      if (value['results'].isNotEmpty) {
        setState(() {
          verses = value['results'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: userData,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Drawer();
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Drawer();
            }
            dynamic data = snapshot.data;
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primary,
              ),
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                        PopupMenuButton(
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: TextButton.icon(
                                  onPressed: () {
                                    downloadImage();
                                    downloadImage();
                                  },
                                  icon: const Icon(
                                    Icons.save,
                                    color: Colors.black,
                                  ),
                                  label: TextBold(
                                    text: 'Download',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                child: TextButton.icon(
                                  onPressed: () async {
                                    bytes = await controller.capture();

                                    setState(() {});

                                    ByteData byteData =
                                        ByteData.view(bytes!.buffer);

                                    final Reference ref =
                                        storage.ref().child(fileName);

                                    UploadTask uploadTask = ref.putData(
                                      byteData.buffer.asUint8List(),
                                      SettableMetadata(
                                          contentType:
                                              'image/jpeg'), // Set the content type as per your image format
                                    );

                                    // Monitor the upload progress if needed
                                    uploadTask.snapshotEvents
                                        .listen((TaskSnapshot snapshot) {
                                      print(
                                          'Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
                                    });

                                    // Await for the upload to complete
                                    try {
                                      await uploadTask.whenComplete(() {
                                        showToast('Photo added to collection!');
                                      });

                                      // Get the download URL for the uploaded image
                                      String downloadURL =
                                          await ref.getDownloadURL();

                                      addPhoto(
                                          data['name'],
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          downloadURL);
                                      print('Download URL: $downloadURL');
                                    } catch (e) {
                                      print('Error uploading image: $e');
                                    }
                                  },
                                  icon: Image.asset(
                                    'assets/images/logo.png',
                                    height: 30,
                                  ),
                                  label: TextBold(
                                    text: 'Showcase',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ];
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: primary,
                            ),
                            borderRadius: BorderRadius.circular(100)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Regular',
                                fontSize: 14),
                            onChanged: (value) {
                              nameSearched = value;

                              getVerses(nameSearched);
                            },
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(
                                  color: primary,
                                ),
                                hintText: 'Search a keyword',
                                hintStyle: TextStyle(fontFamily: 'QRegular'),
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                )),
                            controller: searchController,
                          ),
                        ),
                      ),
                    ),
                    Screenshot(
                      controller: screenshotController,
                      child: WidgetsToImage(
                        controller: controller,
                        child: Stack(
                          children: [
                            Container(
                              width: 400,
                              height: 400,
                              decoration: BoxDecoration(
                                color: primary,
                                image: DecorationImage(
                                    image: FileImage(widget.imageFile),
                                    fit: BoxFit.fitWidth,
                                    opacity: 0.5),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 150, 20, 50),
                              child: Center(
                                child: TextBold(
                                  text: caption,
                                  fontSize: fontSize,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 500,
                      child: ListView.builder(
                        itemCount: verses.isNotEmpty
                            ? verses.length
                            : widget.quotes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  caption = verses.isNotEmpty
                                      ? verses[index]['content']
                                      : widget.quotes[index]['content'];
                                });
                              },
                              child: TextBold(
                                text: verses.isNotEmpty
                                    ? verses[index]['reference']
                                    : widget.quotes[index]['reference'],
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (fontSize > 1) {
                              setState(() {
                                fontSize--;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        TextBold(
                          text: fontSize.toStringAsFixed(0),
                          fontSize: fontSize,
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              fontSize++;
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        for (int i = 0; i < colorsList.length; i++)
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  textColor = colorsList[i];
                                });
                              },
                              child: ColorBox(color: colorsList[i]))
                      ],
                    ),
                  ],
                ),
              )),
            );
          }),
    );
  }
}

class ColorBox extends StatelessWidget {
  final Color color;

  const ColorBox({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: color,
    );
  }
}
