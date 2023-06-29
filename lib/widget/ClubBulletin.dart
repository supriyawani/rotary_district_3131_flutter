import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/ClubBulletinResult.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubBulletin extends StatefulWidget {
  String ClubNumber;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  ClubBulletin({
    required this.ClubNumber,
  });
  @override
  _ClubBulletinState createState() => _ClubBulletinState(ClubNumber);
}

class _ClubBulletinState extends State<ClubBulletin> {
  String ClubNumber = "";
  var isLoading = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  _ClubBulletinState(String ClubNumber) {
    this.ClubNumber = ClubNumber;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prefs.then((SharedPreferences prefs) async {
      ClubNumber = prefs.getString('ClubNumber')!;
    });
    print("clubNumber: " + ClubNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
            leading: BackButton(
              color: Constant.color_theme,
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            title: Text("Club Bulletin",
                style: TextStyle(
                    color: Constant.color_theme, fontWeight: FontWeight.bold))),
        body: FutureBuilder<dynamic>(
            future: ClubBulletin_repo().getClubBulletinData(ClubNumber),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                showDialog(
                  builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text(snapshot.error.toString()),
                  ),
                  context: context,
                );
              } else if (snapshot!.hasData) {
                //print(snapshot.data);
                return ListView.builder(
                    itemCount: snapshot.data.length!,
                    itemBuilder: (context, index) => ListTile(
                        title: Card(
                            elevation: 3.sp,
                            child: Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: InkWell(
                                  child: Container(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        //Center Row contents vertically,

                                        children: <Widget>[
                                          /* Container(
                                          child: Text(
                                            snapshot.data[index].id,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),*/
                                          Container(
                                            margin: EdgeInsets.all(8.sp),
                                            child: SvgPicture.asset(
                                              "assets/images/Icon metro-file-pdf.svg",
                                              fit: BoxFit.fill,
                                              height: 4.h,
                                            ),
                                            alignment: Alignment.topLeft,
                                          ),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              //Center Row contents horizontally,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              //Center Row contents vertically,

                                              children: <Widget>[
                                                SizedBox(
                                                  width: 60.w,
                                                  child: Container(
                                                    // margin: EdgeInsets.all(5),
                                                    child: Text(
                                                      snapshot
                                                          .data[index].title,
                                                      //overflow: TextOverflow.clip,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    //alignment: Alignment.center,
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                      snapshot.data[index].date,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  // alignment: Alignment.center,
                                                ),
                                              ]),
                                          //new Spacer(),
                                          GestureDetector(
                                            child: Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.all(3.sp),
                                                child: SvgPicture.asset(
                                                    "assets/images/download_icon.svg")),
                                            onTap: () {
                                              launchURL(
                                                  "https://members.rotary3131.org/member-login/" +
                                                      snapshot.data[index]
                                                          .document);
                                            },
                                          )
                                        ]),
                                  ),
                                )))));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      );
    });
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}

//import 'package:rotary_district_3131_flutter/model/ProfileResponse.dart';

class ClubBulletin_repo {
  Future<List<ClubBulletinResult?>> getClubBulletinData(
      String clubNumber) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubBulletin.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSClubBulletin.php'));
    request.bodyFields = {
      'clubNumber': clubNumber,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    List<ClubBulletinResult?> result;
    if (jsonData.toString().contains("ClubNumber")) {
      // LoginResult userData = LoginResult.fromJson(json.decode(res));
      final List t = json.decode(res);

      final List<ClubBulletinResult> userList =
          t.map((item) => ClubBulletinResult.fromJson(item)).toList();

      print("Length " + userList.length.toString());

      result = userList;
      //print(result.clubNumber);
    } else {
      result = List.empty();
    }
    return result;
    //return responseFromJson(res);
  }
}
