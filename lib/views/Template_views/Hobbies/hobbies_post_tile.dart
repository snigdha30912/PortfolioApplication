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

class PostTile extends StatefulWidget {
  String postRef;
  String templateUserName;
  String currentUserName;
  PostTile(this.postRef, this.templateUserName, this.currentUserName);

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  DocumentSnapshot<dynamic> postDataSnapshot;
  int commentsLength = 0;
  bool liked = false;
  Stream comments;
  Stream images;
  @override
  void initState() {
    TemplateDatabase.getPostData(widget.templateUserName, widget.postRef)
        .then((value) {
      setState(() {
        postDataSnapshot = value;
        debugPrint(postDataSnapshot.data().toString());
      });
    });
    TemplateDatabase.getPostImages(widget.templateUserName, widget.postRef)
        .then((value) {
      setState(() {
        if (value == null) debugPrint("nulllllllll receivedddddddddddd");
        images = value;
      });
    });

    TemplateDatabase.getComments(widget.templateUserName, widget.postRef)
        .then((value) {
      setState(() {
        comments = value;
        comments.length.then((value) {
          setState(() {
            commentsLength = value;
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return postDataSnapshot == null
        ? SizedBox.shrink()
        : Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                elevation: 3,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    PhysicalModel(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 05,
                      shadowColor: Colors.grey,
                      color: Colors.black,
                      child: Container(
                        height: 400,
                        width: 325,
                        child: StreamBuilder(
                            stream: images,
                            builder: (context, snapshot) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  22,
                                ),
                                child: snapshot.data.docs.isNotEmpty
                                    ? snapshot.data.docs[0].data()["dpURL"] !=
                                            null
                                        ? Image.network(snapshot.data.docs[0]
                                            .data()["dpURL"])
                                        : Image.asset("asset/default.png")
                                    : Image.asset(
                                        'asset/d2733fa30b203f8d7f44d230c2c769a5.jpg',
                                        fit: BoxFit.fill,
                                      ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          //DateTime.fromMillisecondsSinceEpoch((int)postRef),
                          "2 hours ago",
                          style: TextStyle(color: HexColor('#747373')),
                        ),
                        SizedBox(width: 1),
                        DotsIndicator(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          dotsCount: 5,
                          decorator: DotsDecorator(
                              spacing: EdgeInsets.all(2),
                              color: HexColor('#C4C4C4'),
                              activeColor: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            postDataSnapshot.data()["header"],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            postDataSnapshot.data()["description"],
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    HexColor('#848E94').withOpacity(.66),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      liked = !liked;
                                      if (liked) {
                                        postDataSnapshot.data()["likes"] += 1;
                                      } else {
                                        postDataSnapshot.data()["likes"] -= 1;
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: liked ? Colors.red : Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, left: 2),
                                child: Text(
                                  postDataSnapshot.data()["likes"].toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  comment(context);
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      HexColor('#848E94').withOpacity(.66),
                                  child: Icon(
                                    FontAwesome.comment,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, left: 2),
                                child: Text(
                                  commentsLength.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 20),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    HexColor('#848E94').withOpacity(.66),
                                child: Icon(
                                  FontAwesome.share,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40),
            ],
          );
  }

  TextEditingController commentEC = new TextEditingController();
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
                      child: StreamBuilder(
                          stream: comments,
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? Center(child: Text("No comments"))
                                : ListView.builder(
                                    padding: EdgeInsets.only(bottom: 10),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length + 1,
                                    itemBuilder: (buildContext, int i) {
                                      return i == 0
                                          ? Center(
                                              child: Text(
                                                'Comments',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          : CommentTile(
                                              snapshot.data.docs[i - 1]
                                                  .data()["text"],
                                              snapshot.data.docs[i - 1]
                                                  .data()["user"]);
                                    });
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
                          controller: commentEC,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              hintText: 'Add A Comment...',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (commentEC.text.length > 0) {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(widget.templateUserName)
                                        .collection("posts")
                                        .doc(widget.postRef)
                                        .collection("comments")
                                        .add({
                                      "user": widget.currentUserName,
                                      "text": commentEC.text
                                    });
                                    commentEC.text = "";
                                  }
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.grey,
                                ),
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

class CommentTile extends StatefulWidget {
  String text;
  String username;
  CommentTile(this.text, this.username);
  @override
  _CommentTileState createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  String dpURL;
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.username)
        .get()
        .then((snapshot) {
      setState(() {
        dpURL = snapshot.data()["dpURL"];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: dpURL != null
                    ? Image.network(dpURL)
                    : Image.asset("asset/default.png"),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.username,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Text(
              '2 min',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Container(
            child: Text(
              widget.text,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
