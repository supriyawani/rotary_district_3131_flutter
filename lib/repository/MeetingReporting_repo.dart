import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/EditProfileResponse.dart';
import 'package:rotary_district_3131_flutter/model/MeetingReportingceResult.dart';

class MeetingRepoting_repo {
  Future<MeetingReportingResult?> getMeetingReportData(
    String MeetingId,
    /*String ClubMembersPresent,String AnnetPresent,String VisitingRotarians,String Image1*/
  ) async {
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
    if (jsonData.toString().contains("MeetingNo")) {
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

  Future<EditProfileResponse?> postdata(
      String MeetingId,
      String Report,
      String ClubMembersPresent,
      String AnnetPresent,
      String VisitingRotarians,
      String Image1,
      String Image2,
      String Image3,
      String Image4,
      String ReportApproveStatus,
      bool isUpload) async {
    var bodyfields = {
      'MeetingId': MeetingId,
      'Report': Report,
      'ClubMembersPresent': ClubMembersPresent,
      'AnnetPresent': AnnetPresent,
      'VisitingRotarians': VisitingRotarians,
      'Image1': Image1,
      'Image2': Image2,
      'Image3': Image3,
      'Image4': Image4,
      'ReportApproveStatus': ReportApproveStatus,
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse(Constant.API_URL + 'iOSAddMeetingReport.php'));
    print(Constant.API_URL + 'iOSAddMeetingReport.php');

    request.fields.addAll(bodyfields);
    /*var files = {
      */ /*"Image1": Image1,
      "Image2": Image2,
      "Image3": Image3,
      "Image4": Image4,*/ /*
      */ /*  await http.MultipartFile.fromPath("Image1", Image1),
      await http.MultipartFile.fromPath("Image1", Image1),
      await http.MultipartFile.fromPath("Image1", Image1),
      await http.MultipartFile.fromPath("Image1", Image1),*/ /*
    };*/
    // var multipartFile = new http.MultipartFile('Image1':Image1,"Image2":Image2);

    /*if (isUpload) {
      request.files.add(await http.MultipartFile.fromPath("Image1", Image1));
        request.files.add(await http.MultipartFile.fromPath("Image2", Image2));
      request.files.add(await http.MultipartFile.fromPath("Image3", Image3));
      request.files.add(await http.MultipartFile.fromPath("Image4", Image4));
    }*/
    if (isUpload) {
      final uploadList = <http.MultipartFile>[];
      var imageFileList;
      // for (final imageFiles in imageFileList) {
      uploadList.add(
        await http.MultipartFile.fromPath("Image1", Image1),
      );
      uploadList.add(
        await http.MultipartFile.fromPath("Image2", Image2),
      );
      uploadList.add(
        await http.MultipartFile.fromPath("Image3", Image3),
      );
      uploadList.add(
        await http.MultipartFile.fromPath("Image4", Image4),
      );

      request.files.addAll(uploadList);
    }

    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    return responseFromJson(res);
    /* var res = await response.stream.bytesToString();
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
    return result;*/
  }
}
