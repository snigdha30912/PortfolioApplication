import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import './otp2.dart';

import 'login.dart';
import 'otp.dart';

class Login2 extends StatelessWidget {
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
        ),
      ),
      body: Column(
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
              padding: const EdgeInsets.only(top: 0, right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: 'Enter the ',
                                style: GoogleFonts.montserrat(
                                    color: HexColor('#999999'),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                      text: 'Phone No. ',
                                      style: GoogleFonts.montserrat(
                                          color: HexColor('#FA5805'),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                    text: 'linked\n with your account.',
                                    style: GoogleFonts.montserrat(
                                        color: HexColor('#999999'),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  )
                                ])),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //       enabledBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: HexColor('#999999'),
                  //         ),
                  //       ),
                  //       focusedBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: HexColor('#999999'),
                  //         ),
                  //       ),
                  //       hintText: 'Full Name',
                  //       hintStyle:
                  //           TextStyle(color: HexColor('#999999'), fontSize: 16),
                  //       suffixIcon: Icon(
                  //         Icons.person_outline,
                  //         color: HexColor('#FA5805'),
                  //       )),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
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
                        hintStyle:
                            TextStyle(color: HexColor('#999999'), fontSize: 16),
                        suffixIcon: Icon(
                          Icons.phone,
                          size: 20,
                          color: HexColor('#FA5805'),
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //       enabledBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: HexColor('#999999'),
                  //         ),
                  //       ),
                  //       focusedBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: HexColor('#999999'),
                  //         ),
                  //       ),
                  //       hintText: 'Password',
                  //       hintStyle:
                  //           TextStyle(color: HexColor('#999999'), fontSize: 16),
                  //       suffixIcon: Icon(
                  //         Icons.remove_red_eye,
                  //         color: HexColor('#FA5805'),
                  //       )),
                  // ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Otp2()));
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
                        style:
                            TextStyle(color: HexColor('#999999'), fontSize: 18),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: HexColor('#FA5805'), fontSize: 18),
                          ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
