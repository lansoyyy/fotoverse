import 'package:flutter/material.dart';
import 'package:fotoverse/widgets/text_widget.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  PopupMenuButton(
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: () {},
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
                            onPressed: () {},
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
              Stack(
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
                    padding: const EdgeInsets.fromLTRB(20, 150, 20, 50),
                    child: Center(
                      child: TextBold(
                        text: caption,
                        fontSize: MediaQuery.of(context).size.width / 17.5,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 150,
                width: 500,
                child: ListView.builder(
                  itemCount: widget.quotes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            caption = widget.quotes[index]['content'];
                          });
                        },
                        child: TextBold(
                          text: widget.quotes[index]['reference'],
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: colorsList.map((color) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            textColor = color;
                          });
                        },
                        child: ColorBox(color: color));
                  }).toList(),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class ColorBox extends StatelessWidget {
  final Color color;

  const ColorBox({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}
