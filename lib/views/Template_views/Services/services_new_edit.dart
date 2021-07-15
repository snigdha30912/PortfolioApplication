// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';

// class Services_New_Edit extends StatefulWidget {
//   @override
//   _Services_New_EditState createState() => _Services_New_EditState();
// }

// class _Services_New_EditState extends State<Services_New_Edit> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.only(top: 30),
//               height: 85,
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.arrow_back,
//                     size: 40,
//                     color: HexColor('#626060'),
//                   ),
//                   SizedBox(width: 15),
//                   Text('Edit',
//                       style: TextStyle(
//                         color: HexColor('#000000'),
//                         fontWeight: FontWeight.w500,
//                         fontSize: 19,
//                       )),
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: TextButton(
//                         style: TextButton.styleFrom(
//                           backgroundColor: HexColor('#34B3FC'),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(100)),
//                         ),
//                         onPressed: () {},
//                         child: Text(
//                           'Save',
//                           style: TextStyle(color: Colors.white),
//                         )),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               height: 1,
//               color: HexColor('#C4C4C4'),
//               width: MediaQuery.of(context).size.width,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 border:
//                     Border.all(width: 1, color: Colors.black.withOpacity(.15)),
//                 shape: BoxShape.circle,
//                 color: Colors.white,
              
//               ),
//               child: Center(
//                 child: GestureDetector(
//                   onTap: () {
//                   },
//                   child: Center(
//                     child: Text(
//                       '+\nAdd Cover',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 17),
//                     ),
//                   ),
//                 ),
//               ),
//               height: 160,
//               width: 160,
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             // Text(
//             //   'Change Cover',
//             //   style: TextStyle(
//             //       color: HexColor('#34B3FC'),
//             //       fontSize: 16,
//             //       fontWeight: FontWeight.w500),
//             // )

//             //             : Column(
//             //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //                 children: [
//             //                   Stack(children: [
//             //                     CircleAvatar(
//             //                       radius: 80,
//             //                       backgroundImage: NetworkImage(
//             //                         'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
//             //                       ),
//             //                     ),
//             //                   ]),
//             //                   Text(
//             //                     'Change Cover',
//             //                     style: TextStyle(
//             //                         color: HexColor('#34B3FC'),
//             //                         fontSize: 16,
//             //                         fontWeight: FontWeight.w500),
//             //                   )
//             //                 ],
//             //               );
//             //       }),
//             // ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   'Services Name',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 Container(
//                   height: 38,
//                   width: 245,
//                   child: TextField(
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15))),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: 30),
//             Padding(
//               padding: const EdgeInsets.only(left: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Service Features',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: TextFormField(
//                 decoration: InputDecoration(prefixText: '1.'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: TextFormField(
//                 decoration: InputDecoration(prefixText: '2.'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: TextFormField(
//                 decoration: InputDecoration(prefixText: '3.'),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                       style: TextButton.styleFrom(
//                         backgroundColor: HexColor('#34B3FC'),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(100)),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         'Add More',
//                         style: TextStyle(color: Colors.white),
//                       )),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'Add a supportive photo/explanatory video of the services provided-',
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Opacity(
//               opacity: 0.8,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.black,
//                 ),
//                 height: 100,
//                 width: 140,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Add Photo',
//                           style: TextStyle(color: Colors.white, fontSize: 15),
//                         )
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(right: 7),
//                                 child: IconButton(
//                                     icon: Icon(
//                                       Icons.camera_alt,
//                                       size: 40,
//                                       color: Colors.white,
//                                     ),
//                                     onPressed: () {
//                                       // _getFromCamera();
//                                     }),
//                               ),
//                               Text(
//                                 'Camera',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 12),
//                               )
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 4),
//                               child: IconButton(
//                                 icon: Icon(
//                                   CupertinoIcons.photo,
//                                   size: 37,
//                                   color: Colors.white,
//                                 ),
//                                 onPressed: () {
//                                   // _getFromGallery();
//                                 },
//                               ),
//                             ),
//                             Text(
//                               'Gallery',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 12),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
