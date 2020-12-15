import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iclass/profileFeed.dart';
import 'package:iclass/shared.dart/color.dart';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<String> image = <String>[
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg',
  ];
  List<String> name = <String>[
    'ญานิชศา ธงนำชัยมา',
    'อรุณศรี รักษ์มณี',
    'ธนวัฒน์ จิรคูณสมบัติ',
  ];
  List<String> generation = <String>[
    '18',
    '18',
    '18',
  ];
  List<String> email = <String>[
    'aaaaaaaa@hotmail.com',
    'aaaaaaaa@hotmail.com',
    'aaaaaaaa@hotmail.com',
  ];
  List<String> phone = <String>[
    '098-8301993',
    '094-9896999',
    '086-9999825',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: ColorTheme.blacklight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.05,
              size.height * 0.03,
              size.width * 0.03,
              size.height * 0.03,
            ),
            height: size.height * 0.125,
            decoration: BoxDecoration(
              color: ColorTheme.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: size.width * 0.02),
                  child: CircleAvatar(
                    radius: size.height * 0.04,
                    backgroundImage: AssetImage('assets/NDC.jpg'),
                  ),
                ),
                Text(
                  'หลักสูตรจิตวิทยาความมั่นคง',
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: 'K2D',
                    color: Colors.white,
                    fontSize: size.height * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  iconSize: size.height * 0.03,
                  onPressed: () {},
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.05,
                size.height * 0.03,
                size.width * 0.03,
                size.height * 0.03,
              ),
              scrollDirection: Axis.vertical,
              itemCount: name.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: size.height * 0.15,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: size.width * 0.08,
                        right: size.width * 0.05,
                        child: Container(
                          height: size.height * 0.125,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(
                            size.width * 0.15,
                            size.height * 0.02,
                            size.width * 0.05,
                            size.height * 0.02,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: size.height * 0.01,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      name[index],
                                      style: TextStyle(
                                        fontFamily: 'K2D',
                                        color: ColorTheme.bluedark,
                                        fontSize: size.height * 0.015,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'รุ่นที่ : ' + generation[index],
                                      style: TextStyle(
                                        fontFamily: 'K2D',
                                        color: ColorTheme.bluedark,
                                        fontSize: size.height * 0.0125,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: size.height * 0.005,
                                ),
                                child: Text(
                                  'E-mail : ' + email[index],
                                  style: TextStyle(
                                    fontFamily: 'K2D',
                                    color: ColorTheme.bluedark,
                                    fontSize: size.height * 0.0125,
                                  ),
                                ),
                              ),
                              Text(
                                'เบอร์โทร : ' + phone[index],
                                style: TextStyle(
                                  fontFamily: 'K2D',
                                  color: ColorTheme.bluedark,
                                  fontSize: size.height * 0.0125,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.015,
                        left: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: Image.asset(
                            image[index],
                            fit: BoxFit.cover,
                            height: size.height * 0.1,
                            width: size.width * 0.2,
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.04,
                        right: 0,
                        child: ClipOval(
                          child: Material(
                            color: ColorTheme.green,
                            child: InkWell(
                              splashColor: Colors.red,
                              child: SizedBox(
                                width: size.width * 0.115,
                                height: size.height * 0.05,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ProfileFeed(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
