import 'dart:convert';

TagList responseFromJson(String str) => TagList.fromJson(json.decode(str));

String responseToJson(TagList data) => json.encode(data.toJson());

class TagList {
  String? tagName;

  TagList({this.tagName});

  TagList.fromJson(Map<String, dynamic> json) {
    tagName = json['TagName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TagName'] = this.tagName;
    return data;
  }
}
