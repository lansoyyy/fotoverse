import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotoverse/screens/auth/login_screen.dart';
import 'package:fotoverse/widgets/button_widget.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:fotoverse/widgets/textfield_widget.dart';

import '../../utils/colors.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/toast_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: TextBold(text: 'Profile', fontSize: 18, color: Colors.white),
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/images/logo.png',
          ),
        ],
      ),
      drawer: const DrawerWidget(),
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
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const CircleAvatar(
                        minRadius: 50,
                        maxRadius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextBold(
                        text: data['name'],
                        fontSize: 32,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: TextBold(
                                text: data['gender'],
                                fontSize: 18,
                                color: primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                        isRequred: false,
                        label: 'Email',
                        hint: data['email'],
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                        hint: '********',
                        isObscure: true,
                        label: 'Password',
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ButtonWidget(
                        color: red,
                        labelColor: Colors.white,
                        label: 'Delete Account',
                        onPressed: () {
                          final user = FirebaseAuth.instance.currentUser;
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const SizedBox(
                                      width: 150,
                                      child: Text(
                                        'Are you sure you want to delete your account?',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'QBold',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    content: const Text(
                                      'This action cannot be undone',
                                      style: TextStyle(fontFamily: 'QRegular'),
                                    ),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(
                                              fontFamily: 'QRegular',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance
                                              .signOut()
                                              .then((value) {
                                            user!.delete().then((value) {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen()));
                                            });
                                          });
                                          showToast(
                                              'Account deleted succesfully!');
                                        },
                                        child: const Text(
                                          'Continue',
                                          style: TextStyle(
                                              fontFamily: 'QRegular',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}
