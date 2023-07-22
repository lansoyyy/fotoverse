import 'package:flutter/material.dart';
import 'package:fotoverse/widgets/button_widget.dart';
import 'package:fotoverse/widgets/text_widget.dart';
import 'package:fotoverse/widgets/textfield_widget.dart';

import '../../utils/colors.dart';
import '../../widgets/drawer_widget.dart';

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
      body: Container(
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
                  text: 'John Doe',
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
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: TextBold(
                          text: 'M',
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
                  label: 'Name',
                  controller: nameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  label: 'Email',
                  controller: emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
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
                  onPressed: () {},
                ),
              ],
            ),
          )),
    );
  }
}
