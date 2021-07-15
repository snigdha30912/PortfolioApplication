import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Gallery_Exist_Edit extends StatefulWidget {
  @override
  Gallery_Exist_EditState createState() => Gallery_Exist_EditState();
}

class Gallery_Exist_EditState extends State<Gallery_Exist_Edit> {
  Color _color = Colors.white;
  bool show = false;

  @override
  Widget build(BuildContext context) {
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
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  onPressed: () {},
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
                    // PhysicalModel(
                    //   shadowColor: Colors.grey,
                    //   elevation: 5,
                    //   shape: BoxShape.circle,
                    //   color: Colors.grey,
                    //   child: CircleAvatar(
                    //     backgroundColor: _color,
                    //     radius: 14,
                    //     child: Container(
                    //       padding: EdgeInsets.only(bottom: 1, left: 8),
                    //       child: Icon(
                    //         Icons.arrow_back_ios,
                    //         size: 18,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    PhysicalModel(
                      shadowColor: Colors.grey,
                      elevation: 4,
                      color: HexColor('#C4C4C4'),
                      child: Container(
                        child: Image.asset(
                          'asset/download.jpg',
                          fit: BoxFit.cover,
                        ),
                        height: 445,
                        width: 270,
                      ),
                    ),
                    // PhysicalModel(
                    //   shadowColor: Colors.grey,
                    //   elevation: 5,
                    //   shape: BoxShape.circle,
                    //   color: Colors.grey,
                    //   child: CircleAvatar(
                    //     backgroundColor: _color,
                    //     radius: 14,
                    //     child: Container(
                    //       padding: EdgeInsets.only(bottom: 1, left: 3),
                    //       child: Icon(
                    //         Icons.arrow_forward_ios,
                    //         size: 18,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                    Text(
                      'Change Cover',
                      style: TextStyle(
                          color: HexColor('#34B3FC'),
                          fontSize: 21,
                          fontWeight: FontWeight.w500),
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
            ListView.builder(
                itemCount: 2,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      i == 0
                          ? Opacity(
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
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7),
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.camera_alt,
                                                      size: 40,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      // _getFromCamera();
                                                    }),
                                              ),
                                              Text(
                                                'Camera',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4),
                                              child: IconButton(
                                                icon: Icon(
                                                  CupertinoIcons.photo,
                                                  size: 37,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  // _getFromGallery();
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
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 312,
                            height: 470,
                            child: Image.asset(
                              'asset/download.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          !show
                              ? SizedBox.shrink()
                              : Positioned(
                                  top: 180,
                                  left: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(20),
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
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Change Photo',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(
                                                            Icons.camera_alt,
                                                            size: 40,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () {}),
                                                      Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    IconButton(
                                                        icon: Icon(
                                                          CupertinoIcons.photo,
                                                          size: 37,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () {}),
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
                                  ),
                                )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            Text(
                              'Page Number',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              child: Center(
                                child: Text(
                                  '${i + 1}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Image.asset('asset/Synchronize.png'),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  show = !show;
                                });
                              },
                              child: Image.asset('asset/image.png'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset('asset/delete.png'),
                          ],
                        ),
                      )
                    ],
                  );
                }),
            // ListView.builder(
            //     itemCount: 2,
            //     itemBuilder: (context, i) {
            //       return Column(
            //         children: [
            //           SizedBox(
            //             height: 40,
            //           ),
            //           Stack(
            //             children: [
            //               Container(
            //                 width: 312,
            //                 height: 470,
            //                 child: Image.asset(
            //                   'asset/download.jpg',
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //               !show
            //                   ? SizedBox.shrink()
            //                   : Positioned(
            //                       top: 180,
            //                       left: 80,
            //                       child: ClipRRect(
            //                         borderRadius: BorderRadius.only(
            //                           topLeft: Radius.circular(20),
            //                           bottomLeft: Radius.circular(0),
            //                           bottomRight: Radius.circular(20),
            //                           topRight: Radius.circular(20),
            //                         ),
            //                         child: Opacity(
            //                           opacity: 0.8,
            //                           child: Container(
            //                             height: 100,
            //                             width: 140,
            //                             color: Colors.black,
            //                             child: Column(
            //                               children: [
            //                                 SizedBox(
            //                                   height: 10,
            //                                 ),
            //                                 Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment.center,
            //                                   children: [
            //                                     Text(
            //                                       'Change Photo',
            //                                       style: TextStyle(
            //                                           color: Colors.white,
            //                                           fontSize: 15),
            //                                     )
            //                                   ],
            //                                 ),
            //                                 Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment.spaceAround,
            //                                   children: [
            //                                     Padding(
            //                                       padding:
            //                                           const EdgeInsets.all(2.0),
            //                                       child: Column(
            //                                         children: [
            //                                           IconButton(
            //                                               icon: Icon(
            //                                                 Icons.camera_alt,
            //                                                 size: 40,
            //                                                 color: Colors.white,
            //                                               ),
            //                                               onPressed: () {}),
            //                                           Text(
            //                                             'Camera',
            //                                             style: TextStyle(
            //                                                 color: Colors.white,
            //                                                 fontSize: 12),
            //                                           )
            //                                         ],
            //                                       ),
            //                                     ),
            //                                     Column(
            //                                       children: [
            //                                         IconButton(
            //                                             icon: Icon(
            //                                               CupertinoIcons.photo,
            //                                               size: 37,
            //                                               color: Colors.white,
            //                                             ),
            //                                             onPressed: () {}),
            //                                         Text(
            //                                           'Gallery',
            //                                           style: TextStyle(
            //                                               color: Colors.white,
            //                                               fontSize: 12),
            //                                         )
            //                                       ],
            //                                     )
            //                                   ],
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     )
            //             ],
            //           ),
            //           SizedBox(
            //             height: 5,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 50),
            //             child: Row(
            //               children: [
            //                 Text(
            //                   'Page Number',
            //                   style: TextStyle(
            //                       fontSize: 16, fontWeight: FontWeight.w500),
            //                 ),
            //                 SizedBox(
            //                   width: 10,
            //                 ),
            //                 Container(
            //                   height: 20,
            //                   width: 20,
            //                   child: Center(
            //                     child: Text(
            //                       '',
            //                       style: TextStyle(color: Colors.black),
            //                     ),
            //                   ),
            //                   decoration: BoxDecoration(
            //                       border: Border.all(),
            //                       borderRadius: BorderRadius.circular(7)),
            //                 ),
            //                 SizedBox(
            //                   width: 70,
            //                 ),
            //                 GestureDetector(
            //                   onTap: () {
            //                     setState(() {
            //                       show = !show;
            //                     });
            //                   },
            //                   child: Image.asset('asset/image.png'),
            //                 ),
            //                 SizedBox(
            //                   width: 5,
            //                 ),
            //                 Image.asset('asset/delete.png'),
            //               ],
            //             ),
            //           )
            //         ],
            //       );
            //     }),
            // Column(children: [
            //   SizedBox(
            //     height: 5,
            //   ),
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       SizedBox(
            //         width: 120,
            //       ),
            //       TextButton(
            //           style: TextButton.styleFrom(
            //             backgroundColor: HexColor('#34B3FC'),
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(300)),
            //           ),
            //           onPressed: () {},
            //           child: Text(
            //             '    Add More    ',
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.bold),
            //           )),
            //     ],
            //   ),
            //   SizedBox(
            //     height: 5,
            //   ),
            //   Container(
            //     height: 470,
            //     width: 312,
            //     child: Image.asset(
            //       'asset/Rectangle 61.png',
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   SizedBox(
            //     height: 5,
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 50),
            //     child: Row(
            //       children: [
            //         Text(
            //           'Page Number',
            //           style:
            //               TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            //         ),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Container(
            //           height: 20,
            //           width: 20,
            //           decoration: BoxDecoration(
            //               border: Border.all(),
            //               borderRadius: BorderRadius.circular(7)),
            //         ),
            //         SizedBox(
            //           width: 80,
            //         ),
            //         Image.asset('asset/image.png'),
            //         SizedBox(
            //           width: 5,
            //         ),
            //         Image.asset('asset/delete.png'),
            //       ],
            //     ),
            //   )
            // ]),
          ]),
        ),
      ),
    );
  }
}
