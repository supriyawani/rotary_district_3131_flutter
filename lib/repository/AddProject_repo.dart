import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/EditProfileResponse.dart';

class AddProject_repo {
  Future<EditProfileResponse?> postdata(
    //String ApproveStatus,
    String param1title,
    String param1startDate,
    String param1endDate,
    String param1description,
    String param1Tag,
    String President,
    //String param1ProjectId,
    String param1clubNumber,
    String param1approve,
    String param1projectType,
  ) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    var request =
        //  http.Request('GET', Uri.parse(Constant.API_URL + 'iOSEditProfile.php'));
        http.Request(
            'POST', Uri.parse(Constant.API_URL + 'AddProjectsWithImages.php'));
    request.headers.addAll(headers);
    request.bodyFields = {
      //  'ApproveStatus': ApproveStatus,
      'param1title': param1title,
      'param1startDate': param1startDate,
      'param1endDate': param1endDate,
      'param1description': param1description,
      'param1Tag': param1Tag,
      'President': President,
      // 'param1ProjectId': param1ProjectId,
      'param1clubNumber': param1clubNumber,
      'param1approve': param1approve,
      'param1projectType': param1projectType,
    };

    print(Constant.API_URL + 'AddProjectsWithImages.php');
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    return responseFromJson(res);
  }
}
