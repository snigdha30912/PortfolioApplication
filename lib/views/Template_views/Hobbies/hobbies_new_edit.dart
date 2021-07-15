import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_app/views/Template_views/template_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'hobbies_new_post.dart';

class Hobbies_New_Edit extends StatefulWidget {
  String username, hobbyName, hobbyRef;
  Hobbies_New_Edit(this.username, this.hobbyName, this.hobbyRef);
  @override
  _Hobbies_New_EditState createState() => _Hobbies_New_EditState();
}

class _Hobbies_New_EditState extends State<Hobbies_New_Edit> {
  File imageFile1;
  bool isLoading = false;
  TextEditingController coverEC = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              height: 85,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: HexColor('#626060'),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text('Edit',
                      style: TextStyle(
                        color: HexColor('#000000'),
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                      )),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: HexColor('#34B3FC'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            onPressed: () {
                              if (coverEC.text.length > 0) {
                                setState(() {
                                  isLoading = true;
                                });
                                // upload text
                                FirebaseFirestore.instance
                                    .collection("templates")
                                    .doc(widget.username)
                                    .collection("hobbies")
                                    .doc(widget.hobbyRef)
                                    .collection("folders")
                                    .add({"cover-title": coverEC.text}).then(
                                        (docRef) {
                                  if (imageFile1 != null) {
                                    // upload image
                                    TemplateDatabase.uploadImageToStorage(
                                            imageFile1,
                                            "Templates/${widget.username}/Hobbies/${widget.hobbyRef}/${coverEC.text}.jpg")
                                        .then((value) {
                                      TemplateDatabase.getImageUrl(
                                              "Templates/${widget.username}/Hobbies/${widget.hobbyRef}/${coverEC.text}.jpg")
                                          .then((value) {
                                        docRef.update({
                                          'coverImageURL': value,
                                        });
                                      });

                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    }).catchError((e) {
                                      print(e.toString());
                                    });
                                  }
                                });
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            )),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              color: HexColor('#C4C4C4'),
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Hobby Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Container(
                  // height: 38,
                  width: 245,
                  child: Center(
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          labelText: widget.hobbyName,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Create Folder In The Hobby:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            imageFile1 == null
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 1,
                            offset: Offset(0, 5),
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: GestureDetector(
                      onTap: () {
                        _getFromGallery1();
                      },
                      child: Center(
                        child: Text(
                          '        +\nAdd Folder\n    Cover',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                    height: 164,
                    width: 175,
                  )
                : Container(
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 1,
                                  offset: Offset(0, 5),
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              imageFile1,
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: 164,
                          width: 175,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _getFromGallery1();
                                },
                                child: Text(
                                  'Change Cover',
                                  style: TextStyle(
                                      color: HexColor('#34B3FC'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        content: Container(
                                          height: 233,
                                          width: 246,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  'Are you sure you want to delete \nthis folder?',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                width: 70,
                                                height: 33,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Don't Delete",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 33,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.7),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Cover Title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Container(
                  // height: 38,
                  width: 245,
                  child: Center(
                    child: TextFormField(
                      controller: coverEC,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                )
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 25, right: 25),
            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       itemCount: 3,
            //       itemBuilder: (context, i) {
            //         return Column(
            //           children: [
            //             Card(
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(
            //                   20,
            //                 ),
            //               ),
            //               elevation: 3,
            //               child: Column(
            //                 children: [
            //                   SizedBox(
            //                     height: 15,
            //                   ),
            //                   PhysicalModel(
            //                     borderRadius: BorderRadius.circular(20),
            //                     elevation: 05,
            //                     shadowColor: Colors.grey,
            //                     color: Colors.black,
            //                     child: Container(
            //                       height: 400,
            //                       width: 325,
            //                       child: ClipRRect(
            //                         borderRadius: BorderRadius.circular(
            //                           22,
            //                         ),
            //                         child: Image.asset(
            //                           'asset/d2733fa30b203f8d7f44d230c2c769a5.jpg',
            //                           fit: BoxFit.fill,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: 10,
            //                   ),
            //                   Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceAround,
            //                     children: [
            //                       Text(
            //                         '2 hours ago',
            //                         style:
            //                             TextStyle(color: HexColor('#747373')),
            //                       ),
            //                       SizedBox(width: 1),
            //                       DotsIndicator(
            //                         mainAxisSize: MainAxisSize.min,
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         dotsCount: 5,
            //                         decorator: DotsDecorator(
            //                             spacing: EdgeInsets.all(2),
            //                             color: HexColor('#C4C4C4'),
            //                             activeColor: Colors.black),
            //                       ),
            //                     ],
            //                   ),
            //                   SizedBox(
            //                     height: 20,
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 30),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           'Captions',
            //                           style: TextStyle(
            //                               fontSize: 20,
            //                               fontWeight: FontWeight.bold),
            //                         ),
            //                         SizedBox(
            //                           height: 10,
            //                         ),
            //                         Text(
            //                           'An elegant trendy dark background with geometric patterns, simple and clear navigation - this is what a  modern portfolio should look like!',
            //                           textAlign: TextAlign.start,
            //                         ),
            //                         SizedBox(
            //                           height: 15,
            //                         ),
            //                         Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.start,
            //                           children: [
            //                             CircleAvatar(
            //                               radius: 15,
            //                               backgroundColor: HexColor('#848E94')
            //                                   .withOpacity(.66),
            //                               child: Icon(
            //                                 Icons.favorite,
            //                                 color: Colors.white,
            //                                 size: 22,
            //                               ),
            //                             ),
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   top: 15, left: 2),
            //                               child: Text(
            //                                 '26',
            //                                 style: TextStyle(
            //                                     fontSize: 12,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                             SizedBox(width: 20),
            //                             GestureDetector(
            //                               onTap: () {
            //                                 comment(context);
            //                               },
            //                               child: CircleAvatar(
            //                                 radius: 15,
            //                                 backgroundColor: HexColor('#848E94')
            //                                     .withOpacity(.66),
            //                                 child: Icon(
            //                                   FontAwesome.comment,
            //                                   size: 22,
            //                                   color: Colors.white,
            //                                 ),
            //                               ),
            //                             ),
            //                             Padding(
            //                               padding: const EdgeInsets.only(
            //                                   top: 15, left: 2),
            //                               child: Text(
            //                                 '26',
            //                                 style: TextStyle(
            //                                     fontSize: 12,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ),
            //                             SizedBox(width: 20),
            //                             CircleAvatar(
            //                               radius: 15,
            //                               backgroundColor: HexColor('#848E94')
            //                                   .withOpacity(.66),
            //                               child: Icon(
            //                                 FontAwesome.share,
            //                                 size: 22,
            //                                 color: Colors.white,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         SizedBox(
            //                           height: 20,
            //                         ),
            //                       ],
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //             SizedBox(height: 40),
            //           ],
            //         );
            //       }),
            // ),
          ],
        ),
      )),
    );
  }

  _getFromGallery1() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile1 = File(pickedFile.path);
      });
    }
  }

  Future<void> comment(BuildContext context) {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .8),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 40, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.only(bottom: 10),
                          shrinkWrap: true,
                          itemCount: 6,
                          itemBuilder: (BuildContext, int i) {
                            return i == 0
                                ? Center(
                                    child: Text(
                                      'Comments',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Image.asset(
                                                'asset/pexels-photo-2379004.jpeg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Ashley Spencer',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Spacer(),
                                          Text(
                                            '2 min',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 60),
                                        child: Container(
                                          child: Text(
                                              'Amazing job Jason! Love the colors! The golden color is mesmerizing!'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  );
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // height: 38,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              hintText: 'Add A Comment...',
                              suffixIcon: Icon(
                                Icons.send,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
