import 'package:flutter/material.dart';
import 'services_exist_edit.dart';
import 'services_view.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Our Services',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // setState(() => show = !show);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Services_View()));
                },
                icon: Icon(Icons.edit, color: Colors.black))
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Center(
                  child: TextButton(
                      style: TextButton.styleFrom(
                        fixedSize: Size(100, 27),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Services_Exist_Edit()));
                      },
                      child: Center(
                        child: Text(
                          '+ Add New',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Wrap(
                  runSpacing: 20,
                  spacing: MediaQuery.of(context).size.width - (360),
                  children: [
                    Stack(children: [
                      Positioned(
                        left: 115,
                        bottom: 170,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            )),
                      ),
                      Container(
                        // color: Colors.red,
                        width: 150,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Image.asset(
                                'asset/bi_graph-up.jpg',
                                fit: BoxFit.none,
                              ),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      // color: !show
                                      //     ? Colors.white
                                      color: Colors.black.withOpacity(.15))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Brand Strategy And Management',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ]),
                    Stack(children: [
                      Positioned(
                        left: 115,
                        bottom: 170,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            )),
                      ),
                      Container(
                        // color: Colors.red,
                        width: 150,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Image.asset(
                                'asset/bi_tv.jpg',
                                fit: BoxFit.none,
                              ),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.15))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Brand Strategy And Management',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ]),
                    Stack(children: [
                      Positioned(
                        left: 115,
                        bottom: 170,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            )),
                      ),
                      Container(
                        // color: Colors.red,
                        width: 150,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Image.asset(
                                'asset/bi_person-badge-fill.jpg',
                                fit: BoxFit.none,
                              ),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.15))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Brand Strategy And Management',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ]),
                    Stack(children: [
                      Positioned(
                        left: 115,
                        bottom: 170,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            )),
                      ),
                      Container(
                        // color: Colors.red,
                        width: 150,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Image.asset(
                                'asset/bi_cloud-arrow-up-fill.jpg',
                                fit: BoxFit.none,
                              ),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.15))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Brand Strategy And Management',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ]),
                    Stack(children: [
                      Positioned(
                        left: 115,
                        bottom: 170,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            )),
                      ),
                      Container(
                        // color: Colors.red,
                        width: 150,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Image.asset(
                                'asset/bi_clipboard-check.jpg',
                                fit: BoxFit.none,
                              ),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.15))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Brand Strategy And Management',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
