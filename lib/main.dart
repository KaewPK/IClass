import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iclass/selectCourse.dart';
import 'package:iclass/shared.dart/color.dart';
import 'package:iclass/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Function duringSplash = () {
    return 1;
  };
  //Map<int, Widget> op = {1: MyApp()};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var _islogin = prefs.getString('token');
  print(_islogin);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      home: CustomSplash(
        imagePath: 'assets/logotext.png',
        backGroundColor: ColorTheme.bluedark,
        animationEffect: 'zoom-in',
        logoSize: 250,
        home: _islogin == null ? Login() : SelectCourse(),
        customFunction: duringSplash,
        duration: 3000,
        type: CustomSplashType.StaticDuration,
        //outputAndHome: op,
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  Future<bool> chekLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var _token = sharedPreferences.getString('token');
    if (_token != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
