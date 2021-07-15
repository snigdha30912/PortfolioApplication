import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/views/Authentication_Views/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../database.dart';
import 'login.dart';
import 'sign_up2.dart';

class Sign_up extends StatefulWidget {
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController fullnameController = new TextEditingController();
  bool isUsernameUnique = true;
  bool isLoading = false;
  bool obscureText = true;
  validateUsername() async {
    if (formKey.currentState.validate()) {
      this.setState(() {
        isLoading = true;
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(usernameController.text)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          this.setState(() {
            isUsernameUnique = false;
            formKey.currentState.validate();
            isUsernameUnique = true;
            isLoading = false;
          });
        } else {
          this.setState(() {
            isUsernameUnique = true;
            isLoading = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Otp(
                      username: usernameController.text,
                      password: passwordController.text,
                      fullname: fullnameController.text)));
        }
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
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
            ),
            Container(
              decoration: BoxDecoration(
                  color: HexColor('#131212'),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              height: MediaQuery.of(context).size.height -
                  (height + statusBarHeight + 150),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 100, right: 30, left: 30),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: fullnameController,
                          validator: (val) {
                            return val.length > 0
                                ? null
                                : "Name must not be empty";
                          },
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
                              hintText: 'Full Name',
                              hintStyle: TextStyle(
                                  color: HexColor('#999999'), fontSize: 16),
                              suffixIcon: Icon(
                                Icons.person_outline,
                                color: HexColor('#FA5805'),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: usernameController,
                          validator: (val) {
                            if (val.length < 6)
                              return "Username must be atleast 6 characters long";
                            return isUsernameUnique
                                ? null
                                : "Username Already taken";
                          },
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
                          style: TextStyle(color: Colors.white),
                          obscureText: obscureText,
                          controller: passwordController,
                          validator: (val) {
                            return val.length >= 8
                                ? null
                                : "Enter at least 8 characters";
                          },
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
                              suffixIcon: IconButton(
                                onPressed: () {
                                  obscureText = !obscureText;
                                },
                                icon: obscureText
                                    ? Icon(
                                        Icons.remove_red_eye,
                                        color: HexColor('#FA5805'),
                                      )
                                    : Icon(
                                        Icons.hide_source_outlined,
                                        color: HexColor('#FA5805'),
                                      ),
                              )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        isLoading
                            ? CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () {
                                  validateUsername();
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
                                      child: Text('Sign Up',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                    )),
                              ),
                        SizedBox(
                          height: 40,
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
                                      color:
                                          HexColor('#FA5805').withOpacity(.6),
                                      fontSize: 18),
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
