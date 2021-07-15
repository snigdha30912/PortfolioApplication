import 'dart:developer';
import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_app/views/chat_views/chat_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'achievement.dart';
import 'memories.dart';
import '../profile_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'Hobbies/hobbies_new_edit.dart';
import 'Hobbies/hobbies_self_vew.dart';
import 'gallery_exist_edit.dart';
import 'gallery_new_edit.dart';

class Home extends StatefulWidget {
  final String para;
  Home({this.para});
  @override
  _HomeState createState() => _HomeState();
}

CarouselController buttonCarouselController = CarouselController();
double _currentSliderValue = 0.0;

class _HomeState extends State<Home> {
  final picker = ImagePicker();
  File _image1;
  Color _color = Colors.white;
  bool show = false;
  bool status = false;
  bool status1 = false;
  List albums = [
    {
      'link':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80',
      'rotate': true
    },
    {
      'link':
          'https://images.unsplash.com/photo-1557296387-5358ad7997bb?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXRzfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
      'rotate': false
    },
    {
      'link':
          'https://i.pinimg.com/236x/a3/ac/1e/a3ac1ed5abaedffd9947face7901e14c.jpg',
      'rotate': true
    },
    {
      'link':
          'https://www.worldphoto.org/sites/default/files/default-media/Nova.jpg',
      'rotate': false
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChatHomeScreen()));
                      },
                    ),
                    PhysicalModel(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      shadowColor: Colors.black,
                      color: HexColor('#484848'),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.only(top: 5, left: 8),
                            child: Text(
                              '250 Subscribers',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            color: HexColor('#484848'),
                            height: 31.8,
                            width: 159,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => Intro1()));
                      },
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 84,
                color: Colors.black,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProfilePage("", "")));
                        },
                        child: Container(
                          width: 65,
                          height: 70,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: .5, color: Colors.white),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Image.asset(
                                'asset/pexels-photo-1704488.jpeg',
                                width: 80,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shubham Kumar',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          ),
                          // Container(
                          //   height: 2,
                          //   width: 115,
                          //   color: Colors.grey,
                          // ),
                          SizedBox(height: 5),
                          Text(
                            'Work from home is...',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 75),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              show = !show;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: .5,
                width: MediaQuery.of(context).size.width,
              ),
              Card(
                shadowColor: Colors.grey,
                margin: EdgeInsets.only(left: 0, right: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70),
                    bottomLeft: Radius.circular(70),
                  ),
                ),
                elevation: 10,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(70),
                          bottomLeft: Radius.circular(70)),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 550,
                          child: _image1 == null
                              ? Container()
                              // Image.asset(
                              //     'asset/pexels-photo-1704488.jpeg',
                              //     width: MediaQuery.of(context).size.width,
                              //     fit: BoxFit.cover,
                              //   )
                              : Image.file(
                                  _image1,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    !show
                        ? SizedBox.shrink()
                        : Positioned(
                            top: 5,
                            right: 12,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Opacity(
                                opacity: 0.7,
                                child: Container(
                                  color: Colors.black,
                                  height: 60,
                                  width: 60,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        status = !status;
                                        status1 = !status1;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    !status
                        ? SizedBox.shrink()
                        : Positioned(
                            top: 230,
                            left: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                              child: Opacity(
                                opacity: 0.7,
                                child: Container(
                                  color: Colors.black,
                                  height: 110,
                                  width: 210,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Change Photo',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.camera_alt,
                                                        size: 40,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        _imgFromCamera();
                                                      }),
                                                  Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Column(
                                                children: [
                                                  IconButton(
                                                      icon: Icon(
                                                        CupertinoIcons.photo,
                                                        size: 37,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        _imgFromGallery();
                                                      }),
                                                  Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 37,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        status = !status;
                                                      });
                                                    }),
                                                Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                    status || !status1
                        ? SizedBox.shrink()
                        : Positioned(
                            top: 230,
                            left: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                              child: Opacity(
                                opacity: 0.7,
                                child: Container(
                                  color: Colors.black,
                                  height: 110,
                                  width: 210,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Remove Photo',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Column(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        _image1 = null;
                                                        status1 = !status1;
                                                      });
                                                    },
                                                    child: Text(
                                                      'Remove',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Column(
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        status1 = !status1;
                                                      });
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DotsIndicator(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                dotsCount: 5,
                decorator: DotsDecorator(
                    spacing: EdgeInsets.all(2),
                    color: HexColor('#484848'),
                    activeColor: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  height: 60,
                  width: 135,
                  color: HexColor('#484848'),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 35,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                FontAwesome5Solid.user_clock,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Home',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Thoughts',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(context,
                  //               MaterialPageRoute(builder: (_) => Achieve()));
                  //         },
                  //         child: Column(children: [
                  // Icon(
                  //   Icons.home,
                  //   color: Colors.white,
                  //   size: 40,
                  // ),
                  // Text(
                  //   'Home',
                  //   style:
                  //       TextStyle(color: Colors.white, fontSize: 11),
                  // ),
                  //         ]),
                  //       ),
                  //       GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(context,
                  //               MaterialPageRoute(builder: (_) => Memories()));
                  //         },
                  //         child: Column(
                  //           children: [
                  // Icon(
                  //   FontAwesome5Solid.user_clock,
                  //   color: Colors.white,
                  //   size: 30,
                  // ),
                  //             SizedBox(
                  //               height: 5,
                  //             ),
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  // Text(
                  //   'Thoughts',
                  //   style: TextStyle(
                  //       color: Colors.white, fontSize: 11),
                  // ),
                  //               ],
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    !show
                        ? SizedBox(
                            height: 20,
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                show = !show;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                  ],
                ),
              ),
              Text(
                'Business Contractor',
                style: TextStyle(
                    color: HexColor('#C39317'),
                    fontSize: 31,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'About',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    !show
                        ? SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                show = !show;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  child: Text(
                    'An elegant trendy dark background with geometric patterns, simple and clear navigation - this is what a modern portfolio should look like!',
                  ),
                ),
              ),
              SizedBox(height: 30),
              widget.para == 'one'
                  ? SizedBox.shrink()
                  : Card(
                      color: HexColor('#E5E5E5'),
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          45,
                        ),
                      ),
                      elevation: 5,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hobbies',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          !show
                              ? SizedBox.shrink()
                              : TextButton(
                                  style: TextButton.styleFrom(
                                    fixedSize: Size(147, 27),
                                    backgroundColor: HexColor('#34B3FC'),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(300)),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40.0),
                                              topRight: Radius.circular(40.0)),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            // height: 500,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                // mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Spacer(
                                                      // flex: 2,
                                                      ),
                                                  const Text(
                                                    'Create A Hobby',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.blue),
                                                  ),
                                                  Spacer(
                                                      // flex: 2,
                                                      ),
                                                  Text(
                                                    'Hobby Name',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    height: 38,
                                                    width: 245,
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15))),
                                                    ),
                                                  ),
                                                  Spacer(
                                                    flex: 3,
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    color: Colors.black
                                                        .withOpacity(.30),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    '+ Add Hobby',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                          SizedBox(
                            height: 5,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: 2,
                            //   childAspectRatio: 155 / 160,
                            // ),
                            itemCount: 5,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Travelling',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              show = !show;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          Hobbies_Self_View(
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "")));
                                            });
                                          },
                                          child: !show
                                              ? SizedBox.shrink()
                                              : Icon(
                                                  Icons.edit,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: 230,
                                    child: ListView.builder(
                                        itemCount: 3,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i) {
                                          return
                                              // !show
                                              //     ? SizedBox.shrink()
                                              //     :
                                              i == 0
                                                  ? !show
                                                      ? SizedBox.shrink()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 40,
                                                            bottom: 90,
                                                            left: 30,
                                                          ),
                                                          child: PhysicalModel(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: Colors.white,
                                                            elevation: 5,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                width: 120,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (_) => Hobbies_New_Edit(
                                                                                "",
                                                                                "",
                                                                                "")));
                                                                  },
                                                                  child: Center(
                                                                    child: Text(
                                                                      '+ Add Folder',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .blue,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30,
                                                              top: 10),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 25),
                                                            height: 180,
                                                            width: 220,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        25.0,
                                                                      ),
                                                                      boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey,
                                                                      blurRadius:
                                                                          5.0,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              7),
                                                                      spreadRadius:
                                                                          0.1,
                                                                    ),
                                                                  ]),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  25.0,
                                                                ),
                                                                child:
                                                                    Image.asset(
                                                                  'asset/download (1).jpg',
                                                                  width: 160,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Baseline(
                                                            baselineType:
                                                                TextBaseline
                                                                    .alphabetic,
                                                            baseline: -20,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              child: Container(
                                                                child: Card(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      12.0,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      AbsorbPointer(
                                                                    child:
                                                                        TextField(
                                                                      enabled:
                                                                          true,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            'Places',
                                                                        enabledBorder:
                                                                            InputBorder.none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  elevation: 5,
                                                                ),
                                                                height: 50,
                                                                width: 120,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    12.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                        }),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 40),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Gallery / Albums',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              !show
                  ? SizedBox.shrink()
                  : TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: Size(147, 27),
                        backgroundColor: HexColor('#34B3FC'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(300)),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Gallery_New_Edit()));
                      },
                      child: Text(
                        '+ Add Gallery',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
              Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 220),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                Gallery_Exist_Edit()));
                                    show = !show;
                                  });
                                },
                                child: !show
                                    ? SizedBox.shrink()
                                    : Icon(
                                        Icons.edit,
                                        size: 40,
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Stack(
                              children: [
                                RotationTransition(
                                  turns: i % 2 == 0
                                      ? AlwaysStoppedAnimation(0.0)
                                      : AlwaysStoppedAnimation(15 / 360),
                                  child: CarouselSlider(
                                    items: albums.map((e) {
                                      return Container(
                                        height: 461.48,
                                        width: 296.19,
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 25.0,
                                            offset: Offset(15, -5),
                                            spreadRadius: -10,
                                          ),
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 25.0,
                                            offset: Offset(15, 45),
                                            spreadRadius: -10,
                                          ),
                                        ]),
                                        child: Image.network(
                                          e['link'],
                                        ),
                                      );
                                    }).toList(),
                                    carouselController:
                                        buttonCarouselController,
                                    options: CarouselOptions(
                                      height: 380,
                                      autoPlay: false,
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: false,
                                      scrollPhysics:
                                          NeverScrollableScrollPhysics(),
                                      viewportFraction: 0.9,
                                      aspectRatio: 2.0,
                                      initialPage: 0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Row(
                                      children: [
                                        // IconButton(
                                        //   onPressed: () {
                                        //     buttonCarouselController.previousPage(
                                        //         duration:
                                        //             Duration(milliseconds: 300),
                                        //         curve: Curves.linear);

                                        //     if (_currentSliderValue-- > 0) {
                                        //       setState(() {});
                                        //     } else {
                                        //       _currentSliderValue++;
                                        //     }
                                        //   },
                                        //   icon: Icon(
                                        //     Icons.arrow_back_ios,
                                        //   ),
                                        // ),

                                        PhysicalModel(
                                          shadowColor: Colors.grey,
                                          elevation: 5,
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                          child: CircleAvatar(
                                            backgroundColor: _color,
                                            radius: 14,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 1, left: 8),
                                              child: GestureDetector(
                                                onTap: () {
                                                  buttonCarouselController
                                                      .nextPage(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          curve: Curves.linear);
                                                  if (_currentSliderValue++ <
                                                      3) {
                                                    setState(() {});
                                                  } else {
                                                    _currentSliderValue--;
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.arrow_back_ios,
                                                  size: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        PhysicalModel(
                                          shadowColor: Colors.grey,
                                          elevation: 5,
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                          child: CircleAvatar(
                                            backgroundColor: _color,
                                            radius: 14,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 1, left: 3),
                                              child: GestureDetector(
                                                onTap: () {
                                                  buttonCarouselController
                                                      .previousPage(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          curve: Curves.linear);

                                                  if (_currentSliderValue-- >
                                                      0) {
                                                    setState(() {});
                                                  } else {
                                                    _currentSliderValue++;
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // IconButton(
                                        //   onPressed: () {
                                        //     buttonCarouselController.nextPage(
                                        //         duration:
                                        //             Duration(milliseconds: 300),
                                        //         curve: Curves.linear);
                                        //     if (_currentSliderValue++ < 3) {
                                        //       setState(() {});
                                        //     } else {
                                        //       _currentSliderValue--;
                                        //     }
                                        //   },
                                        //   icon: Icon(
                                        //     Icons.arrow_forward_ios,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Slider(
                                inactiveColor: Colors.black,
                                activeColor: Colors.black,
                                value: _currentSliderValue,
                                min: 0,
                                max: 3,
                                divisions: 3,
                                label: (_currentSliderValue + 1)
                                        .round()
                                        .toString() +
                                    '/ 4',
                                onChanged: (double value) {
                                  buttonCarouselController
                                      .jumpToPage(_currentSliderValue.toInt());
                                  setState(() {
                                    _currentSliderValue = value;
                                  });
                                },
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            // PhysicalModel(
                            //   shadowColor: Colors.grey,
                            //   elevation: 5,
                            //   shape: BoxShape.circle,
                            //   color: Colors.grey,
                            //   child: CircleAvatar(
                            //     backgroundColor: _color,
                            //     radius: 14,
                            //     child: Container(
                            //       padding:
                            //           EdgeInsets.only(bottom: 1, left: 8),
                            //       child: Icon(
                            //         Icons.arrow_back_ios,
                            //         size: 18,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            //     Container(
                            // decoration: BoxDecoration(boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey,
                            //     blurRadius: 25.0,
                            //     offset: Offset(15, -5),
                            //     spreadRadius: -10,
                            //   ),
                            //   BoxShadow(
                            //     color: Colors.grey,
                            //     blurRadius: 25.0,
                            //     offset: Offset(15, 45),
                            //     spreadRadius: -10,
                            //   ),
                            // ]),
                            //       height: 457,
                            //       width: 296.41,
                            //       child: Image.asset(
                            //           'asset/5c3fd9952bbd0235c4911da8d9fdac5e.webp'),
                            //     ),
                            // PhysicalModel(
                            //   shadowColor: Colors.grey,
                            //   elevation: 5,
                            //   shape: BoxShape.circle,
                            //   color: Colors.grey,
                            //   child: CircleAvatar(
                            //     backgroundColor: _color,
                            //     radius: 14,
                            //     child: Container(
                            //       padding:
                            //           EdgeInsets.only(bottom: 1, left: 3),
                            //       child: Icon(
                            //         Icons.arrow_forward_ios,
                            //         size: 18,
                            //         color: Colors.black,
                            //       ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                      itemCount: 4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image1 = File(pickedFile.path);
      show = !show;
      status1 = !status1;
      status = !status;
    });
    _cropImage(pickedFile.path);
  }

  Future _imgFromGallery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);

    setState(() {
      _image1 = File(pickedFile.path);
      show = !show;
      status1 = !status1;
      status = !status;
    });
    _cropImage(pickedFile.path);
  }

  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    if (croppedImage != null) {
      _image1 = croppedImage;
      setState(() {});
    }
  }
}
