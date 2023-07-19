import 'package:flutter/material.dart';
import 'package:fotoverse/screens/auth/signup_screen.dart';
import 'package:fotoverse/screens/home_screen.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:fotoverse/widgets/textfield_widget.dart';

import '../../utils/colors.dart';
import '../../widgets/button_widget.dart';
import 'landing_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LandingScreen()));
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    label: TextRegular(
                      text: 'Back',
                      fontSize: 14,
                      color: secondary,
                    ),
                  ),
                  TextBold(
                    text: 'Log in',
                    fontSize: 32,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextFieldWidget(
                color: Colors.white,
                borderColor: Colors.white,
                hintColor: Colors.white,
                label: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  TextFieldWidget(
                    isObscure: true,
                    showEye: true,
                    color: Colors.white,
                    borderColor: Colors.white,
                    hintColor: Colors.white,
                    label: 'Password',
                    controller: passwordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        child: TextBold(
                          text: 'Forgot Password?',
                          fontSize: 12,
                          color: secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                labelColor: primary,
                color: Colors.white,
                label: 'Login',
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 125,
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextBold(
                    text: 'or',
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 125,
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                minWidth: 300,
                height: 50,
                color: Colors.white,
                onPressed: () {},
                child: SizedBox(
                  width: 275,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/fblogo.png',
                        height: 25,
                      ),
                      const SizedBox(
                        width: 55,
                      ),
                      TextBold(
                          text: 'Login with Facebook',
                          fontSize: 14,
                          color: primary),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                minWidth: 300,
                height: 50,
                color: red,
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
                child: SizedBox(
                  width: 275,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/googlelogo.png',
                        height: 25,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 55,
                      ),
                      TextBold(
                          text: 'Login with Google',
                          fontSize: 14,
                          color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextRegular(
                    text: 'No Account?',
                    fontSize: 14,
                    color: secondary,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                    },
                    child: TextBold(
                      text: 'Signup here',
                      fontSize: 14,
                      color: secondary,
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(
                  height: 10,
                ),
              ),
              TextRegular(
                text: 'By logging in, you agree to our T&Cs and Privacy Policy',
                fontSize: 12,
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
