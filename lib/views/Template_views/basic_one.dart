import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_app/views/Authentication_Views/intro1.dart';
import 'package:final_app/views/Template_views/Hobbies/hobbies_exist_edit.dart';
import 'package:final_app/views/Template_views/template_database.dart';
import 'package:final_app/views/imageutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../../database.dart';
import '../../shared_preferences.dart';
import '../home.dart';
import '../profile_page.dart';
import 'Albums/gallery_exist_edit.dart';
import 'Albums/gallery_new_edit.dart';
import 'Hobbies/hobbies_new_edit.dart';
import 'Hobbies/hobbies_self_vew.dart';
import 'achievement.dart';
import 'image_from_network.dart';
import 'memories.dart';

const Color _color = Colors.white;

class BasicOne extends StatefulWidget {
  final int type;
  final String currentUserName;
  final String templateUserName;
  BasicOne({this.currentUserName, this.templateUserName, this.type});
  @override
  _BasicOneState createState() => _BasicOneState();
}

class _BasicOneState extends State<BasicOne> {
  final picker = ImagePicker();
  bool show = false;
  bool status = false;
  bool status1 = false;
  File profileImage;
  File coverImage;
  File coverImageEdit;
  String coverImageUrl;
  bool editAbout = false;
  bool doesNotExist = false;
  DocumentSnapshot<dynamic> userDataSnapshot;
  DocumentSnapshot<dynamic> templateDataSnapshot;
  QuerySnapshot<dynamic> hobbiesDataSnapshot;
  QuerySnapshot<dynamic> memoriesDataSnapshot;
  QuerySnapshot<dynamic> albumsDataSnapshot;
  Stream hobbiesStream;
  Map<String, TextEditingController> textControllers = {
    "about": new TextEditingController(),
    "designation": new TextEditingController(),
  };

