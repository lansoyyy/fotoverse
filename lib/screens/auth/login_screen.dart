import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotoverse/screens/auth/signup_screen.dart';
import 'package:fotoverse/screens/home_screen.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:fotoverse/widgets/textfield_widget.dart';

import '../../utils/colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/toast_widget.dart';
import 'landing_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

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
                        onPressed: () {
                          forgotPassword();
                        },
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
                  login(context);
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

  login(context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast("No user found with that email.");
      } else if (e.code == 'wrong-password') {
        showToast("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        showToast("Invalid email provided.");
      } else if (e.code == 'user-disabled') {
        showToast("User account has been disabled.");
      } else {
        showToast("An error occurred: ${e.message}");
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }

  forgotPassword() {
    showDialog(
      context: context,
      builder: ((context) {
        final formKey = GlobalKey<FormState>();
        final TextEditingController emailController = TextEditingController();

        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: TextRegular(
            text: 'Forgot Password',
            fontSize: 14,
            color: Colors.black,
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldWidget(
                  hint: 'Email',
                  textCapitalization: TextCapitalization.none,
                  inputType: TextInputType.emailAddress,
                  label: 'Email',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: TextRegular(
                text: 'Cancel',
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            TextButton(
              onPressed: (() async {
                if (formKey.currentState!.validate()) {
                  try {
                    Navigator.pop(context);
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailController.text);
                    showToast(
                        'Password reset link sent to ${emailController.text}');
                  } catch (e) {
                    String errorMessage = '';

                    if (e is FirebaseException) {
                      switch (e.code) {
                        case 'invalid-email':
                          errorMessage = 'The email address is invalid.';
                          break;
                        case 'user-not-found':
                          errorMessage =
                              'The user associated with the email address is not found.';
                          break;
                        default:
                          errorMessage =
                              'An error occurred while resetting the password.';
                      }
                    } else {
                      errorMessage =
                          'An error occurred while resetting the password.';
                    }

                    showToast(errorMessage);
                    Navigator.pop(context);
                  }
                }
              }),
              child: TextBold(
                text: 'Continue',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        );
      }),
    );
  }
}
