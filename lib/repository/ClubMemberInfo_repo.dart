import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/ClubMemberInfoResult.dart';

class ClubMemberInfo_repo {
  Future<List<ClubMemberInfoResult?>> getPresident(String ClubName) async {
    var headers = {'Content-Type': 'application/json', 'Charset': 'utf-8'};
    print(Constant.API_URL + 'iOSClubMemberInfoPre.php');
    var request = http.Request(
      'POST',
      Uri.parse(Constant.API_URL + 'iOSClubMemberInfoPre.php'),
    );
    /*request.bodyFields = {
      'clubName': ClubName,
    };*/
    // var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    // print(Constant.API_URL + 'iOSClubMeetingNewApprove.php');
    // var request = http.Request('POST', Uri.parse(Constant.API_URL + 'iOSClubMeetingNewApprove.php'));
    request.bodyFields = {
      'clubName': ClubName,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    //var jsonData = jsonDecode(request.body);
    print(json.decode(res));
    List<ClubMemberInfoResult?> result;
    if (jsonData != null) {
      // LoginResult userData = LoginResult.fromJson(json.decode(res));
      /* final List t = json.decode(res);

      final List<ClubMemberInfoResult> userList =
          t.map((item) => ClubMemberInfoResult.fromJson(item)).toList();*/
      // List<ClubMemberInfoResult> t = [];
      final List t = json.decode(res);

      final List<ClubMemberInfoResult> userList = t
          .map((item) =>
              ClubMemberInfoResult.fromJson(item as Map<String, dynamic>))
          .toList();
      result = userList;
      //  result = userList[0] as List<ClubMemberInfoResult?>;
      //print(result.clubNumber);
    } else {
      result = List.empty();
    }
    return result;
  }
}
