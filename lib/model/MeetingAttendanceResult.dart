import 'dart:convert';

MeetingAttendanceResult responseFromJson(String str) =>
    MeetingAttendanceResult.fromJson(json.decode(str));

String responseToJson(MeetingAttendanceResult data) =>
    json.encode(data.toJson());

class MeetingAttendanceResult {
  String? firstName;
  String? lastName;
  String? userPhoto;
  String? mComments;
  String? attendedBy;

  MeetingAttendanceResult(
      {this.firstName,
      this.lastName,
      this.userPhoto,
      this.mComments,
      this.attendedBy});

  MeetingAttendanceResult.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userPhoto = json['User_Photo'];
    mComments = json['MComments'];
    attendedBy = json['AttendedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['User_Photo'] = this.userPhoto;
    data['MComments'] = this.mComments;
    data['AttendedBy'] = this.attendedBy;
    return data;
  }
}
