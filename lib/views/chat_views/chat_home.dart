import 'dart:io';
import 'package:final_app/views/Template_views/image_from_network.dart';
import 'package:final_app/views/searchpage.dart';
import 'package:final_app/views/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../authentication.dart';
import '../../database.dart';
import '../../shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../Authentication_Views/login.dart';
import 'chat_screen.dart';
import '../profile_page.dart';
import '../requests.dart';

class ChatHomeScreen extends StatefulWidget {
  @override
  _ChatHomeScreenState createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  File profileImage;
  Stream friends;
  String currentUserName;
  String searchString;
  String dpURL;
  TextEditingController searchEC = new TextEditingController();
  int requests = 0;
  static const _kFontFam = 'MyFlutterApp';
  static const String _kFontPkg = null;
  Color _color = Colors.white;
  static const IconData lnr_bubble =
      IconData(0xe83f, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  void initState() {
    Services().configureNotifs();
    SharedPreference.getUserName().then((value) {
      setState(() {
        currentUserName = value;
        FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserName)
            .get()
            .then((snapshots) {
          setState(() {
            dpURL = snapshots.data()["dpURL"];
          });
        });
      });
      DatabaseMethods().getRequests(currentUserName).then((snapshots) {
        setState(() {
          if (snapshots.hasData) {
            requests = snapshots.data.docs.length;
          }
        });
      });
      DatabaseMethods().getFriends(value).then((snapshots) {
        setState(() {
          friends = snapshots;
          debugPrint(snapshots.toString());
          debugPrint("value : " + value);
          print("we got the data + ${friends.toString()}");
        });
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
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, left: 30, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text('Portfol.io',
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                      ),
                      Row(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 25),
                          //   child: IconButton(
                          //     icon: Icon(
                          //       Icons.add_alert_outlined,
                          //       color: Colors.black,
                          //       size: 32,
                          //     ),
                          //     onPressed: () {
                          //       // Navigator.push(
                          //       //     context,
                          //       //     MaterialPageRoute(
                          //       //         builder: (context) => SearchPage()));
                          //     },
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () {
                              AuthService().signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Icon(Icons.exit_to_app)),
                          ),
                          Container(
                            height: 34,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage(
                                            currentUserName, dpURL)));
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: dpURL != null
                                      ? Image.network(dpURL,
                                          width: 34, fit: BoxFit.fill)
                                      : Image.asset(
                                          "asset/default.png",
                                          width: 34,
                                          fit: BoxFit.fill,
                                        )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 0),
                child: Container(
                  child: TextFormField(
                    controller: searchEC,
                    onEditingComplete: () {
                      setState(() {
                        searchString = searchEC.text;
                        debugPrint("search::::::" + searchString);
                      });
                    },
                    onFieldSubmitted: (String str) {
                      setState(() {
                        searchString = str;
                        debugPrint("search::::::" + searchString);
                      });
                    },
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(color: Colors.grey[300], fontSize: 20),
                      enabledBorder: InputBorder.none,
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[300],
                        size: 35,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[300])),
                  height: 50,
                  width: 340,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Requests()));
                      },
                      child: Text(
                        'Requests',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder(
                        stream: friends,
                        builder: (context, snapshot) {
                          return snapshot.hasData &&
                                  snapshot.data.docs.length > 0
                              ? ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return snapshot.data.docs[i] != null
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => ChatScreen(
                                                          chatRoomReference:
                                                              snapshot.data
                                                                      .docs[i]
                                                                      .data()[
                                                                  'chat'],
                                                          friendUserName:
                                                              snapshot
                                                                  .data
                                                                  .docs[i]
                                                                  .id)));
                                            },
                                            child: searchString == null ||
                                                    searchString.length == 0
                                                ? FriendTile(
                                                    friendUserName: snapshot
                                                        .data.docs[i].id,
                                                  )
                                                : searchString ==
                                                        snapshot.data.docs[i].id
                                                            .toString()
                                                    ? FriendTile(
                                                        friendUserName: snapshot
                                                            .data.docs[i].id,
                                                      )
                                                    : SizedBox.shrink(),
                                          )
                                        : Container();
                                  },
                                )
                              : Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                        "You don't have any friends ;_;",
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FriendTile extends StatefulWidget {
  final String friendUserName;
  const FriendTile({Key key, this.friendUserName}) : super(key: key);

  @override
  _FriendTileState createState() => _FriendTileState();
}

class _FriendTileState extends State<FriendTile> {
  String fullName;
  String userPhone = "";
  String dpURL = null;

  @override
  void initState() {
    debugPrint(widget.friendUserName);
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.friendUserName)
        .get()
        .then((DocumentSnapshot<dynamic> documentSnapshot) {
      if (documentSnapshot.data() != null) {
        setState(() {
          fullName = documentSnapshot.data()['fullname'];
          debugPrint("fullname = " + fullName);
          dpURL = documentSnapshot.data()['dpURL'];
          userPhone = documentSnapshot.data()['phoneNumber'];
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fullName == null
        ? CircularProgressIndicator()
        : Container(
            width: MediaQuery.of(context).size.width,
            color: HexColor('#FBFBFB'),
            // HexColor('#F2F2F2'),
            child: Column(children: [
              Container(
                padding: EdgeInsets.only(right: 5, left: 0),
                height: 72,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                width: 385,
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 0),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: dpURL != null
                            ? Image.network(dpURL, width: 50, fit: BoxFit.fill)
                            : Image.asset("asset/default.png",
                                width: 50, fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.friendUserName,
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
                              userPhone,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: HexColor('#AFAFAF')),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        '03:02PM',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: HexColor('#AFAFAF')),
                      ),
                    ),
                  ],
                ),
              )
            ]));
  }
}