  @override
  void initState() {
    TemplateDatabase.getImageUrl(
            "Templates/${widget.templateUserName}/cover.jpg")
        .then((value) {
      setState(() {
        coverImageUrl = value;
      });
    });
    TemplateDatabase.getHobbies(widget.templateUserName).then((snapshots) {
      setState(() {
        hobbiesStream = snapshots;
        debugPrint(snapshots.toString());
        print("we got the data + ${hobbiesStream.toString()}");
      });
    });
    TemplateDatabase.getTemplateData(widget.templateUserName).then((value) {
      setState(() {
        templateDataSnapshot = value;
        if (templateDataSnapshot.data() == null) {
          if (widget.currentUserName != widget.templateUserName) {
            setState(() {
              doesNotExist = true;
            });
          } else {
            TemplateDatabase.createTemplate(
                    widget.templateUserName, widget.type)
                .then((value) {
              TemplateDatabase.getTemplateData(widget.templateUserName)
                  .then((value) {
                setState(() {
                  templateDataSnapshot = value;
                  textControllers["about"].text =
                      templateDataSnapshot.data()["about"];
                  textControllers["designation"].text =
                      templateDataSnapshot.data()["designation"];
                  debugPrint(
                      "hereeeeeeeeee" + templateDataSnapshot.data().toString());
                });
              });
            });
          }
        } else {
          setState(() {
            textControllers["about"].text =
                templateDataSnapshot.data()["about"];
            textControllers["designation"].text =
                templateDataSnapshot.data()["designation"];
            debugPrint(
                "hereeeeeeeeee" + templateDataSnapshot.data().toString());
          });
        }
      });
    });
    TemplateDatabase.getMemoriesData(widget.templateUserName).then((value) {
      setState(() {
        memoriesDataSnapshot = value;
        debugPrint(memoriesDataSnapshot.toString());
      });
    });
    TemplateDatabase.getAlbumsData(widget.templateUserName).then((value) {
      setState(() {
        albumsDataSnapshot = value;
        debugPrint(albumsDataSnapshot.toString());
      });
    });
    TemplateDatabase.getUserData(widget.templateUserName).then((value) {
      setState(() {
        userDataSnapshot = value;
        debugPrint(userDataSnapshot.data().toString());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("heree madafakaaa" +
    //     userDataSnapshot.toString() +
    //     userDataSnapshot.data().toString() +
    //     templateDataSnapshot.toString() +
    //     templateDataSnapshot.data().toString());
    return Scaffold(
        backgroundColor: Colors.white,
        body: doesNotExist
            ? Center(child: Icon(Icons.auto_delete, size: 200))
            : userDataSnapshot == null ||
                    templateDataSnapshot == null ||
                    userDataSnapshot.data() == null ||
                    templateDataSnapshot.data() == null
                ? Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: SingleChildScrollView(
                        child: Column(children: [
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
                                      builder: (_) => HomeScreen()));
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
                                    templateDataSnapshot
                                                .data()["subscribers"]
                                                .toString() ==
                                            null
                                        ? "null"
                                        : templateDataSnapshot
                                                .data()["subscribers"]
                                                .toString() +
                                            " subscribers",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
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
                                        builder: (_) => ProfilePage(
                                            widget.currentUserName,
                                            userDataSnapshot.data()["dpURL"])));
                              },
                              child: Container(
                                width: 65,
                                height: 70,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: .5, color: Colors.white),
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
                                      child: userDataSnapshot.data()["dpURL"] !=
                                              null
                                          ? Image.network(
                                              userDataSnapshot.data()["dpURL"])
                                          : Image.asset("asset/default.png")),
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
                                  userDataSnapshot.data()["fullname"] == null
                                      ? "null"
                                      : userDataSnapshot.data()["fullname"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  userDataSnapshot.data()["tagline"] == null
                                      ? "null"
                                      : userDataSnapshot.data()["tagline"],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 75),
                              child: widget.currentUserName ==
                                      widget.templateUserName
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          show = !show;
                                          !show
                                              ? Fluttertoast.showToast(
                                                  msg: "Editing disabled",
                                                  toastLength:
                                                      Toast.LENGTH_LONG)
                                              : Fluttertoast.showToast(
                                                  msg: "Editing enabled",
                                                  toastLength:
                                                      Toast.LENGTH_LONG);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    )
                                  : SizedBox.shrink(),
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
                                child: coverImageUrl == null
                                    ? Image.asset(
                                        'asset/default.png',
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        coverImageUrl,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                          imageEdit()
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
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        padding: EdgeInsets.only(right: 3, top: 3, left: 5),
                        height: 60,
                        width: 150,
                        color: HexColor('#484848'),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Achieve()));
                                },
                                child: Column(children: [
                                  Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11),
                                  ),
                                ]),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Memories()));
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Thoughts',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ]),
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
                                                    'Edit Designation',
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
                                                    'Enter Text',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: 245,
                                                    child: TextField(
                                                      controller:
                                                          textControllers[
                                                              "designation"],
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
                                                  TextButton(
                                                    onPressed: () {
                                                      if (textControllers[
                                                                  "designation"]
                                                              .text
                                                              .length >
                                                          0) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "templates")
                                                            .doc(widget
                                                                .templateUserName)
                                                            .update({
                                                          "designation":
                                                              textControllers[
                                                                      "designation"]
                                                                  .text,
                                                        }).catchError((e) {
                                                          print(e.toString());
                                                        });
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Submit',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                    ),
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
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
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
                                  icon: Icon(
                                    Icons.edit,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      textControllers["designation"].text,
                      style: TextStyle(
                          color: HexColor('#C39317'),
                          fontSize: 31,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: 100),
                          Text(
                            'About',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: !show
                                ? SizedBox(
                                    width: 40,
                                  )
                                : IconButton(
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40.0),
                                                topRight:
                                                    Radius.circular(40.0)),
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
                                                      'Edit About',
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
                                                      'Enter Text',
                                                      style: TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      width: 245,
                                                      child: TextField(
                                                        controller:
                                                            textControllers[
                                                                "about"],
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
                                                    TextButton(
                                                      onPressed: () {
                                                        if (textControllers[
                                                                    "about"]
                                                                .text
                                                                .length >
                                                            0) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "templates")
                                                              .doc(widget
                                                                  .templateUserName)
                                                              .update({
                                                            "about":
                                                                textControllers[
                                                                        "about"]
                                                                    .text,
                                                          }).catchError((e) {
                                                            print(e.toString());
                                                          });
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Submit',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                      ),
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
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
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
                                    icon: Icon(
                                      Icons.edit,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          textControllers["about"].text,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    widget.type == 2 ? SizedBox(height: 30) : SizedBox.shrink(),
                    widget.type == 2 ? hobbies() : SizedBox.shrink(),
                    Gallery(show, widget.templateUserName),
                  ]))));
  }

  Widget imageEdit() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
        !show || !status
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
                            padding: const EdgeInsets.only(top: 10, left: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Change Photo',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.camera_alt,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            ImageUtil()
                                                .imgFromCamera()
                                                .then((value) async {
                                              if (value != null) {
                                                setState(() {
                                                  coverImageEdit = value;
                                                  show = !show;
                                                  status = !status;
                                                  status1 = !status1;
                                                });
                                                TemplateDatabase
                                                        .uploadImageToStorage(
                                                            coverImageEdit,
                                                            "Templates/${widget.templateUserName}/cover.jpg")
                                                    .then((value) {
                                                  TemplateDatabase.getImageUrl(
                                                          "Templates/${widget.templateUserName}/cover.jpg")
                                                      .then((value) {
                                                    FirebaseFirestore.instance
                                                        .collection('templates')
                                                        .doc(widget
                                                            .templateUserName)
                                                        .update({
                                                      'coverURL': value,
                                                    });
                                                  });
                                                });
                                              }
                                            });
                                          }),
                                      Text(
                                        'Camera',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            CupertinoIcons.photo,
                                            size: 37,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            ImageUtil()
                                                .imgFromGallery()
                                                .then((value) async {
                                              if (value != null) {
                                                setState(() {
                                                  coverImageEdit = value;
                                                  show = !show;
                                                  status = !status;
                                                  status1 = !status1;
                                                });
                                                TemplateDatabase
                                                    .uploadImageToStorage(
                                                        coverImageEdit,
                                                        "Templates/${widget.templateUserName}/cover.jpg");
                                                TemplateDatabase.getImageUrl(
                                                        "Templates/${widget.templateUserName}/cover.jpg")
                                                    .then((value) {
                                                  setState(() {
                                                    coverImageUrl = value;
                                                  });
                                                });
                                              }
                                            });
                                          }),
                                      Text(
                                        'Gallery',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
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
                                          color: Colors.white, fontSize: 12),
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
        (status || !status1)
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Remove Photo',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            coverImageEdit = null;
                                            status1 = !status1;
                                          });
                                        },
                                        child: Text(
                                          'Remove',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
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
                                          style: TextStyle(color: Colors.white),
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
    ));
  }

  bool showHobbiesEdit = true;
  Widget hobbies() {
    return Card(
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                        borderRadius: BorderRadius.circular(300)),
                  ),
                  onPressed: () {
                    TextEditingController ted = new TextEditingController();
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                // mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Spacer(
                                      // flex: 2,
                                      ),
                                  const Text(
                                    'Create A Hobby',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.blue),
                                  ),
                                  Spacer(
                                      // flex: 2,
                                      ),
                                  Text(
                                    'Hobby Name',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 38,
                                    width: 245,
                                    child: TextField(
                                      controller: ted,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 3,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (ted.text.length > 0) {
                                        FirebaseFirestore.instance
                                            .collection("templates")
                                            .doc(widget.templateUserName)
                                            .collection("hobbies")
                                            .add({
                                          "name": ted.text,
                                        }).catchError((e) {
                                          print(e.toString());
                                        });
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black.withOpacity(.30),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
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
          StreamBuilder(
              stream: hobbiesStream,
              builder: (context, snapshot) {
                return snapshot.hasData && snapshot.data.docs.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        //   childAspectRatio: 155 / 160,
                        // ),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, i) {
                          return HobbieTile(
                              currentUserName: widget.currentUserName,
                              templateUserName: widget.templateUserName,
                              hobbyName: snapshot.data.docs[i].data()["name"],
                              hobbyRef: snapshot.data.docs[i].id,
                              show: show);
                        },
                      )
                    : Center(child: Text("Add a few hobbies"));
              }),
        ],
      ),
    );
  }
}

