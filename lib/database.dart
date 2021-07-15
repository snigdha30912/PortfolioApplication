import 'dart:io';
import 'package:final_app/views/Template_views/template_database.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:final_app/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseMethods {
  getUserInfoFromUsername(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("userName", isEqualTo: username)
        .get();
  }

  getUserInfoFromPhoneNumber(String phoneNumber) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
  }

  Future<void> addUserInfo(userData, username) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
    SharedPreference.saveLogInStatus(true);
    SharedPreference.saveUserName(username); //username is userReference now
    SharedPreference.saveUserPhone(userData['phoneNumber']);
  }

  getUserInfoFromEmail(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .get();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  Future<void> updateUser(String password, String phoneNumber) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get()
        .then((docSnap) {
      docSnap.docs[0].reference.update(
          {'password': Crypt.sha256(password, salt: '!@#%ss').toString()});
    });
  }

  Future<void> updateToken(String userReference) {
    return FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(userReference)
          .update({'fcmtoken': token});
    });
  }

  Future<void> addFriendRequest(
      String frienduserName, String currentUserName) async {
    // adding friend to current user's friend list
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserName)
        .collection("friends")
        .doc(frienduserName)
        .set({
      'isFriend': false,
      'received':
          false, //if the current user has received or sent friend request
      'time': DateTime.now().millisecondsSinceEpoch
    }).catchError((e) {
      print(e.toString());
    });
    // add
    FirebaseFirestore.instance
        .collection("users")
        .doc(frienduserName)
        .collection("friends")
        .doc(currentUserName)
        .set({
      'isFriend': false, //false if request hasn't been accepted
      'received': true,
      'time': DateTime.now().millisecondsSinceEpoch
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> acceptFriendRequest(
      String friendReference, String currentUserReference) async {
    String chatReference;
    await FirebaseFirestore
        .instance //accept request from current user's friend list
        .collection("chatRooms")
        .add({
      'isEmpty': true,
    }).then((value) {
      chatReference = value.id;
    });

    debugPrint(chatReference);
    FirebaseFirestore.instance //accept request from current user's friend list
        .collection("users")
        .doc(currentUserReference)
        .collection("friends")
        .doc(friendReference)
        .update({'isFriend': true, 'chat': chatReference});
    FirebaseFirestore.instance //accept request from friend's friend list
        .collection("users")
        .doc(friendReference)
        .collection("friends")
        .doc(currentUserReference)
        .update({'isFriend': true, 'chat': chatReference});
  }

  Future<void> removeFriendRequest(
      String friendReference, String currentUserReference) async {
    debugPrint(currentUserReference);
    FirebaseFirestore.instance //remove request from current user's friend list
        .collection("users")
        .doc(currentUserReference)
        .collection("friends")
        .doc(friendReference)
        .delete();
    FirebaseFirestore.instance //remove request from friend's friend list
        .collection("users")
        .doc(friendReference)
        .collection("friends")
        .doc(currentUserReference)
        .delete();
  }

  getRequests(String currentUserReference) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserReference)
        .collection("friends")
        .where("isFriend", isEqualTo: false)
        .where("received", isEqualTo: true)
        .snapshots();
  }

  getFriends(String currentUserName) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserName)
        .collection("friends")
        .where("isFriend", isEqualTo: true)
        .snapshots();
  }

  Future<void> saveProfile(String name, String tagline, File image) async {
    String currentUserReference;
    PaintingBinding.instance.imageCache.clear();
    imageCache.clearLiveImages();
    imageCache.clear();
    debugPrint("naaaaaaaaaaaaaaaaaaame $name");
    SharedPreference.getUserName().then((value) async {
      currentUserReference = value;
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserReference)
          .update({
        'fullname': name,
        'tagline': tagline,
      });
      debugPrint("UPLOADING");
      if (image != null) {
        TemplateDatabase.uploadImageToStorage(
                image, "ProfileImages/$currentUserReference-DP.jpg")
            .then((value) {
          TemplateDatabase.getImageUrl(
                  "ProfileImages/$currentUserReference-DP.jpg")
              .then((value) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(currentUserReference)
                .update({
              'dpURL': value,
            });
          });
        });
      }
    });
  }
}
