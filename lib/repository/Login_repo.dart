import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/model/LoginResult.dart';

import '../common/Constant.dart';

class Login_repo {
  Future<LoginResult?> getLogin(
      String email, String password, String LoginAs) async {
    /*var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('GET', Uri.parse(Constant.API_URL+'/waiter/login'));
    request.bodyFields = {
      'email': email,
      'password': password
    };
    request.headers.addAll(headers);*/
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSLogin.php');
    var request =
        http.Request('POST', Uri.parse(Constant.API_URL + 'iOSLogin.php'));
    //request.bodyFields = {'email': email, 'password': password};
    request.bodyFields = {
      'email': email,
      'password': password,
      'LoginAs': LoginAs
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    LoginResult? result;
    if (jsonData.toString().contains("UserId")) {
      // LoginResult userData = LoginResult.fromJson(json.decode(res));
      final List t = json.decode(res);
      final List<LoginResult> userList =
          t.map((item) => LoginResult.fromJson(item)).toList();
      result = userList.first;
      print(result.firstName);
    } else {
      result = null;
    }
    return result;
  }
}
