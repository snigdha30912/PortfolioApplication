import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/shared_preferences.dart';
import 'package:final_app/views/chat_views/chat_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:template_basic1/profile_viewer.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../database.dart';
import 'home.dart';
import 'imageutil.dart';

class ProfilePage extends StatefulWidget {
  String currentUserName;
  String dpURL;
  ProfilePage(this.currentUserName, this.dpURL);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool show = false;
  bool status = false;
  var nameEditingController = new TextEditingController();
  var taglineEditingController = new TextEditingController();
  String currentUserName = "";
  String phoneNumber = "";
  File _image;
  File _previousImage;
  bool isLoading = false;
  String dpURL;
  final picker = ImagePicker();
  @override
  void initState() {
    dpURL = widget.dpURL;
    currentUserName = widget.currentUserName;

    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserName)
        .get()
        .then((documentSnapshot) {
      setState(() {
        phoneNumber = documentSnapshot.data()['phoneNumber'];
        debugPrint("userPhone : " + phoneNumber);
        nameEditingController.text = documentSnapshot.data()['fullname'];
        taglineEditingController.text = documentSnapshot.data()['tagline'];
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          iconSize: 25,
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: isLoading
                ? CircularProgressIndicator()
                : TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: HexColor('#484848'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await DatabaseMethods().saveProfile(
                          nameEditingController.text,
                          taglineEditingController.text,
                          _image);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Save',
                      // here we will call DatabaseMethods.saveProfile()
                      style: TextStyle(color: Colors.white),
                    )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      height: 270, // we need to add save image method here
                      child: _image == null
                          ? dpURL == null
                              ? Image.asset(
                                  'asset/default.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.network(dpURL, fit: BoxFit.cover)
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                            )),
                  !show
                      ? SizedBox.shrink()
                      : Positioned(
                          top: 80,
                          bottom: 80,
                          left: 120,
                          right: 120,
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
                                height: 50,
                                width: 50,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 12),
                                      child: Row(
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
                                                          .then((value) {
                                                        setState(() {
                                                          _image = value;
                                                          show = !show;
                                                        });
                                                      });
                                                      // setState(() {
                                                      //   show = true;
                                                      // });
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
                                                          .then((value) {
                                                        setState(() {
                                                          _image = value;
                                                          show = !show;
                                                        });
                                                      });
                                                    }),
                                                Text(
                                                  'Gallery',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          )
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: HexColor('#747373'),
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    }),
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
                    onPressed: () {})
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Name',
                          style: TextStyle(color: HexColor('#484848'))),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameEditingController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xFF9E9E9E),
                              fontSize: 17,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF0E0909),
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF0E0909),
                                width: 2,
                              ),
                            ),
                          ),
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: HexColor('#C4C4C4'),
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Username',
                          style: TextStyle(color: HexColor('#484848'))),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(currentUserName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: HexColor('#C4C4C4'),
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Tagline (if any)',
                          style: TextStyle(color: HexColor('#484848'))),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: taglineEditingController,
                          decoration: InputDecoration(
                            hintText: 'Tagline',
                            hintStyle: TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xFF9E9E9E),
                              fontSize: 17,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF0E0909),
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF0E0909),
                                width: 2,
                              ),
                            ),
                          ),
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  status
                      ? Container(
                          height: 1,
                          color: HexColor('#C4C4C4'),
                          width: MediaQuery.of(context).size.width,
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  status
                      ? Row(
                          children: [
                            Text('Phone Number',
                                style: TextStyle(color: HexColor('#484848'))),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 5,
                  ),
                  status
                      ? Row(
                          children: [
                            Text(phoneNumber,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17))
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  status
                      ? Container(
                          height: 1,
                          color: HexColor('#C4C4C4'),
                          width: MediaQuery.of(context).size.width,
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Show Phone Number',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      CupertinoSwitch(
                        trackColor: HexColor('#C4C4C4'),
                        value: status,
                        onChanged: (value) {
                          print("VALUE : $value");
                          setState(() {
                            status = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        show = !show;
      });
      _cropImage(pickedFile.path);
    }
  }

  Future _imgFromGallery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        show = !show;
      });
      _cropImage(pickedFile.path);
    }
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
      _image = croppedImage;
      setState(() {});
    }
  }
}
