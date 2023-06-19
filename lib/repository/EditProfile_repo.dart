import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/ProfileResponse.dart';

class EditProfile_repo {
  Future<ProfileResponse?> getProfiledata(
      String userId, String AccessLevel) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSUserProfile.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSUserProfile.php'));
    request.bodyFields = {
      'userId': userId,
      'AccessLevel': AccessLevel,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    ProfileResponse? result;
    if (jsonData.toString().contains("FirstName")) {
      // LoginResult userData = LoginResult.fromJson(json.decode(res));
      final List t = json.decode(res);
      final List<ProfileResponse> userList =
          t.map((item) => ProfileResponse.fromJson(item)).toList();
      result = userList.first;
      print(result.firstName);
    } else {
      result = null;
    }
    return result;
    //return responseFromJson(res);
  }
}
