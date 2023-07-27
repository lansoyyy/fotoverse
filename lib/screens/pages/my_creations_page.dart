import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Photos')
              .where('userId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )),
              );
            }

            final data = snapshot.requireData;
            return Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: primary,
                ),
                child: GridView.builder(
                  itemCount: data.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(
                                data.docs[index]['imageLink'],
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                ));
          }),
    );
  }
}
