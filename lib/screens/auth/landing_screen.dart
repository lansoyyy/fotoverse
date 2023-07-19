import 'package:flutter/material.dart';
import 'package:fotoverse/screens/auth/login_screen.dart';
import 'package:fotoverse/screens/auth/signup_screen.dart';
import 'package:fotoverse/utils/colors.dart';
import 'package:fotoverse/widgets/text_widget.dart';

import '../../widgets/button_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

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
              height: 200,
            ),
            TextBold(
              text: 'Get Started by creating an',
              fontSize: 18,
              color: Colors.white,
            ),
            const SizedBox(
              height: 5,
            ),
            TextBold(
              text: 'account or loggin into an',
              fontSize: 18,
              color: Colors.white,
            ),
            const SizedBox(
              height: 5,
            ),
            TextBold(
              text: 'existing one.',
              fontSize: 18,
              color: Colors.white,
            ),
            Image.asset(
              'assets/images/illu.png',
              width: 400,
              height: 300,
            ),
            ButtonWidget(
              labelColor: primary,
              color: Colors.white,
              label: 'Login',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              labelColor: primary,
              color: Colors.white,
              label: 'Signup',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignupScreen()));
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
