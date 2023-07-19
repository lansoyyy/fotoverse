import 'package:flutter/material.dart';
import 'package:fotoverse/screens/auth/landing_screen.dart';
import 'package:fotoverse/screens/auth/login_screen.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:fotoverse/widgets/textfield_widget.dart';

import '../../utils/colors.dart';
import '../../widgets/button_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                    text: 'Sign up',
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
              TextFieldWidget(
                isObscure: true,
                showEye: true,
                color: Colors.white,
                borderColor: Colors.white,
                hintColor: Colors.white,
                label: 'Password',
                controller: passwordController,
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
                      builder: (context) => const LoginScreen()));
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
                          text: 'Signup with Facebook',
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
                onPressed: () {},
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
                          text: 'Signup with Google',
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
                          builder: (context) => const LoginScreen()));
                    },
                    child: TextBold(
                      text: 'Login here',
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
                text: 'By signing up, you agree to our T&Cs and Privacy Policy',
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
