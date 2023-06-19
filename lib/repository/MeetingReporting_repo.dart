import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/MeetingReportingceResult.dart';

class MeetingRepoting_repo {
  Future<MeetingReportingResult?> getMeetingReportData(String MeetingId) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubMeetingReport.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSClubMeetingReport.php'));
    request.bodyFields = {
      'MeetingId': MeetingId,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    MeetingReportingResult? result;
    if (jsonData != null) {
      final List t = json.decode(res);
      final List<MeetingReportingResult> userList =
          t.map((item) => MeetingReportingResult.fromJson(item)).toList();
      result = userList.first;
      print(result.meetingDate);
    } else {
      result = null;
    }
    return result;
    //return responseFromJson(res);
  }
}
