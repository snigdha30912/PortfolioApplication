// import 'package:chat_app/models/user.dart';
// import 'package:chat_app/views/chat.dart';
import 'dart:io';

import 'package:final_app/database.dart';
import 'package:final_app/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // CustomUser _userFromFirebaseUser(User user) {
  //   return user != null ? CustomUser(uid: user.uid) : null;
  // }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // return _userFromFirebaseUser(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // return _userFromFirebaseUser(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Future<User> signInWithGoogle(BuildContext context) async {
  //   final GoogleSignIn _googleSignIn = new GoogleSignIn();
  //
  //   final GoogleSignInAccount googleSignInAccount =
  //   await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: googleSignInAuthentication.idToken,
  //       accessToken: googleSignInAuthentication.accessToken);
  //
  //   UserCredential result = await _auth.signInWithCredential(credential);
  //   User userDetails = result.user;
  //
  //   if (result == null) {
  //   } else {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()));
  //   }
  // }

  Future signOut() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      appDocDir.delete(recursive: true);
      SharedPreference.setToNull();
      
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
