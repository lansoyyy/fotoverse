import 'package:flutter/material.dart';
import 'package:fotoverse/widgets/text_widget.dart';

import '../utils/colors.dart';

class ViewImageScreen extends StatelessWidget {
  final List quotes;
  final dynamic imageFile;

  ViewImageScreen({Key? key, required this.quotes, required this.imageFile})
      : super(key: key);

  String caption = '';
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
            child: SingleChildScrollView(
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
              Stack(
                children: [
                  Image.file(
                    imageFile,
                    width: double.infinity,
                  ),
                  Center(
                    child: TextRegular(
                      text: caption,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 150,
                width: 500,
                child: ListView.builder(
                  itemCount: quotes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: TextBold(
                        text: quotes[index]['reference'],
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
