import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_app/views/Template_views/image_from_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../template_database.dart';
import 'hobbies_new_post.dart';
import 'hobbies_post_tile.dart';

class Hobbies_Exist_Edit extends StatefulWidget {
  String username, hobbyName, hobbyRef, folderRef, coverTitle, coverURL;
  Hobbies_Exist_Edit(this.username, this.hobbyName, this.hobbyRef,
      this.folderRef, this.coverTitle, this.coverURL);

  @override
  _Hobbies_Exist_EditState createState() => _Hobbies_Exist_EditState();
}

class _Hobbies_Exist_EditState extends State<Hobbies_Exist_Edit> {
  Stream posts;
  File imageFile1;
  bool isLoading = false;
  TextEditingController coverEC = new TextEditingController();
  @override
  void initState() {
    TemplateDatabase.getHobbyPosts(
            widget.username, widget.hobbyRef, widget.folderRef)
        .then((snapshots) {
      setState(() {
        posts = snapshots;
        debugPrint("folderssssssssssssssssssss" + posts.toString());
      });
    });
    super.initState();
  }

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
                  Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: HexColor('#626060'),
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
                    child: TextButton(
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
                                .doc(widget.folderRef)
                                .update({"cover-title": coverEC.text}).then(
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
                                    FirebaseFirestore.instance
                                        .collection("templates")
                                        .doc(widget.username)
                                        .collection("hobbies")
                                        .doc(widget.hobbyRef)
                                        .collection("folders")
                                        .doc(widget.folderRef)
                                        .update({
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
                  height: 38,
                  width: 245,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: widget.hobbyName,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
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
                      child: widget.coverURL != null
                          ? Image.network(widget.coverURL, fit: BoxFit.cover)
                          : Image.asset("default.png", fit: BoxFit.cover),
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
                        IconButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
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
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          width: 70,
                                          height: 33,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
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
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Cover Title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 38,
                  width: 245,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: widget.coverTitle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            SizedBox(height: 40),
            Text(
              'Folder Posts:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: HexColor('#ADABAB'),
              height: 1,
              width: MediaQuery.of(context).size.width * .5,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: HexColor('#34B3FC'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  onPressed: () {
                    debugPrint("ahhhhhhhhh" + widget.username);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Hobbies_New_Post(
                                widget.folderRef,
                                widget.hobbyRef,
                                widget.username))).then((value) {
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        setState(() {});
                      });
                    });
                  },
                  child: Text(
                    '+ Add Post',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.edit,
                    size: 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: StreamBuilder(
                  stream: posts,
                  builder: (context, snapshot) {
                    debugPrint(snapshot.data.docs.length.toString());

                    return !snapshot.hasData
                        ? Center(
                            child: Text("No posts"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, i) {
                              return PostTile(snapshot.data.docs[i].id,
                                  widget.username, widget.username);
                            });
                  }),
            ),
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
}
