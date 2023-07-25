import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fotoverse/screens/auth/get_started_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'fotoverse-38ffc',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GetStartedScreen(),
    );
  }
}
