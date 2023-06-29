import 'dart:convert';

MeetingattQRreponse responseFromJson(String str) =>
    MeetingattQRreponse.fromJson(json.decode(str));

String responseToJson(MeetingattQRreponse data) => json.encode(data.toJson());

class MeetingattQRreponse {
  String? clubNumber;
  String? clubName;
  String? qrType;

  MeetingattQRreponse({this.clubNumber, this.clubName, this.qrType});

  MeetingattQRreponse.fromJson(Map<String, dynamic> json) {
    clubNumber = json['ClubNumber'];
    clubName = json['ClubName'];
    qrType = json['QrType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClubNumber'] = this.clubNumber;
    data['ClubName'] = this.clubName;
    data['QrType'] = this.qrType;
    return data;
  }
}