class HobbieTile extends StatefulWidget {
  String currentUserName;
  String templateUserName;
  String hobbyRef;
  String hobbyName;
  bool show;
  HobbieTile(
      {this.currentUserName,
      this.templateUserName,
      this.hobbyName,
      this.hobbyRef,
      this.show});
  @override
  _HobbieTileState createState() => _HobbieTileState();
}

class _HobbieTileState extends State<HobbieTile> {
  Stream folderStream;
  @override
  void initState() {
    TemplateDatabase.getFolder(widget.templateUserName, widget.hobbyRef)
        .then((snapshots) {
      setState(() {
        folderStream = snapshots;
        debugPrint("folderssssssssssssssssssss" + folderStream.toString());
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.hobbyName,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    TextEditingController ted = new TextEditingController();
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                // mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Spacer(
                                      // flex: 2,
                                      ),
                                  const Text(
                                    'Edit Hobby Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.blue),
                                  ),
                                  Spacer(
                                      // flex: 2,
                                      ),
                                  Text(
                                    'Hobby Name',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 38,
                                    width: 245,
                                    child: TextField(
                                      controller: ted,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 3,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (ted.text.length > 0) {
                                        FirebaseFirestore.instance
                                            .collection("templates")
                                            .doc(widget.templateUserName)
                                            .collection("hobbies")
                                            .doc(widget.hobbyRef)
                                            .update({
                                          "name": ted.text,
                                        }).catchError((e) {
                                          print(e.toString());
                                        });
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.black.withOpacity(.30),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  });
                },
                child: !widget.show
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
          child: StreamBuilder(
              stream: folderStream,
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length + 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return i == 0
                          ? !widget.show
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(
                                    top: 40,
                                    bottom: 90,
                                    left: 30,
                                  ),
                                  child: PhysicalModel(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    elevation: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        width: 120,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        Hobbies_New_Edit(
                                                            widget
                                                                .templateUserName,
                                                            widget.hobbyName,
                                                            widget.hobbyRef)));
                                          },
                                          child: Center(
                                            child: Text(
                                              '+ Add Folder',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                          : snapshot.data != null
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 25),
                                        height: 180,
                                        width: 220,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                25.0,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 5.0,
                                                  offset: Offset(0, 7),
                                                  spreadRadius: 0.1,
                                                ),
                                              ]),
                                          child: GestureDetector(
                                            onTap: () {
                                              debugPrint(
                                                  "pushingggggggggggggg");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Hobbies_Self_View(
                                                          widget
                                                              .currentUserName,
                                                          widget
                                                              .templateUserName,
                                                          widget.hobbyName,
                                                          widget.hobbyRef,
                                                          snapshot.data
                                                              .docs[i - 1].id,
                                                          snapshot.data
                                                                  .docs[i - 1]
                                                                  .data()[
                                                              "cover-title"],
                                                          snapshot.data
                                                                  .docs[i - 1]
                                                                  .data()[
                                                              "coverImageURL"])));
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                25.0,
                                              ),
                                              child: snapshot.data.docs[i - 1]
                                                              .data()[
                                                          "coverImageURL"] !=
                                                      null
                                                  ? Image.network(
                                                      snapshot.data.docs[i - 1]
                                                              .data()[
                                                          "coverImageURL"],
                                                      width: 160,
                                                      fit: BoxFit.fill)
                                                  : Image.asset(
                                                      "asset/default.png",
                                                      width: 160,
                                                      fit: BoxFit.fill),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Baseline(
                                        baselineType: TextBaseline.alphabetic,
                                        baseline: -20,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  12.0,
                                                ),
                                              ),
                                              child: AbsorbPointer(
                                                child: TextField(
                                                  enabled: true,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    hintText: snapshot
                                                        .data.docs[i - 1]
                                                        .data()["cover-title"],
                                                    enabledBorder:
                                                        InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              elevation: 5,
                                            ),
                                            height: 50,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox.shrink();
                    });
              }),
        ),
      ],
    );
  }
}

