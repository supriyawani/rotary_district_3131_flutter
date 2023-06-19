import 'dart:convert';

MeetingIdResponse responseFromJson(String str) =>
    MeetingIdResponse.fromJson(json.decode(str));

String responseToJson(MeetingIdResponse data) => json.encode(data.toJson());

class MeetingIdResponse {
  String? response;
  String? nextMeetingId;

  MeetingIdResponse({required this.response, required this.nextMeetingId});

  MeetingIdResponse.fromJson(Map<String, dynamic> json) {
    response = json['Response'];
    nextMeetingId = json['NextMeetingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Response'] = this.response;
    data['NextMeetingId'] = this.nextMeetingId;
    return data;
  }
}
