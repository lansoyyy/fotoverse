import 'package:flutter/material.dart';
import 'package:fotoverse/widgets/text_widget.dart';

import '../../utils/colors.dart';
import '../../widgets/drawer_widget.dart';

class MyCreationsPage extends StatelessWidget {
  const MyCreationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title:
            TextBold(text: 'My Creations', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: primary,
          ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              );
            },
          )),
    );
  }
}
