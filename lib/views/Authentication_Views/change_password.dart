import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:final_app/views/Authentication_Views/forgot_password.dart';
import 'package:final_app/views/Authentication_Views/login.dart';
import 'package:final_app/views/Authentication_Views/sign_up.dart';
import 'package:final_app/views/Authentication_Views/sign_up2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import '../../authentication.dart';
import '../../database.dart';
import '../../shared_preferences.dart';
import '../chat_views/chat_home.dart';
import '../home.dart';
import './login2.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class ChangePassword extends StatefulWidget {
  String username;
  ChangePassword(this.username);
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  AuthService authService = new AuthService();
  bool isLoading = false;
  bool doesUsernameExist = true;
  bool isPasswordCorrect = true;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    usernameController.text = widget.username;
    super.initState();
  }

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.username)
          .update({
        "password":
            Crypt.sha256(passwordController.text, salt: '!@#%ss').toString()
      }).then((value) {
        Fluttertoast.showToast(
            msg:
                "password updated successfully, kindly login with your new credentials");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Login(),
          ),
          (route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: HexColor('#999999'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
            ),
            Container(
              decoration: BoxDecoration(
                  color: HexColor('#131212'),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              height: MediaQuery.of(context).size.height -
                  (height + statusBarHeight + 200),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 100, right: 30, left: 30),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.length < 6)
                              return "Username Should have atleast 6 characters";
                            if (doesUsernameExist) return null;
                            return "Username does not exist";
                          },
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          controller: usernameController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: HexColor('#999999'),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: HexColor('#999999'),
                                ),
                              ),
                              hintText: 'User Name',
                              hintStyle: TextStyle(
                                  color: HexColor('#999999'), fontSize: 16),
                              suffixIcon: Icon(
                                FlutterIcons.tag_ant,
                                size: 20,
                                color: HexColor('#FA5805'),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (val) {
                            return val.length > 6
                                ? isPasswordCorrect
                                    ? null
                                    : "Password incorrect"
                                : "Enter Password 6+ characters";
                          },
                          style: TextStyle(color: Colors.white),
                          controller: passwordController,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: HexColor('#999999'),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: HexColor('#999999'),
                                ),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: HexColor('#999999'), fontSize: 16),
                              suffixIcon: Icon(
                                Icons.remove_red_eye,
                                color: HexColor('#FA5805'),
                              )),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        isLoading
                            ? CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () {
                                  signIn();
                                },
                                child: Container(
                                    height: 48,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        gradient: LinearGradient(colors: [
                                          HexColor('#D58D69'),
                                          HexColor('#E34F03')
                                        ])),
                                    child: Center(
                                      child: Text('Reset Password',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    )),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   'Forget your login details ?',
                            //   style: TextStyle(
                            //       color: HexColor('#999999'), fontSize: 16),
                            // ),
                            // TextButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (_) => ForgotPassword()));
                            //     },
                            //     child: Text(
                            //       'Help',
                            //       style: TextStyle(
                            //           color: HexColor('#FA5805'),
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w500),
                            //     ))
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Container(
                            //   height: 2,
                            //   width: 130,
                            //   color: HexColor('#999999'),
                            // ),
                            // Text(
                            //   'OR',
                            //   style: TextStyle(
                            //       color: HexColor('#999999'), fontSize: 16),
                            // ),
                            // Container(
                            //   height: 2,
                            //   width: 130,
                            //   color: HexColor('#999999'),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // TextButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (_) => Login2()));
                            //     },
                            //     child: Text(
                            //       'Login with OTP',
                            //       style: TextStyle(
                            //           color: HexColor('#FA5805'),
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.w500),
                            //     )),
                            // Icon(
                            //   Icons.lock,
                            //   color: HexColor('#FA5805'),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   'Already have an account ? ',
                            //   style: TextStyle(
                            //       color: HexColor('#999999'), fontSize: 18),
                            // ),
                            // TextButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (_) => Sign_up()));
                            //     },
                            //     child: Text(
                            //       'Sign Up',
                            //       style: TextStyle(
                            //           color: HexColor('#FA5805'), fontSize: 18),
                            //     ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}