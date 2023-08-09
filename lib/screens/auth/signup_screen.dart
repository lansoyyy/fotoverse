import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotoverse/screens/auth/landing_screen.dart';
import 'package:fotoverse/screens/auth/login_screen.dart';
import 'package:fotoverse/screens/home_screen.dart';
import 'package:fotoverse/services/signup.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:fotoverse/widgets/textfield_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/colors.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/toast_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  late String gender = 'Male';
  final List<bool> _isSelected = [true, false];
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
                  label: 'Name',
                  controller: nameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                ToggleButtons(
                    borderRadius: BorderRadius.circular(5),
                    splashColor: Colors.grey,
                    color: Colors.white,
                    selectedColor: Colors.blue,
                    children: const [
                      Icon(Icons.male),
                      Icon(Icons.female),
                    ],
                    onPressed: (int newIndex) {
                      setState(() {
                        for (int index = 0;
                            index < _isSelected.length;
                            index++) {
                          if (index == newIndex) {
                            _isSelected[index] = true;
                            if (_isSelected[0] == true) {
                              gender = 'Male';
                            } else {
                              gender = 'Female';
                            }
                          } else {
                            _isSelected[index] = false;
                          }
                        }
                      });
                    },
                    isSelected: _isSelected),
                const SizedBox(
                  height: 10,
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
                    register(context);
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
                // MaterialButton(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(5)),
                //   minWidth: 300,
                //   height: 50,
                //   color: Colors.white,
                //   onPressed: () {},
                //   child: SizedBox(
                //     width: 275,
                //     child: Row(
                //       children: [
                //         Image.asset(
                //           'assets/images/fblogo.png',
                //           height: 25,
                //         ),
                //         const SizedBox(
                //           width: 55,
                //         ),
                //         TextBold(
                //             text: 'Signup with Facebook',
                //             fontSize: 14,
                //             color: primary),
                //       ],
                //     ),
                //   ),
                // ),
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
                    googleLogin();
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
                const SizedBox(
                  height: 20,
                ),
                TextRegular(
                  text:
                      'By signing up, you agree to our T&Cs and Privacy Policy',
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
      ),
    );
  }

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // signup(nameController.text, numberController.text, addressController.text,
      //     emailController.text);

      signup(nameController.text, gender, emailController.text);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      showToast("Registered Successfully!");

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        showToast('The email address is not valid.');
      } else {
        showToast(e.toString());
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }

  googleLogin() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      final googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return;
      }
      final googleSignInAuth = await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      signup(
          googleSignInAccount.displayName, 'Male', googleSignInAccount.email);
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
