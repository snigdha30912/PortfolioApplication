import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'intro3.dart';

class Intro2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 0) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Intro3()));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 300,
                        child: Image.asset(
                          'asset/Group 756.png',
                          fit: BoxFit.cover,
                          height: 250,
                          width: 250,
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
                                    text: 'Connect ',
                                    style: GoogleFonts.montserrat(
                                        color: HexColor('#FA5805'),
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        text: 'with\n amazing people\n',
                                        style: GoogleFonts.montserrat(
                                            color: HexColor('#999999'),
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: 'around you.',
                                        style: GoogleFonts.montserrat(
                                            color: HexColor('#999999'),
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                      )
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
                            position: 1,
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
                              onPressed: () {},
                              child: Text('Skip',
                                  style: TextStyle(
                                      color: HexColor('#FA5805'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          TextButton(
                              style: TextButton.styleFrom(
                                fixedSize: Size.fromWidth(100),
                                backgroundColor: HexColor('#FA5805'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Intro3()));
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
