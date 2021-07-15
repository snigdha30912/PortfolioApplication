import 'package:final_app/views/Template_views/basic_one.dart';
import 'package:final_app/views/Template_views/home.dart';
import 'package:flutter/material.dart';

class Explore_Tab extends StatelessWidget {
  String currentUserName;
  Explore_Tab(this.currentUserName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 200),
            Center(
              child: Text(
                'Choose Template'.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 100),
            Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BasicOne(
                              currentUserName: currentUserName,
                              templateUserName: currentUserName,
                              type: 1,
                            )),
                  );
                },
                child: Center(
                  child: Text(
                    'Basic One',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BasicOne(
                        currentUserName: currentUserName,
                        templateUserName: currentUserName,
                        type: 2,
                      ),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    'Basic Two',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
