import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../template_database.dart';
import 'hobbies_diff_cap.dart';

class Hobbies_New_Post extends StatefulWidget {
  String folderRef;
  String hobbyRef;
  String username;
  Hobbies_New_Post(this.folderRef, this.hobbyRef, this.username);
  @override
  _Hobbies_New_PostState createState() => _Hobbies_New_PostState();
}

class _Hobbies_New_PostState extends State<Hobbies_New_Post> {
  List<PickedFile> pickedFile = [];
  TextEditingController headerEC = new TextEditingController();
  TextEditingController descriptionEC = new TextEditingController();
  File imageFile1;
  bool show = true;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Hobbies_New_Post(
                        widget.folderRef, widget.hobbyRef, widget.username)));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          iconSize: 25,
        ),
        title: Text(
          'New Post',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
                onPressed: () {
                  if (headerEC.text.length > 0 &&
                      descriptionEC.text.length > 0) {
                    setState(() {
                      isLoading = true;
                    });
                    String time =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    // add post data to users/{username}/posts
                    // fetch this post reference
                    // store this post reference in templates/username/hobbies/hobbyname/folders/foldername/posts
                    debugPrint(widget.username);
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.username)
                        .collection("posts")
                        .doc(time)
                        .set({
                      "header": headerEC.text,
                      "description": descriptionEC.text,
                      "likes": 0,
                    }).catchError((e) {
                      print(e.toString());
                    });

                    debugPrint(widget.username);
                    FirebaseFirestore.instance
                        .collection("templates")
                        .doc(widget.username)
                        .collection("hobbies")
                        .doc(widget.hobbyRef)
                        .collection("folders")
                        .doc(widget.folderRef)
                        .collection("posts")
                        .doc(time)
                        .set({}).catchError((e) {
                      print(e.toString());
                    });
                    pickedFile.forEach((file) {
                      String time1 =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      TemplateDatabase.uploadImageToStorage(File(file.path),
                              "Posts/${widget.username}/$time-post/$time1-image.jpg")
                          .then((value) {
                        TemplateDatabase.getImageUrl(
                                "Posts/${widget.username}/$time-post/$time1-image.jpg")
                            .then((value) {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(widget.username)
                              .collection("posts")
                              .doc(time)
                              .collection("images")
                              .doc(time1)
                              .set({'dpURL': value}).then((value) {
                            if (file == pickedFile.last) {
                              Navigator.pop(context);
                            }
                          });
                        });
                      });
                    });
                  }
                },
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )),
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      height: 100,
                      width: 140,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add Photo',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 7),
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.camera_alt,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            _getFromCamera();
                                          }),
                                    ),
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: IconButton(
                                      icon: Icon(
                                        CupertinoIcons.photo,
                                        size: 37,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _getFromGallery();
                                      },
                                    ),
                                  ),
                                  Text(
                                    'Gallery',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              pickedFile.length == 0
                  ? SizedBox.shrink()
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: pickedFile.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        crossAxisCount: 3,
                        childAspectRatio: 0.55,
                      ),
                      itemBuilder: (c, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 4.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        pickedFile.removeAt(i);
                                        setState(() {});
                                      },
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            Colors.black.withOpacity(.8),
                                        child: Icon(
                                          Icons.clear,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    child: Image.file(
                                      File(pickedFile[i].path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.sync,
                                        color: HexColor('#5F5F5F'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Header',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                height: 40,
                child: TextFormField(
                    controller: headerEC,
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
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                height: 40,
                child: TextFormField(
                    controller: descriptionEC,
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
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Try Different Captions',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Hobbies_Diff_Cap()));
                      },
                      child: Text(
                        'Try',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ))
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  _getFromGallery() async {
    pickedFile += await ImagePicker().getMultiImage();
    setState(() {});
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

  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile1 = File(pickedFile.path);
      });
    }
  }
}
