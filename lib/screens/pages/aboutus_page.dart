import 'package:flutter/material.dart';
import 'package:fotoverse/widgets/text_widget.dart';

import '../../utils/colors.dart';
import '../../widgets/drawer_widget.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: TextBold(
            text: 'About Fotoverse', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: primary,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextBold(
                text: 'About',
                fontSize: 32,
                color: red,
              ),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                text:
                    'Learn more about Fotoverse and the developers behind the application.',
                fontSize: 18,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              TextBold(
                text: 'Fotoverse',
                fontSize: 32,
                color: red,
              ),
              TextRegular(
                text: 'by ROT',
                fontSize: 14,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                fontSize: 18,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
