import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static String loggedInKey = "ISLOGGEDIN";
  static String profileImageKey = "PROFILEIMAGE";
  static String userNameKey = "USERNAMEKEY";
  static String userPhoneKey = "USERPHONEKEY";
  static String userReferenceKey = "USERREFERENCEKEY";
  static Future<bool> saveLogInStatus(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(loggedInKey, isUserLoggedIn);
  }

  static Future<bool> getLogInStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(loggedInKey);
  }

  static Future<bool> saveProfileImagePath(String path) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(profileImageKey, path);
  }

  static Future<String> getProfileImagePath() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(profileImageKey);
  }

  static Future<bool> saveUserName(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userNameKey, userName);
  }

  static Future<String> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userNameKey);
  }

  static Future<bool> saveUserPhone(String userPhone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userPhoneKey, userPhone);
  }

  static Future<String> getUserPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userPhoneKey);
  }


  static setToNull() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

}


