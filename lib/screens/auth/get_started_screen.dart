import 'package:flutter/material.dart';
import 'package:fotoverse/screens/auth/landing_screen.dart';
import 'package:fotoverse/utils/colors.dart';
import 'package:fotoverse/widgets/button_widget.dart';
import 'package:fotoverse/widgets/text_widget.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

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
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 400,
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/welcome.png',
              width: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            TextRegular(
              text:
                  'We’re here to help you to see God’s\nWord in all the special moments of your lives.',
              fontSize: 14,
              color: Colors.white,
            ),
            const Expanded(
              child: SizedBox(
                height: 20,
              ),
            ),
            ButtonWidget(
              labelColor: Colors.white,
              color: red,
              label: 'Get Started',
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LandingScreen()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        )),
      ),
    );
  }
}
