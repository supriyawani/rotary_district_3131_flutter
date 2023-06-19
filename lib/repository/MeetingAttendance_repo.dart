import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/EditProfileResponse.dart';

class MeetingAttendance_repo {
  Future<EditProfileResponse?> postdata(
    String MemberId,
    String ClubName,
    String MAttending,
    String MeetingId,
    String AttendedBy,
    String ClubId,
  ) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    var request =
        //  http.Request('GET', Uri.parse(Constant.API_URL + 'iOSEditProfile.php'));
        http.Request(
            'POST', Uri.parse(Constant.API_URL + 'iOSClubMeetingAddRes.php'));
    request.headers.addAll(headers);
    request.bodyFields = {
      //  'ApproveStatus': ApproveStatus,
      'MemberId': MemberId,
      'ClubName': ClubName,
      'MAttending': MAttending,
      'MeetingId': MeetingId,
      'AttendedBy': AttendedBy,
      'ClubId': ClubId,
    };

    print(Constant.API_URL + 'iOSClubMeetingAddRes.php');
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    return responseFromJson(res);
  }
}
