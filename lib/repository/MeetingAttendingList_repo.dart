import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/MeetingAttendanceResult.dart';

class MeetingAttendingList_repo {
  Future<List<MeetingAttendanceResult?>> getAttendingList(
    String MeetingId,
    String AttendedBy,
    String ClubId,
  ) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubMeetingAttendingNew.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSClubMeetingAttendingNew.php'));
    request.bodyFields = {
      'MeetingId': MeetingId,
      'AttendedBy': AttendedBy,
      'ClubId': ClubId
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    List<MeetingAttendanceResult?> result;

    if (jsonData.toString().contains("AttendedBy")) {
      // LoginResult userData = LoginResult.fromJson(json.decode(res));
      final List t = json.decode(res);

      final List<MeetingAttendanceResult> userList =
          t.map((item) => MeetingAttendanceResult.fromJson(item)).toList();
      print("Length " + userList.length.toString());

      result = userList;
      //print(result.clubNumber);
    } else {
      result = List.empty();
    }

    return result;
    //return responseFromJson(res);
  }
}
