import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_app/views/Template_views/Hobbies/hobbies_post_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../image_from_network.dart';
import '../template_database.dart';
import 'hobbies_new_edit.dart';
import 'hobbies_exist_edit.dart';

class Hobbies_Self_View extends StatefulWidget {
  String currentUserName,
      templateUserName,
      hobbyName,
      hobbyRef,
      folderRef,
      coverTitle,
      coverURL;

  Hobbies_Self_View(this.currentUserName, this.templateUserName, this.hobbyName,
      this.hobbyRef, this.folderRef, this.coverTitle, this.coverURL);
  @override
  _Hobbies_Self_ViewState createState() => _Hobbies_Self_ViewState();
}

class _Hobbies_Self_ViewState extends State<Hobbies_Self_View> {
  Stream posts;
  @override
  void initState() {
    TemplateDatabase.getHobbyPosts(
            widget.templateUserName, widget.hobbyRef, widget.folderRef)
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () {},
        ),
        actions: [
          widget.currentUserName != widget.templateUserName
              ? SizedBox.shrink()
              : IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.black,
                  ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    borderRadius: BorderRadius.circular(10)),
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
                ),
          widget.currentUserName != widget.templateUserName
              ? SizedBox.shrink()
              : IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Hobbies_Exist_Edit(
                                widget.templateUserName,
                                widget.hobbyName,
                                widget.hobbyRef,
                                widget.folderRef,
                                widget.coverTitle,
                                widget.coverURL)));
                  },
                ),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: widget.coverURL != null
                ? Image.network(widget.coverURL)
                : Image.asset("default.png"),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                height: 250,
              ),
              Card(
                margin: EdgeInsets.zero,
                color: HexColor('#FFEAEA'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        widget.coverTitle,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 220,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(1.0),
                      //   child: Text(
                      //       'An elegant trendy dark background with geometric patterns, simple and clear navigation - this is what a modern portfolio should look like ! An elegant trendy dark background with geometric patterns, simple and clear navigation - this is what a modern portfolio should look like !'),
                      // ),
                      // SizedBox(
                      //   height: 40,
                      // ),
                      StreamBuilder(
                          stream: posts,
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? Center(
                                    child: Text("No posts"),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, i) {
                                      debugPrint(
                                          "$i XXXXXXXXXXXXXXX ${snapshot.data.docs.length}");
                                      return PostTile(
                                          snapshot.data.docs[i].id,
                                          widget.templateUserName,
                                          widget.currentUserName);
                                    },
                                  );
                          })
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
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
                          itemBuilder: (buildContext, i) {
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
