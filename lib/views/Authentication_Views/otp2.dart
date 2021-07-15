import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'login.dart';

class Otp2 extends StatelessWidget {
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
              padding: const EdgeInsets.only(top: 150, right: 30, left: 30),
              child: Column(
                children: [
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
                        hintText: 'Phone No.',
                        hintStyle:
                            TextStyle(color: HexColor('#999999'), fontSize: 16),
                        suffixIcon: Icon(
                          Icons.phone,
                          size: 20,
                          color: HexColor('#FA5805'),
                        )),
                  ),
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
                        hintText: 'OTP',
                        hintStyle:
                            TextStyle(color: HexColor('#999999'), fontSize: 16),
                        suffixIcon: Icon(
                          Icons.lock,
                          color: HexColor('#FA5805'),
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
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
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                            color: HexColor('#FA5805'),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )),
                  SizedBox(
                    height: 135,
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
