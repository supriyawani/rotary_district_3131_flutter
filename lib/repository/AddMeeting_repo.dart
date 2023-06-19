import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/EditProfileResponse.dart';

class AddMeeting_repo {
  Future<EditProfileResponse?> postdata(
      //String ApproveStatus,
      String MeetingNo,
      String MeetingDate,
      String MeetingType,
      String ChiefGuest,
      String MeetingTime,
      String Tag,
      String Topic,
      String PreMeetingNotes,
      String ClubNumber,
      String Location,
      String ApproveStatus) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
/*
ApproveStatus=ApproveStatus,
      MeetingNo=MeetingNo, MeetingDate=MeetingDate,
      MeetingType=MeetingType, ChiefGuest=ChiefGuest,
      MeetingTime=MeetingTime, Tag=Tag,
      Topic=Topic, PreMeetingNotes=PreMeetingNotes,
      ClubNumber=ClubNumber,
      Location=Location
* */
    /* var bodyFields={
      ApproveStatus=ApproveStatus,
      MeetingNo=MeetingNo, MeetingDate=MeetingDate,
      MeetingType=MeetingType, ChiefGuest=ChiefGuest,
      MeetingTime=MeetingTime, Tag=Tag,
      Topic=Topic, PreMeetingNotes=PreMeetingNotes,
      ClubNumber=ClubNumber,
      Location=Location
    };*/

    var request =
        //  http.Request('GET', Uri.parse(Constant.API_URL + 'iOSEditProfile.php'));
        http.Request('POST', Uri.parse(Constant.API_URL + 'iOSAddMeeting.php'));
    request.headers.addAll(headers);
    request.bodyFields = {
      //  'ApproveStatus': ApproveStatus,
      'MeetingNo': MeetingNo,
      'MeetingDate': MeetingDate,
      'MeetingType': MeetingType,
      'ChiefGuest': ChiefGuest,
      'MeetingTime': MeetingTime,
      'Tag': Tag,
      'Topic': Topic,
      'PreMeetingNotes': PreMeetingNotes,
      'ClubNumber': ClubNumber,
      'Location': Location,
    };

    print(Constant.API_URL + 'iOSAddMeeting.php');
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    return responseFromJson(res);
  }
}
