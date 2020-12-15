import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iclass/changePassword.dart';
import 'package:iclass/shared.dart/api.dart';
import 'package:iclass/shared.dart/color.dart';
import 'package:iclass/login.dart';
import 'package:iclass/profile.dart';
import 'package:iclass/selectCourse.dart';
import 'package:iclass/shared.dart/const.dart';
import 'package:iclass/widget/dialog.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String nameTH, email;
  bool loaddata = false;
  checkdata() async {
    final result = await Api.getProfilepage(context);
    if (result == true) {
      setState(() {
        loaddata = true;
        nameTH = (Const.profile.nameTH == null) ? "-" : Const.profile.nameTH;
        email = (Const.profile.email == null) ? "-" : Const.profile.email;
      });
    } else {
      setState(() {
        loaddata = false;
      });
    }
  }

  @override
  void initState() {
    checkdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loaddata == true
        ? SingleChildScrollView(
            child: Container(
              color: Colors.grey[200],
              child: Stack(
                children: [
                  Container(height: size.height * 0.2, color: ColorTheme.green),
                  Container(
                    width: size.width,
                    height: size.height,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: size.height * 0.025,
                        left: size.width * 0.075,
                        right: size.width * 0.075,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width,
                            height: size.height * 0.285,
                            child: Stack(children: [
                              Positioned(
                                top: size.height * 0.125,
                                child: Container(
                                  width: size.width * 0.85,
                                  height: size.height * 0.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.06,
                                      bottom: size.height * 0.02,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        textTitle(
                                          nameTH,
                                          size.height * 0.02,
                                          FontWeight.w500,
                                          Colors.black,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.01),
                                          child: textTitle(
                                            email,
                                            size.height * 0.018,
                                            FontWeight.w500,
                                            Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: CircleAvatar(
                                  radius: size.height * 0.09,
                                  backgroundColor: ColorTheme.bluedark,
                                  child: CircleAvatar(
                                    radius: size.height * 0.085,
                                    backgroundImage: NetworkImage(Api
                                            .urlUpload +
                                        "/api/Upload/GetImageThumbnail?Cuscode=ICS-001&id=" +
                                        Const.profile.image +
                                        '&width=250&height=500'),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Profile(),
                                ),
                              );
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.01),
                              width: size.width,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.05,
                                    right: size.width * 0.05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.person,
                                            color: ColorTheme.bluedark),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02),
                                          child: textTitle(
                                              "โปรไฟล์",
                                              size.height * 0.018,
                                              FontWeight.w500,
                                              Colors.black),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: ColorTheme.green,
                                      size: size.width * 0.06,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SelectCourse(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.01),
                              width: size.width,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.05,
                                    right: size.width * 0.05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.assignment,
                                            color: ColorTheme.bluedark),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02),
                                          child: textTitle(
                                              "เลือกหลักสูตร",
                                              size.height * 0.018,
                                              FontWeight.w500,
                                              Colors.black),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: ColorTheme.green,
                                      size: size.width * 0.06,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ChangePassword(),
                                ),
                              );
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.01),
                              width: size.width,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.05,
                                    right: size.width * 0.05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.mode_edit,
                                            color: ColorTheme.bluedark),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02),
                                          child: textTitle(
                                              "เปลี่ยนรหัสผ่าน",
                                              size.height * 0.018,
                                              FontWeight.w500,
                                              Colors.black),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: ColorTheme.green,
                                      size: size.width * 0.06,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => showDialog(
                              context: context,
                              barrierDismissible: false, // for tap button!
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  text: "จะพร้อมให้บริการในเร็วๆนี้",
                                  textButton: "ตกลง",
                                  colorButton: ColorTheme.orange,
                                  colorTextButton: Colors.white,
                                  fontSizeText: size.height * 0.025,
                                  fontSizeTextButton: size.height * 0.018,
                                  onPressed: () => Navigator.pop(context),
                                );
                              },
                            ),
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.01),
                              width: size.width,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.05,
                                    right: size.width * 0.05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.help,
                                            color: ColorTheme.bluedark),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02),
                                          child: textTitle(
                                              "ขอความช่วยเหลือ",
                                              size.height * 0.018,
                                              FontWeight.w500,
                                              Colors.black),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: ColorTheme.green,
                                      size: size.width * 0.06,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => showDialog(
                              context: context,
                              barrierDismissible: false, // for tap button!
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  text: "จะพร้อมให้บริการในเร็วๆนี้",
                                  textButton: "ตกลง",
                                  colorButton: ColorTheme.orange,
                                  colorTextButton: Colors.white,
                                  fontSizeText: size.height * 0.025,
                                  fontSizeTextButton: size.height * 0.018,
                                  onPressed: () => Navigator.pop(context),
                                );
                              },
                            ),
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.01),
                              width: size.width,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.05,
                                    right: size.width * 0.05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.group,
                                            color: ColorTheme.bluedark),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02),
                                          child: textTitle(
                                              "เกี่ยวกับเรา",
                                              size.height * 0.018,
                                              FontWeight.w500,
                                              Colors.black),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: ColorTheme.green,
                                      size: size.width * 0.06,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Const.removeValues();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Login(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.01),
                              width: size.width,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: size.width * 0.05,
                                    right: size.width * 0.05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.logout,
                                            color: ColorTheme.bluedark),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02),
                                          child: textTitle(
                                              "ออกจากระบบ",
                                              size.height * 0.018,
                                              FontWeight.w500,
                                              Colors.black),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: ColorTheme.green,
                                      size: size.width * 0.06,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            color: ColorTheme.green,
            padding: EdgeInsets.only(top: size.height * 0.1),
            child: Container(
              decoration: BoxDecoration(
                color: ColorTheme.blacklight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: ScalingText(
                  'Loading Profile ...',
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    color: ColorTheme.green,
                  ),
                ),
              ),
            ),
          );
  }

  Widget textTitle(text, fontSize, fontWeight, color) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Heavent",
        fontWeight: fontWeight,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}
