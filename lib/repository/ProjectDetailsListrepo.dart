import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/MeetingAttendanceResult.dart';

class ProjectDEtailsList_repo {
  Future<List<MeetingAttendanceResult?>> getAttendingList(
    String ProjectId,
    /* String AttendedBy,
    String ClubId,*/
  ) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubProjectAttendingNew.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSClubProjectAttendingNew.php'));
    request.bodyFields = {
      'ProjectId': ProjectId,
      /*'AttendedBy': AttendedBy,
      'ClubId': ClubId*/
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

  Future<List<MeetingAttendanceResult?>> getCommentList(
    String ProjectId,
    /* String AttendedBy,
    String ClubId,*/
  ) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubProjectCommentsNew.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSClubProjectCommentsNew.php'));
    request.bodyFields = {
      'ProjectId': ProjectId,
      /*'AttendedBy': AttendedBy,
      'ClubId': ClubId*/
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

  Future<List<MeetingAttendanceResult?>> getLikesList(
    String ProjectId,
    /* String AttendedBy,
    String ClubId,*/
  ) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubProjectLikeNew.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSClubProjectLikeNew.php'));
    request.bodyFields = {
      'ProjectId': ProjectId,
      /*'AttendedBy': AttendedBy,
      'ClubId': ClubId*/
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    List<MeetingAttendanceResult?> result;

    if (jsonData.toString().contains("FirstName")) {
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
