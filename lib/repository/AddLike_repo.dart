import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/EditProfileResponse.dart';

class AddLike_repo {
  Future<EditProfileResponse?> addlike(
    String MemberId,
    String ClubName,
    String MLike,
    String MeetingId,
    String AttendedBy,
    String ClubId,
  ) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    var request =
        //  http.Request('GET', Uri.parse(Constant.API_URL + 'iOSEditProfile.php'));
        http.Request('POST',
            Uri.parse(Constant.API_URL + 'iOSClubMeetingAddLikeNew.php'));
    request.headers.addAll(headers);
    request.bodyFields = {
      //  'ApproveStatus': ApproveStatus,
      'MemberId': MemberId,
      'ClubName': ClubName,
      'MLike': MLike,
      'MeetingId': MeetingId,
      'AttendedBy': AttendedBy,
      'ClubId': ClubId,
    };

    print(Constant.API_URL + 'iOSClubMeetingAddLikeNew.php');
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    return responseFromJson(res);
  }
}
