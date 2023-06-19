import 'dart:convert';

ClubBulletinResult responseFromJson(String str) =>
    ClubBulletinResult.fromJson(json.decode(str));

String responseToJson(ClubBulletinResult data) => json.encode(data.toJson());

class ClubBulletinResult {
  String? id;
  String? category;
  String? title;
  String? thumbnail;
  String? description;
  String? date;
  String? bulletinType;
  String? document;
  String? videoCode;
  String? clubNumber;
  String? regDate;
  String? mP3File;
  String? approveStatus;

  ClubBulletinResult(
      {this.id,
      this.category,
      this.title,
      this.thumbnail,
      this.description,
      this.date,
      this.bulletinType,
      this.document,
      this.videoCode,
      this.clubNumber,
      this.regDate,
      this.mP3File,
      this.approveStatus});

  ClubBulletinResult.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category = json['Category'];
    title = json['Title'];
    thumbnail = json['Thumbnail'];
    description = json['Description'];
    date = json['Date'];
    bulletinType = json['BulletinType'];
    document = json['Document'];
    videoCode = json['VideoCode'];
    clubNumber = json['ClubNumber'];
    regDate = json['RegDate'];
    mP3File = json['MP3File'];
    approveStatus = json['ApproveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Category'] = this.category;
    data['Title'] = this.title;
    data['Thumbnail'] = this.thumbnail;
    data['Description'] = this.description;
    data['Date'] = this.date;
    data['BulletinType'] = this.bulletinType;
    data['Document'] = this.document;
    data['VideoCode'] = this.videoCode;
    data['ClubNumber'] = this.clubNumber;
    data['RegDate'] = this.regDate;
    data['MP3File'] = this.mP3File;
    data['ApproveStatus'] = this.approveStatus;
    return data;
  }
}
