import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';

class Achieve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Achievements',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: Text(
              'See All',
              style: TextStyle(fontSize: 14, color: Colors.blue),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              CircleAvatar(
                radius: 150,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '21/05/2021',
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
            Row(
              children: [
                // Image.asset('asset/fe_1-removebg-preview 1.png',
                //     fit: BoxFit.cover),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .60),
                  child: Text(
                    'Best Sportsperson of the year',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.racingSansOne(
                      fontSize: 24,
                    ),
                  ),
                ),
                // SizedBox(width: 80),
                // Image.asset('asset/fe 2.png', fit: BoxFit.cover)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .8),
                child: ReadMoreText(
                  'Lorem ipsum dolor sit amet, consect adipiscing elit,sed do elusmod temp incididunt',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              )
            ]),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45),
              child: Row(
                children: [
                  Text(
                    '2 hours ago',
                    style: TextStyle(fontSize: 10, color: HexColor('#7D7D7D')),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      child: Center(child: Image.asset('asset/Vector.png'))),
                  Container(child: Image.asset('asset/Vector1.png')),
                  Container(child: Image.asset('asset/Vector2.png')),
                  SizedBox(width: 40)
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