class Gallery extends StatefulWidget {
  bool edit;
  String username;
  Gallery(this.edit, this.username);
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  Stream galleries;
  void initState() {
    TemplateDatabase.getAlbums(widget.username).then((snapshots) {
      setState(() {
        galleries = snapshots;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      !widget.edit
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
                        builder: (_) => Gallery_New_Edit(widget.username)));
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
            child: StreamBuilder(
                stream: galleries,
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return GalleryTile(
                          widget.username,
                          snapshot.data.docs[i].data()["album-name"],
                          snapshot.data.docs[i].id,
                          widget.edit,
                          snapshot.data.docs[i].data()["coverURL"]);
                    },
                    itemCount: snapshot.data.docs.length,
                  );
                }),
          ),
        ],
      )
    ]);
  }
}

class GalleryTile extends StatefulWidget {
  String username;
  String galleryRef;
  String galleryName;
  String galleryCoverURL;
  bool edit;
  GalleryTile(this.username, this.galleryName, this.galleryRef, this.edit,
      this.galleryCoverURL);
  @override
  _GalleryTileState createState() => _GalleryTileState();
}

class _GalleryTileState extends State<GalleryTile> {
  Stream photos;
  CarouselController buttonCarouselController = CarouselController();
  double _currentSliderValue = 0.0;
  double numberImages = 0.0;
  void initState() {
    TemplateDatabase.getPhotos(widget.username, widget.galleryRef)
        .then((snapshots) {
      setState(() {
        photos = snapshots;
      });
      FirebaseFirestore.instance
          .collection("templates")
          .doc(widget.username)
          .collection("albums")
          .doc(widget.galleryRef)
          .collection("images")
          .get()
          .then((snapshot) {
        setState(() {
          numberImages = snapshot.docs.length.toDouble();
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        builder: (_) => Gallery_Exist_Edit(
                            widget.username,
                            widget.galleryName,
                            widget.galleryRef,
                            widget.galleryCoverURL)));
                widget.edit = !widget.edit;
              });
            },
            child: !widget.edit
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
              turns: AlwaysStoppedAnimation(3 / 360),
              child: StreamBuilder(
                  stream: photos,
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(child: CircularProgressIndicator())
                        : CarouselSlider(
                            items: snapshot.data.docs.map<Widget>((e) {
                              debugPrint(
                                  "Templates/${widget.username}/Albums/${widget.galleryRef}/${e.data}.jpg");
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
                                child: e.data()["imageURL"] != null
                                    ? Image.network(e.data()["imageURL"])
                                    : Image.asset("asset/default.png"),
                              );
                            }).toList(),
                            carouselController: buttonCarouselController,
                            options: CarouselOptions(
                              height: 380,
                              autoPlay: false,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              scrollPhysics: NeverScrollableScrollPhysics(),
                              viewportFraction: 0.9,
                              aspectRatio: 2.0,
                              initialPage: 0,
                            ),
                          );
                  }),
            ),
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    PhysicalModel(
                      shadowColor: Colors.grey,
                      elevation: 5,
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      child: CircleAvatar(
                        backgroundColor: _color,
                        radius: 14,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 1, left: 8),
                          child: GestureDetector(
                            onTap: () {
                              buttonCarouselController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear);

                              if (_currentSliderValue-- > 0) {
                                setState(() {});
                              } else {
                                _currentSliderValue++;
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
                          padding: EdgeInsets.only(bottom: 1, left: 3),
                          child: GestureDetector(
                            onTap: () {
                              buttonCarouselController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear);
                              if (_currentSliderValue++ < numberImages) {
                                setState(() {});
                              } else {
                                _currentSliderValue--;
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Slider(
            inactiveColor: Colors.black,
            activeColor: Colors.black,
            value: _currentSliderValue,
            min: 0,
            max: numberImages,
            divisions: numberImages <= 1.0 ? 1 : numberImages.toInt(),
            label: (_currentSliderValue + 1).round().toString() +
                '/ $numberImages',
            onChanged: (double value) {
              buttonCarouselController.jumpToPage(_currentSliderValue.toInt());
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
