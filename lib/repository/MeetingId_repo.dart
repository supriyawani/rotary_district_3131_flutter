import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';

class MeetingId_repo {
  Future<String?> getMeetingId(String clubNumber) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubNextMeetingId.php');
    /* var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSClubNextMeetingId.php'));*/
    /*request.bodyFields = {
      'clubNumber': clubNumber,
    };*/
    var request = http.MultipartRequest(
        'POST', Uri.parse(Constant.API_URL + 'iOSClubNextMeetingId.php'));
    var bodyfields = {
      'clubNumber': "86090",
    };
    request.fields.addAll(bodyfields);

    //print(Constant.API_URL + 'iOSClubNextMeetingId.php');
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    var data = "";
    print(json.decode(res));
    if (jsonData != null) {
      data = jsonData['NextMeetingId'];
      print("data:" + data);
    }
    return data;
  }
}
