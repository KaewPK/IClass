import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:iclass/forgetPassword.dart';
import 'package:iclass/shared.dart/api.dart';
import 'package:iclass/shared.dart/color.dart';
import 'package:iclass/selectCourse.dart';
import 'package:iclass/widget/dialog.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _validate = false;
  bool _isLoading = false;
  bool rememberMe = false;
  bool dialogreturn = false;
  bool _obscureTextLogin = true;
  String user_remember, pass_remember;

  @override
  void initState() {
    super.initState();
    checkdata_remember();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void clearText() {
    _username.clear();
    _password.clear();
  }

  void rememberme_clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("username");
    prefs.remove("password");
    setState(() {
      rememberMe = false;
    });
  }

  void checkdata_remember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_remember = prefs.get('username');
      pass_remember = prefs.get('password');
      user_remember != null && pass_remember != null
          ? rememberMe = true
          : rememberMe = false;
    });
    user_remember != null && pass_remember != null
        ? {_username.text = user_remember, _password.text = pass_remember}
        : null;
  }

  void remember_me(String user, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("username", user);
    sharedPreferences.setString("password", pass);
  }

  void showdialogCheckLogin() async {
    final result = await Api.signIn(context, _username.text, _password.text);
    if (result == true) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CustomDialogAvatar(
          title: "สำเร็จ",
          description: 'เข้าสู่ระบบสำเร็จ',
          buttonText: "ตกลง",
          onPressed: () async {
            setState(() {
              _isLoading = false;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => SelectCourse()),
                  (Route<dynamic> route) => false);
            });
          },
        ),
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CustomDialogAvatar(
          title: "ผิดพลาด",
          description: 'รหัสผ่านไม่ถูกต้อง',
          buttonText: "ตกลง",
          onPressed: () async {
            setState(() {
              _isLoading = false;
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) => Login()),
                  (Route<dynamic> route) => false);
            });
          },
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
          backgroundColor: ColorTheme.bluedark,
          body: _isLoading
              ? loading(context)
              : SingleChildScrollView(
                  child: Container(
                    height: size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: size.width * 0.05,
                            top: size.height * 0.05,
                            right: size.width * 0.05,
                          ),
                          child: Image.asset(
                            'assets/logotext.png',
                            width: size.width * 0.9,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: size.width * 0.08,
                            top: size.height * 0.02,
                            right: size.width * 0.08,
                          ),
                          child: Column(
                            children: [
                              textField(
                                  context, _username, false, 'Email', null),
                              textField(
                                context,
                                _password,
                                _obscureTextLogin,
                                'Password',
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureTextLogin = !_obscureTextLogin;
                                    });
                                  },
                                  child: Icon(
                                    _obscureTextLogin
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 18,
                                    color: ColorTheme.bluedark,
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Theme(
                                            data: Theme.of(context).copyWith(
                                              unselectedWidgetColor:
                                                  Colors.white,
                                              disabledColor: Colors.white,
                                            ),
                                            child: Checkbox(
                                              activeColor: ColorTheme.green,
                                              value: rememberMe,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  rememberMe = value;
                                                });
                                              },
                                            ),
                                          ),
                                          Text(
                                            "Remember me",
                                            style: TextStyle(
                                                fontFamily: 'K2D',
                                                color: Colors.white,
                                                fontSize: size.height * 0.018),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          rememberMe = !rememberMe;
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ForgetPassword(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                          fontFamily: 'K2D',
                                          color: Colors.white,
                                          fontSize: size.height * 0.018,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: size.width * 0.05,
                                  top: size.height * 0.05,
                                  right: size.width * 0.05,
                                ),
                                child: RaisedButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      _username.text.isEmpty ||
                                              _password.text.isEmpty
                                          ? _validate = true
                                          : _validate = false;
                                      _validate
                                          ? _isLoading = false
                                          : _isLoading = true;
                                    });
                                    setState(() {
                                      showdialogCheckLogin();
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    width: size.width * 0.8,
                                    height: size.height * 0.06,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Login',
                                          style: TextStyle(
                                            fontFamily: 'K2D',
                                            color: ColorTheme.bluedark,
                                            fontWeight: FontWeight.w700,
                                            fontSize: size.height * 0.018,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: size.height * 0.05,
                          ),
                          child: ClipPath(
                            clipper: OvalTopBorderClipper(),
                            child: Container(
                              height: size.height * 0.25,
                              color: ColorTheme.green,
                            ),
                          ),
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

Widget loading(context) {
  final size = MediaQuery.of(context).size;
  return Container(
    child: Center(
      child: ScalingText(
        'Loading...',
        style: TextStyle(
          fontSize: size.height * 0.02,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget textField(context, controller, obscureText, hintText, suffixIcon) {
  final size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(top: size.height * 0.025),
    height: size.height * 0.075,
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'K2D',
          fontSize: size.height * 0.018,
          color: ColorTheme.bluedark,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(size.height * 0.018),
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
      ),
    ),
  );
}
