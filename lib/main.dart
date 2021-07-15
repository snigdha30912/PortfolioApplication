import 'package:final_app/shared_preferences.dart';
import 'package:final_app/views/Authentication_Views/intro1.dart';
import 'package:final_app/views/home.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      debugPrint(e.toString());
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    getLoggedInState();
    initializeFlutterFire();

    super.initState();
  }

  getLoggedInState() async {
    await SharedPreference.getLogInStatus().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return OverlaySupport(
        child: MaterialApp(
          home: Text("Something went wrong :("),
        ),
      );
    }
    if (!_initialized) {
      return MaterialApp(home: Center(child: CircularProgressIndicator()));
    }
    return OverlaySupport(
      child: MaterialApp(
          home: (userIsLoggedIn == null || userIsLoggedIn == false)
              ? Intro1()
              : HomeScreen()),
    );
  }
}
