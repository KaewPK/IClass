import 'package:iclass/model/mol_profile.dart';
import 'package:iclass/shared.dart/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static String urlLogin = "https://login.wframwork.com";
  static String urlUpload = "https://upload.wframwork.com";
  static String urlIClass = "https://iclass.wframwork.com";

  // Api POST ล็อกอิน
  static signIn(context, String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'CusCode': 'ICS-001',
      'UserName': username,
      'Password': password,
    };
    //print(data);
    try {
      var jsonResponse =
          await Const.httpPost(context, urlLogin + "/api/Login/Login", data);
      if (jsonResponse != null) {
        if (jsonResponse['data']["data"] != null) {
          sharedPreferences.setString("token", jsonResponse['data']['data']);
          print(sharedPreferences.getString("token"));
          return true;
        } else {
          print("Login Error");
          return false;
        }
      } else {
        print("Login Error");
        return false;
      }
    } catch (Exception) {
      print(Exception);
      return false;
    }
  }

  // Api POST เปลี่ยนรหัสผ่าน
  static chagepassword(context, String newpassword, confirmpassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var _token = sharedPreferences.getString('token');
    Map data = {
      'ApiKey': _token,
      'Password': newpassword,
      'ConfirmPassword': confirmpassword,
    };
    print("Password: " + newpassword);
    print("ConfirmPassword: " + confirmpassword);
    try {
      var jsonResponse = await Const.httpPost(
          context, Api.urlLogin + "/api/User/ChangePassword", data);
      if (jsonResponse != null) {
        print("Seccess");
        return true;
      } else {
        print("Error");
        return false;
      }
    } catch (Exception) {
      print(Exception);
      return false;
    }
  }

  // Api GET ดึงข้อมูลโปรไฟล์หน้าโปรไฟล์
  static getProfilepage(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var _token = sharedPreferences.getString('token');
    if (_token != null) {
      var jsonResponse = await Const.httpGet(
          context, urlLogin + '/api/User/GetProfile?ApiKey=' + _token);
      if (jsonResponse != null) {
        Const.profile = Profile.fromJson(jsonResponse["data"]);
        return true;
      } else {
        return false;
      }
    } else {
      print("No Profile");
      return false;
    }
  }

  // Api Post อัพเดทโปรไฟล์
  static sendProfile(
    context,
    image,
    gen,
    couseId,
    iDCardNumber,
    nameTH,
    nameEN,
    nickname,
    dathOfBirth,
    age,
    religion,
    email,
    address,
    phoneNumber,
    houseNumber,
    education,
    littleWork,
    career,
    duty,
    workplaceName,
    workplaceAddress,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    Map data = {
      'ApiKey': token,
      'ProfileProperty': [
        {
          'Property': "UserId",
          'Value': Const.profile.userId,
          'PropertyType': 1
        },
        {'Property': "Image", 'Value': image, 'PropertyType': 1},
        {'Property': "Gen", 'Value': gen, 'PropertyType': 2}, // int
        {'Property': "CouseId", 'Value': couseId, 'PropertyType': 2}, // int
        {'Property': "iDCardNumber", 'Value': iDCardNumber, 'PropertyType': 1},
        {'Property': "nameTH", 'Value': nameTH, 'PropertyType': 1},
        {'Property': "nameEN", 'Value': nameEN, 'PropertyType': 1},
        {'Property': "nickname", 'Value': nickname, 'PropertyType': 1},
        {'Property': "dathOfBirth", 'Value': dathOfBirth, 'PropertyType': 1},
        {'Property': "age", 'Value': age, 'PropertyType': 1},
        {'Property': "religion", 'Value': religion, 'PropertyType': 1},
        {'Property': "email", 'Value': email, 'PropertyType': 1},
        {'Property': "address", 'Value': address, 'PropertyType': 1},
        {'Property': "phoneNumber", 'Value': phoneNumber, 'PropertyType': 1},
        {'Property': "houseNumber", 'Value': houseNumber, 'PropertyType': 1},
        {'Property': "education", 'Value': education, 'PropertyType': 1},
        {'Property': "littleWork", 'Value': littleWork, 'PropertyType': 1},
        {'Property': "career", 'Value': career, 'PropertyType': 1},
        {'Property': "duty", 'Value': duty, 'PropertyType': 1},
        {
          'Property': "workplaceName",
          'Value': workplaceName,
          'PropertyType': 1
        },
        {
          'Property': "workplaceAddress",
          'Value': workplaceAddress,
          'PropertyType': 1
        }
      ]
    };
    print(data.toString());
    try {
      var jsonResponse = await Const.httpPost(
          context, urlLogin + "/api/User/UpdateProfiles", data);
      if (jsonResponse != null) {
        print("Update Profile Seccess");
        return true;
      } else {
        print("Error Update Profile");
        return false;
      }
    } catch (Exception) {
      print(Exception);
      return false;
    }
  }

  // Api Post Add Log Update Profile
  static addLogUpdateProfile(
    context,
    image,
    gen,
    couseId,
    iDCardNumber,
    nameTH,
    nameEN,
    nickname,
    dathOfBirth,
    age,
    religion,
    email,
    address,
    phoneNumber,
    houseNumber,
    education,
    littleWork,
    career,
    duty,
    workplaceName,
    workplaceAddress,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    Map data = {
      'ApiKey': token,
      'Property': [
        {
          'Property': "UserId",
          'Value': Const.profile.userId,
          'PropertyType': 1
        },
        {'Property': "Image", 'Value': image, 'PropertyType': 1},
        {'Property': "Gen", 'Value': gen, 'PropertyType': 2}, // int
        {'Property': "CouseId", 'Value': couseId, 'PropertyType': 2}, // int
        {'Property': "iDCardNumber", 'Value': iDCardNumber, 'PropertyType': 1},
        {'Property': "nameTH", 'Value': nameTH, 'PropertyType': 1},
        {'Property': "nameEN", 'Value': nameEN, 'PropertyType': 1},
        {'Property': "nickname", 'Value': nickname, 'PropertyType': 1},
        {'Property': "dathOfBirth", 'Value': dathOfBirth, 'PropertyType': 1},
        {'Property': "age", 'Value': age, 'PropertyType': 1},
        {'Property': "religion", 'Value': religion, 'PropertyType': 1},
        {'Property': "email", 'Value': email, 'PropertyType': 1},
        {'Property': "address", 'Value': address, 'PropertyType': 1},
        {'Property': "phoneNumber", 'Value': phoneNumber, 'PropertyType': 1},
        {'Property': "houseNumber", 'Value': houseNumber, 'PropertyType': 1},
        {'Property': "education", 'Value': education, 'PropertyType': 1},
        {'Property': "littleWork", 'Value': littleWork, 'PropertyType': 1},
        {'Property': "career", 'Value': career, 'PropertyType': 1},
        {'Property': "duty", 'Value': duty, 'PropertyType': 1},
        {
          'Property': "workplaceName",
          'Value': workplaceName,
          'PropertyType': 1
        },
        {
          'Property': "workplaceAddress",
          'Value': workplaceAddress,
          'PropertyType': 1
        }
      ]
    };
    print(data.toString());
    try {
      var jsonResponse = await Const.httpPost(
          context, urlIClass + "/api/Log/AddLogUpdate", data);
      if (jsonResponse != null) {
        print("AddLogUpdate Seccess");
        return true;
      } else {
        print("Error AddLogUpdate");
        return false;
      }
    } catch (Exception) {
      print(Exception);
      return false;
    }
  }
}
