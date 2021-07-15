import 'dart:math';
import 'package:final_app/views/Template_views/image_from_network.dart';
import 'package:final_app/views/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/database.dart';
import 'package:final_app/views/user.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:dio/dio.dart';

import '../shared_preferences.dart';
import 'Template_views/basic_one.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;
  String currentUserName;
  Future<QuerySnapshot> allUsers;
  @override
  void initState() {
    searchTextEditingController.text = "";
    SharedPreference.getUserName().then((value) {
      currentUserName = value;
      debugPrint(currentUserName);
    });
    allUsers = FirebaseFirestore.instance.collection("users").get();
    setState(() {
      futureSearchResults = allUsers;
    });
    super.initState();
  }

  emptyTheTextFormField() {
    searchTextEditingController.clear();
    setState(() {
      futureSearchResults = allUsers;
    });
  }

  controlSearching(String str) {
    Future<QuerySnapshot> allUsers = FirebaseFirestore.instance
        .collection("users")
        .where("fullname", isEqualTo: str)
        .get();

    setState(() {
      futureSearchResults = allUsers;
    });
  }

  AppBar searchPageHeader() {
    return AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          style: TextStyle(fontSize: 18.0, color: Colors.black),
          controller: searchTextEditingController,
          decoration: InputDecoration(
            hintText: "Search Users",
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            filled: true,
            prefixIcon: Icon(
              Icons.person_pin,
              color: Colors.grey,
              size: 30.0,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear, color: Colors.black),
              onPressed: emptyTheTextFormField,
            ),
          ),
          onFieldSubmitted: controlSearching,
        ));
  }

  Container displayNoSearchResultScreen() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Icon(Icons.group, color: Colors.blue, size: 200.0),
            Text(
              "Search Users",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  displayUsersFoundScreen() {
    return FutureBuilder(
        future: futureSearchResults,
        builder: (context, dataSnapshot) {
          if (!dataSnapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<UserResult> searchUserResult = [];
          dataSnapshot.data.docs.forEach((document) {
            User eachUser = User.fromDocument(document);
            debugPrint(eachUser.fullName + currentUserName);
            UserResult userResult = UserResult(eachUser, currentUserName);
            searchUserResult.add(userResult);
          });
          return ListView(children: searchUserResult);
        });
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: searchPageHeader(),
      body: futureSearchResults == null
          ? displayNoSearchResultScreen()
          : displayUsersFoundScreen(),
    );
  }
}

class UserResult extends StatefulWidget {
  final User eachUser;
  final String currentUserName;
  UserResult(this.eachUser, this.currentUserName);

  @override
  _UserResultState createState() => _UserResultState();
}

class _UserResultState extends State<UserResult> {
  bool isRequestSent = false;
  bool isFriend = false;
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.eachUser.userName)
        .collection('friends')
        .doc(widget.currentUserName)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (!documentSnapshot.exists) {
        setState(() {
          isRequestSent = false;
        });
      } else {
        setState(() {
          isFriend = documentSnapshot['isFriend'];
        });
      }
    });
    super.initState();
  }

  sendRequest() async {
    debugPrint("username " + widget.currentUserName);
    DatabaseMethods()
        .addFriendRequest(widget.eachUser.userName, widget.currentUserName);
    setState(() {
      isRequestSent = true;
    });
    Services.sendNotification(
        widget.eachUser.userName, "You have a new Friend Request");
  }

  cancelRequest() async {
    debugPrint(widget.currentUserName);
    DatabaseMethods()
        .removeFriendRequest(widget.eachUser.userName, widget.currentUserName);
    setState(() {
      isRequestSent = false;
    });
  }

  sendMessage() async {}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Container(
            color: Colors.white54,
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BasicOne(
                                    currentUserName: widget.currentUserName,
                                    templateUserName: widget.eachUser.userName,
                                  )));
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      width: 60,
                      height: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: widget.eachUser.dpURL != null
                              ? Image.network(widget.eachUser.dpURL,
                                  width: 50, fit: BoxFit.fill)
                              : Image.asset("asset/default.png",
                                  width: 50, fit: BoxFit.fill)),
                    ),
                  ),
                  Container(
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.eachUser.userName,
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              widget.eachUser.fullName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: HexColor('#AFAFAF')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  isFriend
                      ? OutlinedButton(
                          onPressed: () {
                            print('Button pressed ...');
                            sendMessage();
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFF0E0909),
                              textStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFFAFAFA)),
                              fixedSize: Size(100, 40),
                              side: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                  style: BorderStyle.solid)),
                          child: Text("Send Message",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFFAFAFA),
                                  fontSize: 9)),
                        )
                      : isRequestSent
                          ? OutlinedButton(
                              onPressed: () {
                                print('Button pressed ...');
                                cancelRequest();
                              },
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Color(0xFF0E0909),
                                  textStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFFAFAFA)),
                                  fixedSize: Size(100, 40),
                                  side: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                      style: BorderStyle.solid)),
                              child: Text("Cancel Request",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 9)),
                            )
                          : OutlinedButton(
                              onPressed: () {
                                print('Button pressed ...');
                                sendRequest();
                              },
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Color(0xFF0E0909),
                                  textStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFFAFAFA)),
                                  fixedSize: Size(100, 40),
                                  side: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                      style: BorderStyle.solid)),
                              child: Text("Add Friend",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 9)),
                            ),
                ]),
              ],
            )));
  }
}
