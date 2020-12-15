import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iclass/shared.dart/color.dart';
import 'shared.dart/color.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _username = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: ColorTheme.blacklight,
          body: Container(
            width: size.width,
            height: size.height,
            color: ColorTheme.blacklight,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/lock.png',
                              fit: BoxFit.contain,
                              height: size.height * 0.1,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: size.height * 0.03),
                              child: Text(
                                'Forget your',
                                style: TextStyle(
                                  fontFamily: 'K2D',
                                  color: ColorTheme.bluedark,
                                  fontSize: size.height * 0.035,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: size.height * 0.01),
                              child: Text(
                                'Password ?',
                                style: TextStyle(
                                  fontFamily: 'K2D',
                                  color: ColorTheme.bluedark,
                                  fontSize: size.height * 0.03,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                size.width * 0.1,
                                size.height * 0.03,
                                size.width * 0.1,
                                size.height * 0.03,
                              ),
                              child: Text(
                                "Confirm your email and we'll send the instructions.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'K2D',
                                  color: ColorTheme.bluedark.withOpacity(0.5),
                                  fontSize: size.height * 0.025,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          size.width * 0.08,
                          size.height * 0.045,
                          size.width * 0.08,
                          size.height * 0.065,
                        ),
                        child: TextField(
                          controller: _username,
                          decoration: InputDecoration(
                            hintText: 'Email or Username',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: ColorTheme.bluedark,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                                color: Colors.white10,
                              ),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(16),
                            fillColor: ColorTheme.blacklight,
                          ),
                        ),
                      ),
                      RaisedButton(
                        color: ColorTheme.bluedark,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          width: size.width * 0.3,
                          height: size.height * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'ยืนยัน',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.018,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: ColorTheme.bluedark,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
