import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:final_app/views/chat_views/chat_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hexcolor/hexcolor.dart';
import '../../database.dart';
import '../home.dart';
import './login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseMessaging _fcm = FirebaseMessaging.instance;

class Otp extends StatefulWidget {
  String username;
  String fullname;
  String password;
  Otp({this.username, this.fullname, this.password});
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoading2 = false;
  bool isResend = false;
  bool isOtpSent = false;
  String verificationCode;
  TextEditingController otpController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  verifyPhone() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
        isResend = true;
      });
      debugPrint("formkey valid");
      QuerySnapshot querySnapshot = await DatabaseMethods()
          .getUserInfoFromPhoneNumber(phoneController.text);
      if (querySnapshot.docs.length == 0) {
        await _auth
            .verifyPhoneNumber(
          phoneNumber: '+91${phoneController.text}',
          verificationCompleted: (phoneAuthCredential) {
            debugPrint("verification complete");
            _auth.signInWithCredential(phoneAuthCredential).then((user) async {
              if (user != null) {
                String fcmToken = await _fcm.getToken();
                setState(() {
                  isLoading = true;
                });
                Map<String, String> userDataMap = {
                  "uid": user.user.uid,
                  "password":
                      Crypt.sha256(widget.password, salt: '!@#%ss').toString(),
                  "phoneNumber": phoneController.text,
                  "fullname": widget.fullname,
                  "fcmToken": fcmToken,
                  "tagline": "this is a default tagline"
                };

                DatabaseMethods().addUserInfo(userDataMap, widget.username);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              }
            });
          },
          verificationFailed: (FirebaseAuthException error) {
            debugPrint('Gideon test 5' + error.message);
            setState(() {
              isLoading = false;
            });
          },
          codeSent: (verificationId, [forceResendingToken]) {
            debugPrint("Codesent");
            setState(() {
              isLoading = false;
              isOtpSent = true;
              verificationCode = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            debugPrint('Gideon test 7');
            Fluttertoast.showToast(msg: 'Request timed out, Please try again');
            setState(() {
              isLoading = false;
              isOtpSent = false;

              verificationCode = verificationId;
            });
          },
          timeout: Duration(seconds: 60),
        )
            .catchError((e) {
          debugPrint(e.toString());
        });
      } else {
        setState(() {
          isLoading = false;
        });
        debugPrint("A user with this phone number already exists");
        Fluttertoast.showToast(
            msg: "A user with this phone number already exists",
            toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  createAccount() async {
    if (formKey.currentState.validate()) {
      debugPrint("validated");
      setState(() {
        isLoading2 = true;
      });
      await _auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verificationCode,
              smsCode: otpController.text.toString()))
          .then((user) async {
        debugPrint("signed in");
        if (user != null) {
          String fcmToken = await _fcm.getToken();
          setState(() {
            isLoading = true;
          });
          Map<String, String> userDataMap = {
            "uid": user.user.uid,
            "password":
                Crypt.sha256(widget.password, salt: '!@#%ss').toString(),
            "phoneNumber": phoneController.text,
            "fullname": widget.fullname,
            "fcmToken": fcmToken,
            "tagline": "This is your default tagline",
            "dpURL" : null
          };

          DatabaseMethods().addUserInfo(userDataMap, widget.username);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            ),
            (route) => false,
          );
        }
      }).catchError((error) => {
                debugPrint(error.toString()),
                setState(() {
                  isLoading2 = false;
                  isResend = true;
                }),
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
          icon: Icon(
            Icons.arrow_back_ios,
            color: HexColor('#999999'),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
                padding: const EdgeInsets.only(top: 150, right: 30, left: 30),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            return value.length != 10
                                ? "Invalid Phone Number"
                                : null;
                          },
                          controller: phoneController,
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
                              hintText: 'Phone No.',
                              hintStyle: TextStyle(
                                  color: HexColor('#999999'), fontSize: 16),
                              suffixIcon: Icon(
                                Icons.phone,
                                size: 20,
                                color: HexColor('#FA5805'),
                              )),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: otpController,
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
                              hintText: 'OTP',
                              hintStyle: TextStyle(
                                  color: HexColor('#999999'), fontSize: 16),
                              suffixIcon: Icon(
                                Icons.lock,
                                color: HexColor('#FA5805'),
                              )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        isLoading
                            ? CircularProgressIndicator()
                            : !isOtpSent
                                ? GestureDetector(
                                    onTap: () {
                                      verifyPhone();
                                    },
                                    child: Container(
                                        height: 48,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            gradient: LinearGradient(colors: [
                                              HexColor('#D58D69'),
                                              HexColor('#E34F03')
                                            ])),
                                        child: Center(
                                          child: Text('Send OTP',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)),
                                        )),
                                  )
                                : Container(
                                    height: 48,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: HexColor('#A5A5A5'),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text('OTP Sent',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    )),
                        SizedBox(
                          height: 10,
                        ),
                        isLoading2
                            ? CircularProgressIndicator()
                            : isOtpSent
                                ? GestureDetector(
                                    onTap: () {
                                      createAccount();
                                    },
                                    child: Container(
                                        height: 48,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            gradient: LinearGradient(colors: [
                                              HexColor('#D58D69'),
                                              HexColor('#E34F03')
                                            ])),
                                        child: Center(
                                          child: Text('Confirm OTP',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)),
                                        )),
                                  )
                                : Container(
                                    height: 48,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: HexColor('#A5A5A5'),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text('Confirm OTP',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    )),
                        // TextButton(
                        //     onPressed: () {},
                        //     child: Text(
                        //       'Resend OTP',
                        //       style: TextStyle(
                        //           color: HexColor('#FA5805'),
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w500),
                        //     )),
                        SizedBox(
                          height: 135,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account ? ',
                              style: TextStyle(
                                  color: HexColor('#999999'), fontSize: 18),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Login()));
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: HexColor('#FA5805'), fontSize: 18),
                                ))
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
