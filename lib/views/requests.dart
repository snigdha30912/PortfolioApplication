import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/views/services.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../database.dart';
import '../shared_preferences.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  Stream requests;
  String currentUserName;

  @override
  void initState() {
    SharedPreference.getUserName().then((value) {
      setState(() {
        currentUserName = value;
      });
      DatabaseMethods().getRequests(value).then((snapshots) {
        setState(() {
          requests = snapshots;
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
                padding: EdgeInsets.only(top: 30),
                height: 85,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 40,
                        color: HexColor('#565656'),
                      ),
                    ),
                    SizedBox(width: 15),
                    Text('Requests',
                        style: TextStyle(
                          color: HexColor('#565656'),
                          fontSize: 22,
                        )),
                  ],
                ),
              ),
              Container(
                color: HexColor('#DAD7D7'),
                height: 1,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder(
                        stream: requests,
                        builder: (context, snapshot) {
                          return snapshot.hasData &&
                                  snapshot.data.docs.length > 0
                              ? ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return RequestTile(
                                      userName: snapshot.data.docs[i].id,
                                      currentUserName: currentUserName,
                                    );
                                  })
                              : Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                        "No one wants to be friends with you ;_;",
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

class RequestTile extends StatefulWidget {
  String userName;
  String currentUserName;
  RequestTile({Key key, this.userName, this.currentUserName}) : super(key: key);
  @override
  _RequestTileState createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  String fullName = "";
  String userPhone = "";
  @override
  void initState() {
    debugPrint(widget.userName);
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userName)
        .get()
        .then((documentSnapshot) {
      setState(() {
        fullName = documentSnapshot.data()['fullname'];
        debugPrint("fullname : " + fullName);
        userPhone = documentSnapshot.data()['phoneNumber'];
        debugPrint("userPhone : " + userPhone);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: HexColor('#FBFBFB'),
        // HexColor('#F2F2F2'),
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(right: 5, left: 0),
            height: 72,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            width: 385,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Container(
                  padding: EdgeInsets.only(right: 0),
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'asset/pexels-photo-1704488.jpeg',
                      width: 50,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fullName,
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
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 00, right: 00),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: Text(
                          '03:02PM',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: HexColor('#AFAFAF')),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              debugPrint("Accept Request");
                              DatabaseMethods().acceptFriendRequest(
                                  widget.userName, widget.currentUserName);

                              Fluttertoast.showToast(
                                  msg: 'Friend Request is accepted',
                                  toastLength: Toast.LENGTH_SHORT);
                            },
                            child: Icon(
                              Icons.check_circle_outlined,
                              size: 24,
                              color: HexColor('#67CE42'),
                            ),
                          ),
                          SizedBox(width: 30),
                          GestureDetector(
                            onTap: () {
                              debugPrint("cancel Request");
                              DatabaseMethods().removeFriendRequest(
                                  widget.userName, widget.currentUserName);
                              Fluttertoast.showToast(
                                  msg: 'Friend Request cancelled',
                                  toastLength: Toast.LENGTH_SHORT);
                            },
                            child: Icon(
                              Icons.cancel_outlined,
                              size: 24,
                              color: HexColor('#E56767'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
