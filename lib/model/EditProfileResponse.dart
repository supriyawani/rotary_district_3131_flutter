import 'dart:convert';

EditProfileResponse responseFromJson(String str) =>
    EditProfileResponse.fromJson(json.decode(str));

String responseToJson(EditProfileResponse data) => json.encode(data.toJson());

class EditProfileResponse {
  String? response;
  String? msg;

  EditProfileResponse({this.response, this.msg});

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
    response = json['Response'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Response'] = this.response;
    data['msg'] = this.msg;
    return data;
  }
}
