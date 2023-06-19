import 'dart:convert';

MeetingListResponse responseFromJson(String str) =>
    MeetingListResponse.fromJson(json.decode(str));

String responseToJson(MeetingListResponse data) => json.encode(data.toJson());

class MeetingListResponse {
  String? meetingDate;
  String? location;
  String? topic;
  String? jointMeeting;
  String? jointMeetingWith;
  String? chiefGuest;
  String? preMeetingNotes;
  String? clubNumber;
  String? id;
  String? meetingId;
  String? meetingTime;
  String? approveStatus;
  String? meetingNo;
  String? clubAssembly;
  String? meetingType;
  String? report;
  String? zoomMeetingNumber;
  String? zoomMeetingPassword;
  String? reportApproveStatus;
  String? spouseAllowed;
  String? totalAttending;
  String? totalLike;
  String? memberLike;
  String? totalComment;
  String? memberComment;
  String? memberAttending;
  String? tag;

  MeetingListResponse(
      {this.meetingDate,
      this.location,
      this.topic,
      this.jointMeeting,
      this.jointMeetingWith,
      this.chiefGuest,
      this.preMeetingNotes,
      this.clubNumber,
      this.id,
      this.meetingId,
      this.meetingTime,
      this.approveStatus,
      this.meetingNo,
      this.clubAssembly,
      this.meetingType,
      this.report,
      this.zoomMeetingNumber,
      this.zoomMeetingPassword,
      this.reportApproveStatus,
      this.spouseAllowed,
      this.totalAttending,
      this.totalLike,
      this.memberLike,
      this.totalComment,
      this.memberComment,
      this.memberAttending,
      this.tag});

  MeetingListResponse.fromJson(Map<String, dynamic> json) {
    meetingDate = json['MeetingDate'];
    location = json['Location'];
    topic = json['Topic'];
    jointMeeting = json['JointMeeting'];
    jointMeetingWith = json['JointMeetingWith'];
    chiefGuest = json['ChiefGuest'];
    preMeetingNotes = json['PreMeetingNotes'];
    clubNumber = json['ClubNumber'];
    id = json['Id'];
    meetingId = json['MeetingId'];
    meetingTime = json['MeetingTime'];
    approveStatus = json['ApproveStatus'];
    meetingNo = json['MeetingNo'];
    clubAssembly = json['ClubAssembly'];
    meetingType = json['MeetingType'];
    report = json['Report'];
    zoomMeetingNumber = json['zoomMeetingNumber'];
    zoomMeetingPassword = json['zoomMeetingPassword'];
    reportApproveStatus = json['ReportApproveStatus'];
    spouseAllowed = json['SpouseAllowed'];
    totalAttending = json['TotalAttending'];
    totalLike = json['TotalLike'];
    memberLike = json['MemberLike'];
    totalComment = json['TotalComment'];
    memberComment = json['MemberComment'];
    memberAttending = json['MemberAttending'];
    tag = json['Tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MeetingDate'] = this.meetingDate;
    data['Location'] = this.location;
    data['Topic'] = this.topic;
    data['JointMeeting'] = this.jointMeeting;
    data['JointMeetingWith'] = this.jointMeetingWith;
    data['ChiefGuest'] = this.chiefGuest;
    data['PreMeetingNotes'] = this.preMeetingNotes;
    data['ClubNumber'] = this.clubNumber;
    data['Id'] = this.id;
    data['MeetingId'] = this.meetingId;
    data['MeetingTime'] = this.meetingTime;
    data['ApproveStatus'] = this.approveStatus;
    data['MeetingNo'] = this.meetingNo;
    data['ClubAssembly'] = this.clubAssembly;
    data['MeetingType'] = this.meetingType;
    data['Report'] = this.report;
    data['zoomMeetingNumber'] = this.zoomMeetingNumber;
    data['zoomMeetingPassword'] = this.zoomMeetingPassword;
    data['ReportApproveStatus'] = this.reportApproveStatus;
    data['SpouseAllowed'] = this.spouseAllowed;
    data['TotalAttending'] = this.totalAttending;
    data['TotalLike'] = this.totalLike;
    data['MemberLike'] = this.memberLike;
    data['TotalComment'] = this.totalComment;
    data['MemberComment'] = this.memberComment;
    data['MemberAttending'] = this.memberAttending;
    data['Tag'] = this.tag;
    return data;
  }
}
