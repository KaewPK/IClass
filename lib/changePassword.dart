import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iclass/shared.dart/api.dart';
import 'package:iclass/shared.dart/color.dart';
import 'package:iclass/widget/dialog.dart';
import 'shared.dart/color.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _newpassword = TextEditingController();
  final _confirmpassword = TextEditingController();
  bool _isLoading = false;
  bool _validate = false;
  bool _obscureTextNewPassword = true;
  bool _obscureTextConfirmPassword = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _newpassword.dispose();
    _confirmpassword.dispose();
    super.dispose();
  }

  void showdialogCheck() async {
    final result = await Api.chagepassword(
        context, _newpassword.text, _confirmpassword.text);
    if (result == true) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CustomDialogAvatar(
          title: "สำเร็จ",
          description: 'เปลี่ยนรหัสผ่านสำเร็จ',
          buttonText: "ตกลง",
          onPressed: () async {
            setState(() {
              _isLoading = false;
              _newpassword.clear();
              _confirmpassword.clear();
              Navigator.pop(context);
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
          description: 'เปลี่ยนรหัสผ่านไม่สำเร็จ กรุณาลองใหม่อีกครั้ง',
          buttonText: "ตกลง",
          onPressed: () async {
            setState(() {
              _isLoading = false;
              Navigator.pop(context);
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: ColorTheme.green,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              iconSize: size.height * 0.03,
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'เปลี่ยนรหัสผ่าน',
              style: TextStyle(
                fontFamily: 'K2D',
                color: Colors.white,
                fontSize: size.height * 0.022,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Container(
            width: size.width,
            color: ColorTheme.green,
            padding: EdgeInsets.only(top: size.height * 0.025),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: size.width * 0.05,
                        top: size.height * 0.02,
                        right: size.width * 0.05,
                      ),
                      child: Image.asset(
                        'assets/3275434.jpg',
                        width: size.width * 0.7,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          size.width * 0.05,
                          size.height * 0.02,
                          size.width * 0.05,
                          size.height * 0.02),
                      child: TextField(
                        controller: _newpassword,
                        obscureText: _obscureTextNewPassword,
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          hintStyle:
                              TextStyle(fontSize: 16, color: ColorTheme.green),
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
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureTextNewPassword =
                                    !_obscureTextNewPassword;
                              });
                            },
                            child: Icon(
                              _obscureTextNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: size.height * 0.018,
                              color: ColorTheme.bluedark,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 20, 50),
                      child: TextField(
                        controller: _confirmpassword,
                        obscureText: _obscureTextConfirmPassword,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle:
                              TextStyle(fontSize: 16, color: ColorTheme.green),
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
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureTextConfirmPassword =
                                    !_obscureTextConfirmPassword;
                              });
                            },
                            child: Icon(
                              _obscureTextConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: size.height * 0.018,
                              color: ColorTheme.bluedark,
                            ),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: ColorTheme.green,
                      onPressed: () {
                        setState(() {
                          _newpassword.text.isEmpty ||
                                  _confirmpassword.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          _validate ? _isLoading = false : _isLoading = true;
                        });
                        setState(() {
                          showdialogCheck();
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        width: size.width * 0.8,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
