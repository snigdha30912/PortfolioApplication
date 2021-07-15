import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/views/chat_views/chat_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../database.dart';
import '../home.dart';
import 'login.dart';
import 'otp.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Signup2 extends StatefulWidget {
  String username;
  String password;
  String fullname;
  Signup2({this.username, this.password, this.fullname});
  @override
  _Signup2State createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = new TextEditingController();
  String verificationCode = '';
  bool isLoading = false;

  verifyPhone() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(
                        // username: widget.username,
                        // phoneNumber: phoneController.text,
                        ),
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Otp(
                        fullname: widget.fullname,
                        username: widget.username,
                        password: widget.password)));

            setState(() {
              isLoading = false;
              verificationCode = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            debugPrint('Gideon test 7');
            Fluttertoast.showToast(msg: 'Request timed out, Please try again');
            setState(() {
              isLoading = false;
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
                        TextFormField(
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
                              hintText: 'Enter Phone No.',
                              hintStyle: TextStyle(
                                  color: HexColor('#999999'), fontSize: 16),
                              suffixIcon: Icon(
                                Icons.phone,
                                size: 20,
                                color: HexColor('#FA5805'),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 90,
                        ),
                        isLoading
                            ? CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () {
                                  verifyPhone();
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
                                      child: Text('Send OTP',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    )),
                              ),
                        SizedBox(
                          height: 180,
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
