import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iclass/shared.dart/color.dart';
import 'package:iclass/feed.dart';
import 'package:iclass/message.dart';
import 'package:iclass/setting.dart';
import 'package:iclass/shared.dart/const.dart';

class Mainpage extends StatefulWidget {
  Mainpage({Key key}) : super(key: key);

  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _currentIndex = 0;
  final Feed feed = Feed();
  final Message message = Message();
  final Setting setting = Setting();

  @override
  void initState() {
    super.initState();
    Const.showNotification();
    Const.getToken(context);
  }

  Widget _showPage = Feed();
  Widget _pageChooser(int page) {
    final size = MediaQuery.of(context).size;
    switch (page) {
      case 0:
        return feed;
        break;
      case 1:
        return message;
        break;
      case 2:
        return setting;
        break;
      default:
        return new Container(
          child: Center(
            child: Text(
              "No page found by page chooser.",
              style: TextStyle(fontSize: size.height * 0.02),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: ColorTheme.blacklight,
          body: _showPage,
          bottomNavigationBar: FFNavigationBar(
            theme: FFNavigationBarTheme(
              barHeight: size.height * 0.08,
              barBackgroundColor: Colors.white,
              selectedItemBackgroundColor: ColorTheme.green,
              selectedItemIconColor: Colors.white,
              selectedItemLabelColor: Colors.black,
            ),
            selectedIndex: _currentIndex,
            onSelectTab: (index) => setState(() {
              _currentIndex = index;
              _showPage = _pageChooser(index);
            }),
            items: [
              FFNavigationBarItem(
                iconData: Icons.assignment,
                label: 'ทำเนียบรุ่น',
              ),
              FFNavigationBarItem(
                iconData: Icons.notifications,
                label: 'อัพเดท',
              ),
              FFNavigationBarItem(
                iconData: Icons.person,
                label: 'โปรไฟล์',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
