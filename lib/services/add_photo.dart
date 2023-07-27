import 'package:cloud_firestore/cloud_firestore.dart';

Future addPhoto(userName, userId, imageLink) async {
  final docUser = FirebaseFirestore.instance.collection('Photos').doc();

  final json = {
    'userName': userName,
    'userId': userId,
    'imageLink': imageLink,
    'dateTime': DateTime.now(),
    'id': docUser.id,
  };

  await docUser.set(json);
}
