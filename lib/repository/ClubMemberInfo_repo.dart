import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/ClubMemberInfoResult.dart';

class ClubMemberInfo_repo {
  Future<ClubMemberInfoResult?> getPresident(String ClubName) async {
    var headers = {'Content-Type': 'application/json', 'Charset': 'utf-8'};
    print(Constant.API_URL + 'iOSClubMemberInfoPreNew.php');
    var request = http.Request(
      'GET',
      Uri.parse(Constant.API_URL + 'iOSClubMemberInfoPreNew.php'),
    );
    /*request.bodyFields = {
      'clubName': ClubName,
    };*/
    // var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    // print(Constant.API_URL + 'iOSClubMeetingNewApprove.php');
    // var request = http.Request('POST', Uri.parse(Constant.API_URL + 'iOSClubMeetingNewApprove.php'));
    request.bodyFields = {
      'clubName': "Akurdi Pune",
    };
    //request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    //var jsonData = jsonDecode(request.body);
    print(json.decode(res));
    ClubMemberInfoResult? result;
    if (jsonData.toString().contains("PositionName")) {
      final List t = json.decode(res);
      final List<ClubMemberInfoResult> userList =
          t.map((item) => ClubMemberInfoResult.fromJson(item)).toList();
      result = userList.first;
      print("infopre:" + result.firstName.toString());
    } else {
      result = null;
    }
    return result;
  }
}
