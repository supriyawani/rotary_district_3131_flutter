import 'dart:convert';

Jan responseFromJson(String str) => Jan.fromJson(json.decode(str));

String responseToJson(Jan data) => json.encode(data.toJson());

class ClubCelebrationResponse {
  late final String month;
  //late final int month;
  late final List<Jan> jan;

  ClubCelebrationResponse({
    required this.month,
    required this.jan,
  });

  ClubCelebrationResponse.fromJson(Map<String, dynamic> json) {
    if (json['Jan'] != null) {
      jan = [];
      json['Jan'].forEach((v) {
        jan.add(new Jan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jan != null) {
      data['Jan'] = this.jan.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jan {
  String firstName = "";
  String lastName = "";
  String email = "";
  String mobile = "";
  String userPhoto = "";
  String birthDate = "";
  String charterDate = "";
  String type = "";
  String WeddingDate = "";

  Jan(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobile,
      required this.userPhoto,
      required this.birthDate,
      required this.charterDate,
      required this.type,
      required this.WeddingDate});

  Jan.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    mobile = json['Mobile'];
    //WeddingDate = json['WeddingDate'];
    /*if (json['Mobile'] == null) {
    } else {}*/
    if (json['User_Photo'] == null) {
      userPhoto = "";
    } else {
      userPhoto = json['User_Photo'];
    }
    charterDate = json['CharterDate'];
    if (json['BirthDate'] == null) {
      birthDate = "";
    } else {
      birthDate = json['BirthDate'];
    }
    if (json['type'] == null) {
      type = "";
    } else {
      type = json['type'];
    }
    //type = json['type'];
    if (json['WeddingDate'] == null) {
      WeddingDate = "";
    } else {
      WeddingDate = json['WeddingDate'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Email'] = this.email;
    data['Mobile'] = this.mobile;
    data['User_Photo'] = this.userPhoto;
    data['BirthDate'] = this.birthDate;
    data['CharterDate'] = this.charterDate;
    data['type'] = this.type;
    data['WeddingDate'] = this.WeddingDate;
    return data;
  }
}
