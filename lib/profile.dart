import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iclass/shared.dart/api.dart';
import 'package:iclass/shared.dart/color.dart';
import 'package:iclass/shared.dart/const.dart';
import 'package:iclass/widget/dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'shared.dart/color.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final gen = TextEditingController();
  final couseId = TextEditingController();
  final iDCardNumber = TextEditingController();
  final nameTH = TextEditingController();
  final nameEN = TextEditingController();
  final nickname = TextEditingController();
  final dathOfBirth = TextEditingController();
  final age = TextEditingController();
  final religion = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final houseNumber = TextEditingController();
  final education = TextEditingController();
  final littleWork = TextEditingController();
  final career = TextEditingController();
  final duty = TextEditingController();
  final workplaceName = TextEditingController();
  final workplaceAddress = TextEditingController();
  bool editing, loaddata, visble_list = false;
  final picker = ImagePicker();
  File imageFile;
  int image;

  Future chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    pickedFile == null
        ? null
        : {
            setState(() {
              imageFile = File(pickedFile.path);
              visble_list = false;
            }),
          };

    if (imageFile != null) {
      var res = await updaloadPic(imageFile.path.toString());
    }
  }

  Widget showImage() {
    final size = MediaQuery.of(context).size;
    return (image != null)
        ? Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.gif',
                      image: Api.urlUpload +
                          "/api/Upload/GetImageThumbnail?Cuscode=ICS-001&id=" +
                          image.toString() +
                          '&width=400&height=500',
                      fit: BoxFit.contain,
                      height: size.height * 0.3,
                    ),
                  ),
                ),
              ),
            ],
          )
        : (imageFile != null)
            ? Stack(children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    width: size.width * 0.6,
                    height: size.height * 0.3,
                    child: Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ])
            : Container(
                padding: EdgeInsets.only(top: size.height * 0.02),
                width: size.width * 0.6,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/emptyimage.png',
                  fit: BoxFit.contain,
                ),
              );
  }

  updaloadPic(String path) async {
    try {
      var url = Uri.parse(Api.urlUpload + "/api/Upload/Image?cuscode=ICS-001");
      var request = new http.MultipartRequest("PUT", url);
      request.files.add(((await http.MultipartFile.fromPath("file", path))));
      request.send().then((response) async {
        var data = jsonDecode(await response.stream.bytesToString())['data']
            ['imageId'];
        print(data);
        setState(() {
          image = data;
          print(image);
          visble_list = true;
        });
      });
    } catch (Exception) {
      print(Exception);
    }
  }

  chkimage() {
    if (Const.profile.image != null) {
      setState(() {
        image = int.parse(Const.profile.image);
        visble_list = true;
      });
      print(image);
    }
  }

  checkdata() async {
    final result = await Api.getProfilepage(context);
    if (result == true) {
      setState(() {
        loaddata = true;
        gen.text =
            (Const.profile.gen == null) ? "0" : Const.profile.gen.toString();
        couseId.text = (Const.profile.couseId == null)
            ? "0"
            : Const.profile.couseId.toString();
        iDCardNumber.text = (Const.profile.iDCardNumber == null)
            ? "-"
            : Const.profile.iDCardNumber;
        nameTH.text =
            (Const.profile.nameTH == null) ? "-" : Const.profile.nameTH;
        nameEN.text =
            (Const.profile.nameEN == null) ? "-" : Const.profile.nameEN;
        nickname.text =
            (Const.profile.nickname == null) ? "-" : Const.profile.nickname;
        dathOfBirth.text = (Const.profile.dathOfBirth == null)
            ? "-"
            : Const.profile.dathOfBirth;
        age.text = (Const.profile.age == null) ? "-" : Const.profile.age;
        religion.text =
            (Const.profile.religion == null) ? "-" : Const.profile.religion;
        phoneNumber.text = (Const.profile.phoneNumber == null)
            ? "-"
            : Const.profile.phoneNumber;
        email.text = (Const.profile.email == null) ? "-" : Const.profile.email;
        address.text =
            (Const.profile.address == null) ? "-" : Const.profile.address;
        houseNumber.text = (Const.profile.houseNumber == null)
            ? "-"
            : Const.profile.houseNumber;
        education.text =
            (Const.profile.education == null) ? "-" : Const.profile.education;
        littleWork.text =
            (Const.profile.littleWork == null) ? "-" : Const.profile.littleWork;
        career.text =
            (Const.profile.career == null) ? "-" : Const.profile.career;
        duty.text = (Const.profile.duty == null) ? "-" : Const.profile.duty;
        workplaceName.text = (Const.profile.workplaceName == null)
            ? "-"
            : Const.profile.workplaceName;
        workplaceAddress.text = (Const.profile.workplaceAddress == null)
            ? "-"
            : Const.profile.workplaceAddress;
      });
    } else {
      setState(() {
        loaddata = false;
      });
    }
  }

  void showdialogsendprofile() async {
    if (gen.text.isEmpty ||
        couseId.text.isEmpty ||
        iDCardNumber.text.isEmpty ||
        nameTH.text.isEmpty ||
        nameEN.text.isEmpty ||
        nickname.text.isEmpty ||
        dathOfBirth.text.isEmpty ||
        age.text.isEmpty ||
        religion.text.isEmpty ||
        email.text.isEmpty ||
        address.text.isEmpty ||
        phoneNumber.text.isEmpty ||
        houseNumber.text.isEmpty ||
        education.text.isEmpty ||
        littleWork.text.isEmpty ||
        career.text.isEmpty ||
        duty.text.isEmpty ||
        workplaceName.text.isEmpty ||
        workplaceAddress.text.isEmpty) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CustomDialogAvatar(
          title: "ผิดพลาด",
          description: 'กรุณาใส่ข้อมูลให้ครบถ้วน',
          buttonText: "ตกลง",
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      );
    } else {
      final result = await Api.addLogUpdateProfile(
          context,
          image,
          int.parse(gen.text),
          int.parse(couseId.text),
          iDCardNumber.text,
          nameTH.text,
          nameEN.text,
          nickname.text,
          dathOfBirth.text,
          age.text,
          religion.text,
          email.text,
          address.text,
          phoneNumber.text,
          houseNumber.text,
          education.text,
          littleWork.text,
          career.text,
          duty.text,
          workplaceName.text,
          workplaceAddress.text);
      if (result == true) {
        final result1 = await await Api.sendProfile(
            context,
            image,
            int.parse(gen.text),
            int.parse(couseId.text),
            iDCardNumber.text,
            nameTH.text,
            nameEN.text,
            nickname.text,
            dathOfBirth.text,
            age.text,
            religion.text,
            email.text,
            address.text,
            phoneNumber.text,
            houseNumber.text,
            education.text,
            littleWork.text,
            career.text,
            duty.text,
            workplaceName.text,
            workplaceAddress.text);
        if (result1 == true) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => CustomDialogAvatar(
              title: "สำเร็จ",
              description: 'บันทึกข้อมูลสำเร็จ',
              buttonText: "ตกลง",
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          );
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => CustomDialogAvatar(
              title: "ผิดพลาด",
              description: 'ไม่สามารถบันทึกข้อมูลได้ กรุณาลงใหม่อีกครั้ง',
              buttonText: "ตกลง",
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          );
        }
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => CustomDialogAvatar(
            title: "ผิดพลาด",
            description: 'ไม่สามารถบันทึกข้อมูลได้ กรุณาลงใหม่อีกครั้ง',
            buttonText: "ตกลง",
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        );
      }
    }
  }

  @override
  void initState() {
    checkdata();
    editing = false;
    chkimage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
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
            'ประวัติของท่านใน',
            style: TextStyle(
              fontFamily: 'K2D',
              color: Colors.white,
              fontSize: size.height * 0.022,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(bottom: size.height * 0.01),
              alignment: Alignment.center,
              child: Text(
                'หลักสูตรจิตวิทยาความมั่นคง',
                style: TextStyle(
                  fontFamily: 'K2D',
                  color: Colors.white,
                  fontSize: size.height * 0.022,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            preferredSize: Size(size.width, size.height * 0.02),
          ),
          actions: [
            editing == false
                ? IconButton(
                    icon: Icon(Icons.edit),
                    iconSize: size.height * 0.03,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        editing = true;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.add_a_photo),
                    color: Colors.white,
                    iconSize: size.height * 0.03,
                    onPressed: () {
                      chooseImage();
                    },
                  ),
          ],
        ),
        body: loaddata == true
            ? Container(
                width: size.width,
                color: ColorTheme.green,
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorTheme.blacklight,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        showImage(),
                        Container(
                          margin: EdgeInsets.only(
                            top: size.height * 0.02,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textdetail('รุ่นที่', gen, editing,
                                  TextInputType.number, 1),
                              textdetail('ประเภทอบรม', couseId, editing,
                                  TextInputType.number, 1),
                              textdetail('เลขบัตรประชาชน', iDCardNumber,
                                  editing, TextInputType.number, 1),
                              textdetail('ชื่อ - นามสกุล [ภาษาไทย]', nameTH,
                                  editing, TextInputType.text, 1),
                              textdetail('ชื่อ - นามสกุล [ภาษาอังกฤษ]', nameEN,
                                  editing, TextInputType.text, 1),
                              textdetail('ชื่อเล่น', nickname, editing,
                                  TextInputType.text, 1),
                              textdetail('วัน/เดือน/ปี เกิด', dathOfBirth,
                                  editing, TextInputType.datetime, 1),
                              textdetail('อายุ', age, editing,
                                  TextInputType.number, 1),
                              textdetail('ศาสนา', religion, editing,
                                  TextInputType.text, 1),
                              textdetail('E-mail', email, editing,
                                  TextInputType.emailAddress, 1),
                              textdetail('ที่อยู่', address, editing,
                                  TextInputType.text, 2),
                              textdetail('เบอร์โทรศัพท์', phoneNumber, editing,
                                  TextInputType.number, 1),
                              textdetail('เบอร์บ้าน', houseNumber, editing,
                                  TextInputType.number, 1),
                              textdetail('การศึกษา', education, editing,
                                  TextInputType.text, 2),
                              textdetail('หน่วยงาน', littleWork, editing,
                                  TextInputType.text, 1),
                              textdetail('อาชีพ', career, editing,
                                  TextInputType.text, 1),
                              textdetail('หน้าที่', duty, editing,
                                  TextInputType.text, 1),
                              textdetail('ชื่อสถานที่ทำงาน', workplaceName,
                                  editing, TextInputType.text, 1),
                              textdetail(
                                  'ที่อยู่สถานที่ทำงาน',
                                  workplaceAddress,
                                  editing,
                                  TextInputType.text,
                                  2),
                              editing == true
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          left: size.width / 20,
                                          right: size.width / 20,
                                          bottom: size.height * 0.02),
                                      width: size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorTheme.green),
                                      child: FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            showdialogsendprofile();
                                            (gen.text.isEmpty ||
                                                    iDCardNumber.text.isEmpty ||
                                                    nameTH.text.isEmpty ||
                                                    nameEN.text.isEmpty ||
                                                    nickname.text.isEmpty ||
                                                    dathOfBirth.text.isEmpty ||
                                                    age.text.isEmpty ||
                                                    religion.text.isEmpty ||
                                                    email.text.isEmpty ||
                                                    address.text.isEmpty ||
                                                    phoneNumber.text.isEmpty ||
                                                    houseNumber.text.isEmpty ||
                                                    education.text.isEmpty ||
                                                    littleWork.text.isEmpty ||
                                                    career.text.isEmpty ||
                                                    duty.text.isEmpty ||
                                                    workplaceName
                                                        .text.isEmpty ||
                                                    workplaceAddress
                                                        .text.isEmpty)
                                                ? editing = true
                                                : editing = false;
                                          });
                                        },
                                        child: Text(
                                          "บันทึกข้อมูล",
                                          style: TextStyle(
                                              fontFamily: 'K2D',
                                              color: Colors.white,
                                              fontSize: size.height * 0.02),
                                        ),
                                      ),
                                    )
                                  : Center(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                color: ColorTheme.green,
                padding: EdgeInsets.only(top: size.height * 0.01),
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
              ),
      ),
    );
  }

  Widget textdetail(String title, TextEditingController textfiledcontroller,
      bool edit, TextInputType keyboardType, int maxLines) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.04,
          right: size.width * 0.04,
          bottom: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title : ',
            style: TextStyle(
                fontFamily: 'K2D',
                fontSize: size.height * 0.018,
                color: Colors.black),
          ),
          Container(
            child: TextField(
              controller: textfiledcontroller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'K2D',
                color: ColorTheme.bluedark,
                fontSize: size.height * 0.015,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontFamily: 'K2D',
                  color: ColorTheme.bluedark,
                  fontSize: size.height * 0.015,
                ),
                counterText: "",
                labelStyle: TextStyle(
                  fontFamily: 'K2D',
                  color: ColorTheme.bluedark,
                  fontSize: size.height * 0.015,
                ),
                suffixIcon: editing == true
                    ? Icon(
                        Icons.edit,
                        color: ColorTheme.green,
                        size: size.height * 0.03,
                      )
                    : null,
                focusColor: ColorTheme.bluedark,
                filled: false,
                enabled: edit,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.bluedark),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.bluedark),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.bluedark),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
