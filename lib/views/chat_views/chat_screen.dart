import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/views/Template_views/basic_one.dart';
import 'package:final_app/views/Template_views/image_from_network.dart';
import 'package:final_app/views/Template_views/template_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared_preferences.dart';
import 'package:intl/intl.dart';

import '../imageutil.dart';
import '../services.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomReference;
  final String friendUserName;
  ChatScreen({this.chatRoomReference, this.friendUserName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream messages;
  String friendFullName;
  String currentUserName;
  String frienddpURL;
  bool show = false;

  bool isLoading = true;
  File imageUpload;
  final picker = ImagePicker();
  var format = new DateFormat("EEE, h:mm a");

  TextEditingController messageInputController = new TextEditingController();
  @override
  void initState() {
    SharedPreference.getUserName().then((value) {
      currentUserName = value;
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.friendUserName)
        .get()
        .then((snapshot) {
      setState(() {
        frienddpURL = snapshot.data()["dpURL"];
      });
    });
    messages = FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoomReference)
        .collection('messages')
        .snapshots();
    debugPrint(messages.toString());
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.friendUserName)
        .get()
        .then((value) {
      friendFullName = value.data()['fullname'];
      debugPrint(friendFullName);
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  void sendMessage() {
    debugPrint("Sending Message: ${messageInputController.text}");
    if (messageInputController.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(widget.chatRoomReference)
          .collection('messages')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set({
        "type": "text",
        'text': messageInputController.text,
        'sentBy': currentUserName,
        'isRead': false,
      });
      Services.sendNotification(widget.friendUserName,
          "You have a new Message from $currentUserName");
      messageInputController.clear();
    }
  }

  void uploadImage() {
    final String time = DateTime.now().millisecondsSinceEpoch.toString();
    debugPrint(time);
    debugPrint("Uploading image to $time");
    TemplateDatabase.uploadImageToStorage(
            imageUpload, "Chats/${widget.chatRoomReference}/$time.jpg")
        .then((value) {
      TemplateDatabase.getImageUrl(
              "Chats/${widget.chatRoomReference}/$time.jpg")
          .then((value) {
        FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(widget.chatRoomReference)
            .collection('messages')
            .doc(time)
            .update({
          'imageURL': value,
        });
      });
    });
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoomReference)
        .collection('messages')
        .doc(time)
        .set({
      'type': "image",
      'sentBy': currentUserName,
      'isRead': false,
    });
    Services.sendNotification(
        widget.friendUserName, "You have a new Message from $currentUserName");
  }

  void markAsRead(String messageReference) {
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(widget.chatRoomReference)
        .collection('messages')
        .doc(messageReference)
        .update({
      'isRead': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 25, left: 30, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Icon(Icons.arrow_back_ios)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    friendFullName,
                                    style: GoogleFonts.sourceSansPro(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Seen 1 hour ago',
                                    style: GoogleFonts.sourceSansPro(
                                        fontSize: 12,
                                        color: HexColor('#7A7A7A')),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 34,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => BasicOne(
                                                          currentUserName:
                                                              currentUserName,
                                                          templateUserName: widget
                                                              .friendUserName,
                                                        )));
                                          },
                                          child: frienddpURL != null
                                              ? Image.network(frienddpURL)
                                              : Image.asset(
                                                  "asset/default.png"),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: HexColor('#DAD7D7'),
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(30),
                      //           color: Colors.grey[600]),
                      //       height: 20,
                      //       width: 80,
                      //       child: Center(
                      //         child: Text(
                      //           'May 7',
                      //           style: TextStyle(color: Colors.white),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      Expanded(
                        child: StreamBuilder(
                            stream: messages,
                            builder: (context, snapshot) {
                              return snapshot.hasData &&
                                      snapshot.data.docs.length > 0
                                  ? ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        bool isSent = snapshot.data.docs[i]
                                                .data()["sentBy"] ==
                                            currentUserName;
                                        bool isRead = snapshot.data.docs[i]
                                            .data()["isRead"];
                                        String text = snapshot.data.docs[i]
                                            .data()["text"];
                                        String type = snapshot.data.docs[i]
                                            .data()["type"];
                                        String imageURL = snapshot.data.docs[i]
                                            .data()["imageURL"];
                                        DateTime date = new DateTime
                                                .fromMillisecondsSinceEpoch(
                                            int.parse(
                                                snapshot.data.docs[i].id));
                                        String time = format.format(date);

                                        if (!isSent && !isRead) {
                                          markAsRead(snapshot.data.docs[i].id);
                                        }
                                        return ChatMessage(
                                            isSent: isSent,
                                            imageURL: imageURL,
                                            isRead: isRead,
                                            text: text,
                                            ref: snapshot.data.docs[i].id,
                                            type: type,
                                            chatRef: widget.chatRoomReference,
                                            time: time);
                                      })
                                  : Container();
                            }),
                      ),
                      Container(
                        color: HexColor('#DAD7D7'),
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),

                      SafeArea(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _getFromCamera();
                                      });
                                    },
                                    icon: Icon(Icons.camera_alt,
                                        size: 25.0, color: Colors.grey)),
                                IconButton(
                                    onPressed: () {
                                      _getFromGallery();
                                    },
                                    icon: Icon(Icons.photo,
                                        size: 25.0, color: Colors.grey)),
                                Expanded(
                                  child: TextFormField(
                                    controller: messageInputController,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        contentPadding: EdgeInsets.all(12),
                                        isCollapsed: true,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                        hintText: 'Send a message'),
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                  ),
                                ),
                                SizedBox(width: 5),
                                IconButton(
                                    onPressed: sendMessage,
                                    icon: Icon(Icons.send, color: Colors.grey))
                              ],
                            )),
                      ),
                    ],
                  )));
  }

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageUpload = File(pickedFile.path);
        uploadImage();
      });
    }
  }

  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageUpload = File(pickedFile.path);
      });
    }
  }
}

class ChatMessage extends StatelessWidget {
  final String chatRef;
  final bool isSent;
  final bool isRead;
  final String text;
  final String time;
  final String type;
  final String imageURL;
  final String ref;
  const ChatMessage(
      {Key key,
      this.imageURL,
      this.isSent,
      this.chatRef,
      this.isRead,
      this.ref,
      this.text,
      this.time,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type != null && type == "image"
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: imageURL == null
                    ? SizedBox.shrink()
                    : Container(
                        height: 190,
                        width: 256,
                        child: Image.network(
                          this.imageURL,
                          fit: BoxFit.cover,
                        )),
              ),
            ],
          )
        : isSent
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 280,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: HexColor('#ECEBEB'),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            border: Border.all(color: HexColor('#ECEBEB'))),
                        child: Text(
                          text,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Row(
                        children: [
                          // Icon(
                          //   Icons.done_all,
                          //   color: Colors.blue,
                          // ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            time,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 280,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            border: Border.all(color: HexColor('#ECEBEB'))),
                        child: Text(
                          text,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            time,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              );
  }
}
