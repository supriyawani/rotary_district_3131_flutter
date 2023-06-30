import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/EditProfileResponse.dart';
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

  Future<EditProfileResponse?> postdata(
      String param1ProjectId,
      String param1amount,
      String param1RotaryVolunteerHours,
      String param1PartnerClubs,
      String param1NonRotaryPartner,
      String param1beneficieries,
      String param1ClubMembersPresent,
      String param1AnnetPresent,
      String param1VisitingRotarians,
      String ReportApproveStatus,
      String Image1,
      String Image2,
      String Image3,
      String Image4,
      bool isUpload) async {
    var bodyfields = {
      'param1ProjectId': param1ProjectId,
      'param1amount': param1amount,
      'param1RotaryVolunteerHours': param1RotaryVolunteerHours,
      'param1PartnerClubs': param1PartnerClubs,
      'param1NonRotaryPartner': param1NonRotaryPartner,
      'param1beneficieries': param1beneficieries,
      'param1ClubMembersPresent': param1ClubMembersPresent,
      'param1AnnetPresent': param1AnnetPresent,
      'param1VisitingRotarians': param1VisitingRotarians,
      'ReportApproveStatus': ReportApproveStatus,
      'Image1': Image1,
      'Image2': Image2,
      'Image3': Image3,
      'Image4': Image4,
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse(Constant.API_URL + 'AddProjectsReport.php'));
    print(Constant.API_URL + 'AddProjectsReport.php');

    request.fields.addAll(bodyfields);

    if (isUpload) {
      final uploadList = <http.MultipartFile>[];
      var imageFileList;
      // for (final imageFiles in imageFileList) {
      if (Image1.length > 0) {
        uploadList.add(
          await http.MultipartFile.fromPath("Image1", Image1),
        );
      }
      if (Image2.length > 0) {
        uploadList.add(
          await http.MultipartFile.fromPath("Image2", Image2),
        );
      }
      if (Image3.length > 0) {
        uploadList.add(
          await http.MultipartFile.fromPath("Image3", Image3),
        );
      }
      if (Image4.length > 0) {
        uploadList.add(
          await http.MultipartFile.fromPath("Image4", Image4),
        );
      }

      request.files.addAll(uploadList);
    }

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    return responseFromJson(res);
  }
}
