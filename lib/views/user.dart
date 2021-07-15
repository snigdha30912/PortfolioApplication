import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userName;
  final String fullName;
  final String phoneNumber;
  final String dpURL;
  User({this.userName, this.phoneNumber, this.fullName, this.dpURL});

  factory User.fromDocument(DocumentSnapshot<dynamic> doc) {
    return User(
        userName: doc.id,
        fullName: doc.data()['fullname'],
        phoneNumber: doc.data()['phoneNumber'],
        dpURL: doc.data()['dpURL']);
  }
}
