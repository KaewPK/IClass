import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iclass/shared.dart/color.dart';
import 'package:iclass/mainpage.dart';

class SelectCourse extends StatefulWidget {
  SelectCourse({Key key}) : super(key: key);

  @override
  _SelectCourseState createState() => _SelectCourseState();
}

class _SelectCourseState extends State<SelectCourse> {
  List<String> image = <String>[
    'assets/NDC.jpg',
    'assets/RoyalThaiArmyERDC.jpg',
    'assets/ISPndsiRTARF.jpg',
    'assets/NDC.jpg',
    'assets/RoyalThaiArmyERDC.jpg',
    'assets/ISPndsiRTARF.jpg',
    'assets/NDC.jpg',
    'assets/RoyalThaiArmyERDC.jpg',
    'assets/ISPndsiRTARF.jpg',
    'assets/NDC.jpg',
    'assets/RoyalThaiArmyERDC.jpg',
    'assets/ISPndsiRTARF.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: ColorTheme.blacklight,
          body: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height - size.height * 0.05,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: Text(
                      'ยินดีต้อนรับ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'K2D',
                        color: ColorTheme.bluedark,
                        fontSize: size.height * 0.025,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.02,
                      bottom: size.height * 0.02,
                    ),
                    child: Text(
                      'กรุณากดเลือกหลักสูตรของท่าน',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'K2D',
                        color: ColorTheme.bluedark,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      size.width * 0.08,
                      size.height * 0.02,
                      size.width * 0.08,
                      size.height * 0.02,
                    ),
                    shrinkWrap: true,
                    itemCount: image.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: size.height * 0.03,
                      crossAxisSpacing: size.width * 0.075,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Mainpage(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(size.height * 0.02),
                          child: Image.asset(
                            image[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
