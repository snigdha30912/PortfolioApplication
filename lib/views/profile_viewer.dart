import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/views/home.dart';
import 'package:final_app/views/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../database.dart';
import '../shared_preferences.dart';

class ProfileViewer extends StatefulWidget {
  @override
  _ProfileViewerState createState() => _ProfileViewerState();
}

class _ProfileViewerState extends State<ProfileViewer> {
  File _image;
  final picker = ImagePicker();
  String currentUserName;
  String fullName = "";
  String phoneNumber = "";
  String tagline = "";

  @override
  void initState() {
    SharedPreference.getProfileImagePath().then((path) {
      if (path != null || path != "") {
        setState(() {
          _image = File(path);
        });
      }
    });
    SharedPreference.getUserName().then((value) {
      setState(() {
        currentUserName = value;
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserName)
          .get()
          .then((documentSnapshot) {
        setState(() {
          fullName = documentSnapshot.data()['fullname'];
          debugPrint("fullname : " + fullName);
          phoneNumber = documentSnapshot.data()['phoneNumber'];
          debugPrint("userPhone : " + phoneNumber);
          tagline = documentSnapshot.data()['tagline'];
          debugPrint("tagline : " + tagline);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 1,
              color: HexColor('#C4C4C4'),
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: Stack(
                children: [
                  Container(
                      width: 370,
                      height: 270,
                      child: _image == null
                          ? Image.asset(
                              'asset/default-profile-image.jpg',
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                            )),

                  // !show
                  //     ? SizedBox.shrink()
                  //     : Positioned(
                  //         top: 80,
                  //         bottom: 80,
                  //         left: 120,
                  //         right: 120,
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(20),
                  //             bottomLeft: Radius.circular(0),
                  //             bottomRight: Radius.circular(20),
                  //             topRight: Radius.circular(20),
                  //           ),
                  //           child: Opacity(
                  //             opacity: 0.8,
                  //             child: Container(
                  //               color: Colors.black,
                  //               height: 50,
                  //               width: 50,
                  //               child: Column(
                  //                 children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(
                  //                         top: 10, left: 12),
                  //                     child: Row(
                  //                       children: [
                  //                         Text(
                  //                           'Change Photo',
                  //                           style: TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 15),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(
                  //                         top: 5, right: 5),
                  //                     child: Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceAround,
                  //                       children: [
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(2.0),
                  //                           child: Column(
                  //                             children: [
                  //                               IconButton(
                  //                                   icon: Icon(
                  //                                     Icons.camera_alt,
                  //                                     size: 40,
                  //                                     color: Colors.white,
                  //                                   ),
                  //                                   onPressed: () {
                  //                                     setState(() {
                  //                                       show = true;
                  //                                     });
                  //                                   }),
                  //                               Text(
                  //                                 'Camera',
                  //                                 style: TextStyle(
                  //                                     color: Colors.white,
                  //                                     fontSize: 12),
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(2.0),
                  //                           child: Column(
                  //                             children: [
                  //                               IconButton(
                  //                                   icon: Icon(
                  //                                     CupertinoIcons.photo,
                  //                                     size: 37,
                  //                                     color: Colors.white,
                  //                                   ),
                  //                                   onPressed: () {}),
                  //                               Text(
                  //                                 'Gallery',
                  //                                 style: TextStyle(
                  //                                     color: Colors.white,
                  //                                     fontSize: 12),
                  //                               )
                  //                             ],
                  //                           ),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.file_download,
                      color: HexColor('#747373'),
                      size: 30,
                    ),
                    onPressed: () {}),
                IconButton(
                  icon: Icon(
                    CupertinoIcons.arrowshape_turn_up_right_fill,
                    color: HexColor('#747373'),
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage("", "")));
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(fullName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            Text(tagline, style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 20,
            ),
            Text(currentUserName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            SizedBox(
              height: 10,
            ),
            Text(phoneNumber,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            SizedBox(
              height: 10,
            ),
            Text('whodoyouthinkyouare/snigsho',
                style: TextStyle(fontSize: 15, color: Colors.blue)),
          ]),
        ));
  }
}
