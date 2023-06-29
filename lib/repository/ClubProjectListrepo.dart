import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/AllClubProjectResult.dart';
import 'package:rotary_district_3131_flutter/model/ClubProjectListResponse.dart';

class ClubProjectList_repo {
  Future<List<ClubProjectlistResponse?>> getMeetinglist(String ClubId,
      String ClubName, String AttendedBy, String MemberId) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubProjectNewApproveNew.php');
    var request = http.Request('POST',
        Uri.parse(Constant.API_URL + 'iOSClubProjectNewApproveNew.php'));
    request.bodyFields = {
      'ClubNumber': ClubId,
      'ClubName': ClubName,
      'AttendedBy': AttendedBy,
      'MemberId': MemberId
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    List<ClubProjectlistResponse?> result;
    if (jsonData != null) {
      // LoginResult userData = LoginResult.fromJson(json.decode(res));
      final List t = json.decode(res);

      final List<ClubProjectlistResponse> userList =
          t.map((item) => ClubProjectlistResponse.fromJson(item)).toList();
      print("Length " + userList.length.toString());

      result = userList;
      //print(result.clubNumber);
    } else {
      result = List.empty();
    }
    return result;
    //return responseFromJson(res);
  }

  Future<List<AllClubProjectResult?>> getAllClubProjectlist(
      String ClubName) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSProjectsDistrict.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSProjectsDistrict.php'));
    request.bodyFields = {
      'clubName': ClubName,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    List<AllClubProjectResult?> result;
    if (jsonData != null) {
      // LoginResult userData = LoginResult.fromJson(json.decode(res));
      final List t = json.decode(res);

      final List<AllClubProjectResult> userList =
          t.map((item) => AllClubProjectResult.fromJson(item)).toList();
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
