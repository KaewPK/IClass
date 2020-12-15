class Profile {
  int userId;
  String image;
  int gen;
  int couseId;
  String iDCardNumber;
  String workplaceName;
  String duty;
  String career;
  String littleWork;
  String education;
  String houseNumber;
  String phoneNumber;
  String address;
  String email;
  String religion;
  String age;
  String dathOfBirth;
  String nickname;
  String nameEN;
  String nameTH;
  String workplaceAddress;

  Profile(
      {this.userId,
      this.image,
      this.gen,
      this.iDCardNumber,
      this.workplaceName,
      this.duty,
      this.career,
      this.littleWork,
      this.education,
      this.houseNumber,
      this.phoneNumber,
      this.address,
      this.email,
      this.religion,
      this.age,
      this.dathOfBirth,
      this.nickname,
      this.nameEN,
      this.nameTH,
      this.workplaceAddress});

  Profile.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    image = json['Image'];
    gen = json['Gen'];
    couseId = json['CouseId'];
    iDCardNumber = json['iDCardNumber'];
    workplaceName = json['workplaceName'];
    duty = json['duty'];
    career = json['career'];
    littleWork = json['littleWork'];
    education = json['education'];
    houseNumber = json['houseNumber'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    email = json['email'];
    religion = json['religion'];
    age = json['age'];
    dathOfBirth = json['dathOfBirth'];
    nickname = json['nickname'];
    nameEN = json['nameEN'];
    nameTH = json['nameTH'];
    workplaceAddress = json['workplaceAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['Image'] = this.image;
    data['Gen'] = this.gen;
    data['CouseId'] = this.couseId;
    data['iDCardNumber'] = this.iDCardNumber;
    data['workplaceName'] = this.workplaceName;
    data['duty'] = this.duty;
    data['career'] = this.career;
    data['littleWork'] = this.littleWork;
    data['education'] = this.education;
    data['houseNumber'] = this.houseNumber;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['email'] = this.email;
    data['religion'] = this.religion;
    data['age'] = this.age;
    data['dathOfBirth'] = this.dathOfBirth;
    data['nickname'] = this.nickname;
    data['nameEN'] = this.nameEN;
    data['nameTH'] = this.nameTH;
    data['workplaceAddress'] = this.workplaceAddress;
    return data;
  }
}
