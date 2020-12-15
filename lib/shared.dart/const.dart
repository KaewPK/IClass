import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:iclass/login.dart';
import 'package:iclass/model/mol_profile.dart';
import 'package:iclass/shared.dart/api.dart';
import 'dart:convert';
import 'package:iclass/widget/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Const {
  static Profile profile;
  static dynamic httpPost(context, url, param) async {
    try {
      dynamic res;
      await http
          .post(url,
              body: json.encode(param),
              headers: {"Content-Type": "application/json", "lang": "th"},
              encoding: Encoding.getByName("utf-8"))
          .then(
        (value) {
          if (value.statusCode != 200) {
            if (value.body != "") {
              if (!json
                  .decode(value.body)["message"]
                  .toString()
                  .startsWith("Object")) {
                if (!json
                    .decode(value.body)["message"]
                    .toString()
                    .startsWith("Token")) {
                  if (json.decode(value.body)["message"] ==
                      "User is not Login") {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => CustomDialogAvatar(
                        title: "ผิดพลาด",
                        description: json.decode(value.body)["message"],
                        buttonText: "ตกลง",
                        onPressed: () {
                          Const.removeValues();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Login(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    );
                  } else if (context != null) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => CustomDialogAvatar(
                        title: "ผิดพลาด",
                        description: json.decode(value.body)["message"],
                        buttonText: "ตกลง",
                        onPressed: () => Navigator.pop(context),
                      ),
                    );
                  }
                }
              }
            }
          } else {
            res = json.decode(value.body);
          }
        },
        onError: (error) => {print("Error")},
      );
      return res;
    } catch (Exception) {
      print(Exception);
    }
  }

  static dynamic httpGet(context, url) async {
    try {
      dynamic res;
      await http.get(url).then(
        (value) {
          if (value.statusCode != 200) {
            if (value.body != "") {
              if (!json
                  .decode(value.body)["message"]
                  .toString()
                  .startsWith("Object")) {
                if (!json
                    .decode(value.body)["message"]
                    .toString()
                    .startsWith("Token")) {
                  if (json.decode(value.body)["message"] ==
                      "User is not Login") {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => CustomDialogAvatar(
                        title: "ผิดพลาด",
                        description: json.decode(value.body)["message"],
                        buttonText: "ตกลง",
                        onPressed: () {
                          Const.removeValues();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Login(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    );
                  } else if (context != null) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => CustomDialogAvatar(
                        title: "ผิดพลาด",
                        description: json.decode(value.body)["message"],
                        buttonText: "ตกลง",
                        onPressed: () => Navigator.pop(context),
                      ),
                    );
                  }
                }
              }
            }
          } else {
            res = json.decode(value.body);
          }
        },
        onError: (error) => {
          {print("Error")},
        },
      );
      return res;
    } catch (Exception) {
      print(Exception);
    }
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    print("onฺBgMessage: $message");
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }
    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
  }

  static void getToken(context) async {
    String _title, _body;
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        print("onMessage: $message");
        _title = message["notification"]["title"];
        _body = message["notification"]["body"];
        showNotificationWithSound(_title, _body);
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((firebaseToken) async {
      assert(firebaseToken != null);
      print("token: $firebaseToken");
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var _islogin = sharedPreferences.getString('token');
      // Api
      await Const.httpGet(
        context,
        Api.urlLogin +
            "/api/Login/RegisterFirebase?ApiKey=" +
            _islogin +
            "&Firebase=" +
            (firebaseToken ?? ""),
      );
    });
  }

  static showNotification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelect);
  }

  static Future onSelect(String data) async {
    print("onSelectNotification $data");
  }

  // show notification
  static Future showNotificationWithSound(_title, _body) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
      playSound: true,
      enableLights: true,
      enableVibration: true,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      _title,
      _body,
      platformChannelSpecifics,
      payload: _body,
    );
  }

  // Logout Clear Value
  static removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("token");
    //print(prefs.get('token'));
  }
}
