import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_app/views/Template_views/image_from_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../template_database.dart';

class Gallery_Exist_Edit extends StatefulWidget {
  String username;
  String galleryName;
  String galleryRef;
  String galleryCoverURL;
  Gallery_Exist_Edit(
      this.username, this.galleryName, this.galleryRef, this.galleryCoverURL);
  @override
  Gallery_Exist_EditState createState() => Gallery_Exist_EditState();
}

class Gallery_Exist_EditState extends State<Gallery_Exist_Edit> {
  Color _color = Colors.white;
  bool show = false;
  File coverImage;
  bool isLoading = false;
  Stream photos;
  List<PickedFile> pickedFile = [];
  TextEditingController albumNameEC = new TextEditingController();

  void initState() {
    albumNameEC.text = widget.galleryName;
    TemplateDatabase.getPhotos(widget.username, widget.galleryRef)
        .then((snapshots) {
      setState(() {
        photos = snapshots;
      });
    });

    super.initState();
  }

  _getFromGallery() async {
    pickedFile += await ImagePicker().getMultiImage();
    if (pickedFile.isNotEmpty) {
      pickedFile.forEach((file) {
        String time = DateTime.now().millisecondsSinceEpoch.toString();
        TemplateDatabase.uploadImageToStorage(File(file.path),
                "Templates/${widget.username}/Albums/${widget.galleryRef}/${time}.jpg")
            .then((value) {
          TemplateDatabase.getImageUrl(
                  "Templates/${widget.username}/Albums/${widget.galleryRef}/${time}.jpg")
              .then((value) {
            FirebaseFirestore.instance
                .collection("templates")
                .doc(widget.username)
                .collection("albums")
                .doc(widget.galleryRef)
                .collection("images")
                .doc(time)
                .set({
              'imageURL': value,
            });
          });
        });
      });
    }
    setState(() {});
  }

  _getFromGallery1() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        coverImage = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        // coverImage = File(pickedFile.path);
        // need to fix this
      });
    }
  }

  Widget build(BuildContext context) {
    debugPrint("LENGTHHH" + pickedFile.length.toString());
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            iconSize: 25,
          ),
          title: Text(
            'Edit',
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
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: () {
                        if (albumNameEC.text.length > 0) {
                          setState(() {
                            isLoading = true;
                          });
                          FirebaseFirestore.instance
                              .collection("templates")
                              .doc(widget.username)
                              .collection("albums")
                              .doc(widget.galleryRef)
                              .update({"album-name": albumNameEC.text});
                          if (coverImage != null) {
                            TemplateDatabase.uploadImageToStorage(coverImage,
                                    "Templates/${widget.username}/Albums/${widget.galleryRef}/cover.jpg")
                                .then((value) {
                              TemplateDatabase.getImageUrl(
                                      "Templates/${widget.username}/Albums/${widget.galleryRef}/cover.jpg")
                                  .then((value) {
                                FirebaseFirestore.instance
                                    .collection("templates")
                                    .doc(widget.username)
                                    .collection("albums")
                                    .doc(widget.galleryRef)
                                    .update({
                                  'coverURL': value,
                                });
                              });
                            });
                          }

                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            isLoading = false;
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
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  height: 1,
                  color: HexColor('#C4C4C4'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 30),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PhysicalModel(
                      shadowColor: Colors.grey,
                      elevation: 4,
                      color: HexColor('#C4C4C4'),
                      child: Container(
                        child: coverImage == null
                            ? widget.galleryCoverURL != null
                                ? Image.network(widget.galleryCoverURL,
                                    fit: BoxFit.cover)
                                : Image.asset("asset/default.png",
                                    fit: BoxFit.cover)
                            : Image.file(coverImage, fit: BoxFit.cover),
                        height: 445,
                        width: 270,
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _getFromGallery1();
                      },
                      child: Text(
                        'Change Cover',
                        style: TextStyle(
                            color: HexColor('#34B3FC'),
                            fontSize: 21,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Album Name',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 38,
                      width: 245,
                      child: TextField(
                        controller: albumNameEC,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 30),
              ),
              SliverToBoxAdapter(
                child: TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    unselectedLabelColor: HexColor('#908C8C'),
                    tabs: [
                      Text('Photos',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w500)),
                      // New_
                    ]),
              ),
            ];
          },
          body: TabBarView(children: [
            StreamBuilder(
                stream: photos,
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length + 1,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            i == 0
                                ? Column(
                                    children: [
                                      Opacity(
                                        opacity: 0.8,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Add Photo',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 7),
                                                          child: IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .camera_alt,
                                                                size: 40,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onPressed: () {
                                                                _getFromCamera();
                                                              }),
                                                        ),
                                                        Text(
                                                          'Camera',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 4),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            CupertinoIcons
                                                                .photo,
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
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox.shrink(),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: 312,
                                            height: 470,
                                            child: snapshot.data.docs[i - 1]
                                                        .data()["imageURL"] !=
                                                    null
                                                ? Image.network(
                                                    snapshot.data.docs[i - 1]
                                                        .data()["imageURL"],
                                                    fit: BoxFit.cover)
                                                : Image.asset(
                                                    "asset/default.png",
                                                    fit: BoxFit.cover),
                                          ),
                                          !show
                                              ? SizedBox.shrink()
                                              : Positioned(
                                                  top: 180,
                                                  left: 80,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                    ),
                                                    child: Opacity(
                                                      opacity: 0.8,
                                                      child: Container(
                                                        height: 100,
                                                        width: 140,
                                                        color: Colors.black,
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Change Photo',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child: Column(
                                                                    children: [
                                                                      IconButton(
                                                                          icon:
                                                                              Icon(
                                                                            Icons.camera_alt,
                                                                            size:
                                                                                40,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          onPressed:
                                                                              () {}),
                                                                      Text(
                                                                        'Camera',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 12),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          CupertinoIcons
                                                                              .photo,
                                                                          size:
                                                                              37,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        onPressed:
                                                                            () {}),
                                                                    Text(
                                                                      'Gallery',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              12),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Page Number',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              child: Center(
                                                child: Text(
                                                  '$i',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            // Image.asset(
                                            //     'asset/Synchronize.png'),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     setState(() {
                                            //       show = !show;
                                            //     });
                                            //   },
                                            //   child: Image.asset(
                                            //       'asset/image.png'),
                                            // ),
                                            SizedBox(
                                              width: 70,
                                            ),
                                            Image.asset('asset/delete.png'),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                          ],
                        );
                      });
                }),
          ]),
        ),
      ),
    );
  }
}
