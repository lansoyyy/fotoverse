import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fotoverse/screens/auth/login_screen.dart';
import 'package:fotoverse/screens/home_screen.dart';
import 'package:fotoverse/screens/pages/aboutus_page.dart';
import 'package:fotoverse/screens/pages/my_creations_page.dart';
import 'package:fotoverse/screens/pages/profile_page.dart';
import 'package:fotoverse/screens/pages/searchverse_page.dart';
import 'package:fotoverse/screens/pages/settings_page.dart';
import 'package:fotoverse/utils/colors.dart';
import 'package:fotoverse/widgets/text_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<DrawerWidget> {
  // final Stream<DocumentSnapshot> userData =
  //     FirebaseFirestore.instance.collection('Users').doc(userId).snapshots();
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
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
          return SizedBox(
            width: 220,
            child: Drawer(
              child: ListView(
                padding: const EdgeInsets.only(top: 0),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: primary,
                    ),
                    accountEmail: TextRegular(
                        text: data['email'], fontSize: 12, color: Colors.white),
                    accountName: TextBold(
                      text: data['name'],
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    currentAccountPicture: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        minRadius: 50,
                        maxRadius: 50,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                    ),
                  ),
                  ListTile(
                    title: TextBold(
                      text: 'Home',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    },
                  ),
                  ListTile(
                    title: TextBold(
                      text: 'My Profile',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                    },
                  ),
                  ListTile(
                    title: TextBold(
                      text: 'My Creations',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MyCreationsPage()));
                    },
                  ),
                  ListTile(
                    title: TextBold(
                      text: 'Search Verse',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SearchPage()));
                    },
                  ),
                  ListTile(
                    title: TextBold(
                      text: 'About Fotoverse',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AboutUsPage()));
                    },
                  ),
                  ListTile(
                    title: TextBold(
                      text: 'Settings',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SettingsPage()));
                    },
                  ),
                  ListTile(
                    title: TextBold(
                      text: 'Logout',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                  'Logout Confirmation',
                                  style: TextStyle(
                                      fontFamily: 'QBold',
                                      fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  'Are you sure you want to Logout?',
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
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                    },
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                          fontFamily: 'QRegular',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ));
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
