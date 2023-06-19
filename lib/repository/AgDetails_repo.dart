import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';

class AGDetails_repo {
  Future<String?> getLocation(String clubNumber) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSAgDetails.php');
    var request = http.MultipartRequest(
        'POST', Uri.parse(Constant.API_URL + 'iOSAgDetails.php'));
    var bodyfields = {
      'ClubNo': "86090",
    };
    request.fields.addAll(bodyfields);

    //print(Constant.API_URL + 'iOSClubNextMeetingId.php');
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    var data = "";
    print(json.decode(res));
    if (jsonData != null) {
      data = jsonData['Location'];
      print("data:" + data);
    }
    return data;
  }
}
