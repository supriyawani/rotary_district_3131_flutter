import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/EditProfileResponse.dart';

class AddComment_repo {
  Future<EditProfileResponse?> addComment(
      String MemberId,
      String ClubName,
      String MComments,
      String MeetingId,
      String AttendedBy,
      String ClubId) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    var request = http.Request('POST',
        Uri.parse(Constant.API_URL + 'iOSClubMeetingAddCommentNew.php'));
    request.headers.addAll(headers);
    request.bodyFields = {
      'MemberId': MemberId,
      'ClubName': ClubName,
      'MComments': MComments,
      'MeetingId': MeetingId,
      'AttendedBy': AttendedBy,
      'ClubId': ClubId,
    };

    print(Constant.API_URL + 'iOSClubMeetingAddCommentNew.php');
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    return responseFromJson(res);
  }
}
