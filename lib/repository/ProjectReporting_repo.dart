import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/ProjectResportResult.dart';

class ProjectRepoting_repo {
  Future<ProjectReportResult?> getProjectReportData(
    String ProjectId,
    /*String ClubMembersPresent,String AnnetPresent,String VisitingRotarians,String Image1*/
  ) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubProjectReport.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSClubProjectReport.php'));
    request.bodyFields = {
      'ProjectId': ProjectId,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    ProjectReportResult? result;
    if (jsonData != null) {
      final List t = json.decode(res);
      final List<ProjectReportResult> userList =
          t.map((item) => ProjectReportResult.fromJson(item)).toList();
      result = userList.first;
      print(result.title.toString());
    } else {
      result = null;
    }
    return result;
    //return responseFromJson(res);
  }
}
