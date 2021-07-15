import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';

class Memories extends StatefulWidget {
  @override
  _MemoriesState createState() => _MemoriesState();
}

class _MemoriesState extends State<Memories> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Memories',
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
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return MemoryTile();
            },
          ),
        ),
      ),
    );
  }
}

class MemoryTile extends StatefulWidget {
  String content;
  String title;
  String coverUrl;
  @override
  _MemoryTileState createState() => _MemoryTileState();
}

class _MemoryTileState extends State<MemoryTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              child: Stack(
                children: [
                  SizedBox(
                    height: 451,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'asset/photo-1553770542-88bce0a2885c.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                    child: Container(
                      height: 451,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white.withOpacity(0.01),
                    ),
                  ),
                  Center(
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(6 / 360),
                      child: PhysicalModel(
                        shadowColor: Colors.grey,
                        color: Colors.grey,
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          height: 436.29,
                          width: 246.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 338.51,
                                width: 218.64,
                                child: Image.asset(
                                  'asset/photo-1553770542-88bce0a2885c.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                '11/01/21',
                                style: GoogleFonts.homemadeApple(
                                  fontSize: 36,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
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
              padding: const EdgeInsets.only(left: 45),
              child: Row(
                children: [
                  Text(
                    'Caption',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .8),
                child: ReadMoreText(
                  'Lorem ipsum dolor sit amet, consect adipiscing elit,sed do elusmod temp incididunt Lorem ipsum dolor sit amet, consect adipiscing elit,sed do elusmod temp incididunt',
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
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
