import 'dart:convert';

ClubMemberInfoResult responseFromJson(String str) =>
    ClubMemberInfoResult.fromJson(json.decode(str));

String responseToJson(ClubMemberInfoResult data) => json.encode(data.toJson());

class ClubMemberInfoResult {
  String? clubNumber;
  String? clubName;
  String? memberId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? bloodGroup;
  String? userPhoto;
  String? address;
  String? birthDate;
  String? weddingDate;
  String? classification;
  String? sName;
  String? sBirthDate;
  String? positionName;

  ClubMemberInfoResult(
      {this.clubNumber,
      this.clubName,
      this.memberId,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.bloodGroup,
      this.userPhoto,
      this.address,
      this.birthDate,
      this.weddingDate,
      this.classification,
      this.sName,
      this.sBirthDate,
      this.positionName});

  ClubMemberInfoResult.fromJson(Map<String, dynamic> json) {
    clubNumber = json['ClubNumber'];
    clubName = json['ClubName'];
    memberId = json['MemberId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    email = json['Email'];
    mobile = json['Mobile'];
    bloodGroup = json['BloodGroup'];
    userPhoto = json['User_Photo'];
    address = json['Address'];
    birthDate = json['BirthDate'];
    weddingDate = json['WeddingDate'];
    classification = json['Classification'];
    sName = json['S_Name'];
    sBirthDate = json['S_BirthDate'];
    positionName = json['PositionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClubNumber'] = this.clubNumber;
    data['ClubName'] = this.clubName;
    data['MemberId'] = this.memberId;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Email'] = this.email;
    data['Mobile'] = this.mobile;
    data['BloodGroup'] = this.bloodGroup;
    data['User_Photo'] = this.userPhoto;
    data['Address'] = this.address;
    data['BirthDate'] = this.birthDate;
    data['WeddingDate'] = this.weddingDate;
    data['Classification'] = this.classification;
    data['S_Name'] = this.sName;
    data['S_BirthDate'] = this.sBirthDate;
    data['PositionName'] = this.positionName;
    return data;
  }
}
