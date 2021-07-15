import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import '../../shared_preferences.dart';

class TemplateDatabase {
  static updateTemplateData(data, username) async {
    FirebaseFirestore.instance
        .collection("templates")
        .doc(username)
        .update(data)
        .catchError((e) {
      print(e.toString());
    });
  }

  static Future<void> createTemplate(username, type) async {
    return FirebaseFirestore.instance
        .collection("templates")
        .doc(username)
        .set({
      "about": "write a short and catchy description about yourself",
      "subscribers": 0,
      "designation": "Portfolio Maker",
      "type": type
    });
  }

  static Future<DocumentSnapshot<dynamic>> getTemplateData(username) async {
    return FirebaseFirestore.instance
        .collection("templates")
        .doc(username)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  // static Future<QuerySnapshot<dynamic>> getHobbiesData(username) async {
  //   return FirebaseFirestore.instance
  //       .collection("templates")
  //       .doc(username)
  //       .collection("hobbies")
  //       .get()
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }

  static Future<QuerySnapshot<dynamic>> getMemoriesData(username) async {
    return FirebaseFirestore.instance
        .collection("templates")
        .doc(username)
        .collection("memories")
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  static Future<QuerySnapshot<dynamic>> getAlbumsData(username) async {
    return FirebaseFirestore.instance
        .collection("templates")
        .doc(username)
        .collection("albums")
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  static getHobbies(String username) async {
    return FirebaseFirestore.instance
        .collection("templates")
        .doc(username)
        .collection("hobbies")
        .snapshots();
  }

  static getAlbums(String username) async {
    return FirebaseFirestore.instance
        .collection("templates")
        .doc(username)
        .collection("albums")
        .snapshots();
  }

  static getComments(String username, String postRef) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .collection("posts")
        .doc(postRef)
        .collection("comments")
        .snapshots();
  }

  static getPhotos(String username, String galleryRef) async {
    return FirebaseFirestore.instance
        .collection("templates")
        .doc(username)
        .collection("albums")
        .doc(galleryRef)
        .collection("images")
        .snapshots();
  }

  static getFolder(String username, String hobbyRef) async {
    return FirebaseFirestore.instance
        .collection("templates")
        .doc(username)
        .collection("hobbies")
        .doc(hobbyRef)
        .collection("folders")
        .snapshots();
  }

  static getHobbyPosts(
      String username, String hobbyRef, String folderRef) async {
    return FirebaseFirestore.instance
        .collection("templates")
        .doc(username)
        .collection("hobbies")
        .doc(hobbyRef)
        .collection("folders")
        .doc(folderRef)
        .collection("posts")
        .snapshots();
  }

  static Future<DocumentSnapshot<dynamic>> getUserData(username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  static uploadImageToStorage(image, path) async {
    if (image != null) {
      try {
        await FirebaseStorage.instance
            .ref(path)
            .putFile(image)
            .whenComplete(() {
          Fluttertoast.showToast(
              msg: "image uploaded successfully",
              toastLength: Toast.LENGTH_SHORT);
        });
      } on FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        debugPrint(e.toString());
      }
    }
  }

  static Future<String> getImageUrl(path) async {
    Reference object = FirebaseStorage.instance.ref(path);
    try {
      // debugPrint("adnalwndlanwldwndklakldn" + object.toString());
      String url = await object.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<DocumentSnapshot<dynamic>> getPostData(
      username, postRef) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .collection("posts")
        .doc(postRef)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  // static Future<QuerySnapshot<dynamic>> getPostImages(username, postRef) async {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(username)
  //       .collection("posts")
  //       .doc(postRef)
  //       .collection("images")
  //       .get()
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }
  static getPostImages(username, postRef) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .collection("posts")
        .doc(postRef)
        .collection("images")
        .snapshots();
  }
}
