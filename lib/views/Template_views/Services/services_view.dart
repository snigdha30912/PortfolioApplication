import 'package:flutter/material.dart';
import 'services_exist_edit.dart';

class Services_View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
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
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Services_Exist_Edit()));
              },
            ),
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 60,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       IconButton(
          //         icon: Icon(
          //           Icons.arrow_back,
          //           color: Colors.black,
          //           size: 25,
          //         ),
          //         onPressed: () {},
          //       ),
          //       SizedBox(width: 300),
          //       IconButton(
          //         icon: Icon(
          //           Icons.edit,
          //           color: Colors.black,
          //           size: 25,
          //         ),
          //         onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (_) => Services_Edit()));
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          Text('Brand Strategy And Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Image.asset(
            'asset/SrZRt6J.jpg',
            height: 344,
            width: MediaQuery.of(context).size.width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('- Services Features',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text('-  Lorem ipsum dolor shit amet, consect adipiscing'),
            ],
          )
        ]))));
  }
}
