import 'package:final_app/views/chat_views/chat_home.dart';
import 'package:final_app/views/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import '../shared_preferences.dart';
import 'services.dart';
import 'update_tab.dart';

import 'explore_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _kFontFam = 'MyFlutterApp';
  String currentUserName;
  static const String _kFontPkg = null;
  Color _color = Colors.white;
  static const IconData lnr_bubble =
      IconData(0xe83f, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  List<Widget> _screens;
  PageController _pageController = PageController();
  @override
  void initState() {
    Services().configureNotifs();
    SharedPreference.getUserName().then((value) {
      setState(() {
        currentUserName = value;
        _screens = [
          Explore_Tab(currentUserName),
          ChatHomeScreen(),
          SearchPage(),
        ];
      });
    });
    super.initState();
  }

  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: currentUserName == null
          ? Center(child: CircularProgressIndicator())
          : PageView(
              controller: _pageController,
              children: _screens,
              onPageChanged: _onPageChanged,
              physics: NeverScrollableScrollPhysics(),
            ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
          selectedIconTheme: IconThemeData(size: 45),
          iconSize: 35,
          unselectedItemColor: Colors.blue,
          elevation: 0,
          backgroundColor: HexColor('#FBFBFB'),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.contact_page_outlined),
                title: Text(
                  'Porfolio',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                title: Text('Chats',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold))),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_sharp),
                title: Text('Search',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold))),
          ]),
    );
  }
}
