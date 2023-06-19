import 'dart:convert';

LoginResponse responseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String responseToJson(LoginResponse data) => json.encode(data.toJson());

List<LoginResponse> responseFromJson1(String str) => List<LoginResponse>.from(
    json.decode(str).map((x) => LoginResponse.fromJson(x)));

String responseToJson1(List<LoginResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginResponse {
  String? firstName;
  String? middleName;
  String? lastName;
  String? birthDate;
  String? weddingDate;
  String? bloodGroup;
  String? female;
  String? email;
  String? clubNumber;
  String? clubName;
  String? memberId;
  String? userId;
  String? rotaryId;
  String? mobile;
  String? accessLevel;

  LoginResponse(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.birthDate,
      this.weddingDate,
      this.bloodGroup,
      this.female,
      this.email,
      this.clubNumber,
      this.clubName,
      this.memberId,
      this.userId,
      this.rotaryId,
      this.mobile,
      this.accessLevel});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    birthDate = json['BirthDate'];
    weddingDate = json['WeddingDate'];
    bloodGroup = json['BloodGroup'];
    female = json['Female'];
    email = json['Email'];
    clubNumber = json['ClubNumber'];
    clubName = json['ClubName'];
    memberId = json['MemberId'];
    userId = json['UserId'];
    rotaryId = json['RotaryId'];
    mobile = json['Mobile'];
    accessLevel = json['AccessLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['BirthDate'] = this.birthDate;
    data['WeddingDate'] = this.weddingDate;
    data['BloodGroup'] = this.bloodGroup;
    data['Female'] = this.female;
    data['Email'] = this.email;
    data['ClubNumber'] = this.clubNumber;
    data['ClubName'] = this.clubName;
    data['MemberId'] = this.memberId;
    data['UserId'] = this.userId;
    data['RotaryId'] = this.rotaryId;
    data['Mobile'] = this.mobile;
    data['AccessLevel'] = this.accessLevel;
    return data;
  }
}
