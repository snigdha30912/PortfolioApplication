import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'sign_up.dart';

class Intro3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onPanUpdate: (details) {
      //   if (details.delta.dx > 0) {
      //     Navigator.push(context, MaterialPageRoute(builder: (_) => Intro3()));
      //   }
      // },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 350,
                        height: 280,
                        child: Image.asset(
                          'asset/Group 757.png',
                          fit: BoxFit.fitHeight,
                        )),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: 'Be a part of the \nupcoming tech\n',
                                    style: GoogleFonts.montserrat(
                                        color: HexColor('#999999'),
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: 'Revolution',
                                          style: GoogleFonts.montserrat(
                                              color: HexColor('#FA5805'),
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold)),
                                    ])),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DotsIndicator(
                            position: 2,
                            decorator:
                                DotsDecorator(activeColor: HexColor('#FA5805')),
                            dotsCount: 3,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                fixedSize: Size.fromWidth(200),
                                backgroundColor: HexColor('#FA5805'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Sign_up()));
                              },
                              child: Text('Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
