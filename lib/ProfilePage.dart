import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/ProfileResponse.dart';
import 'package:rotary_district_3131_flutter/widget/ButtonWidget.dart';
import 'package:rotary_district_3131_flutter/widget/NumbersWidget.dart';
import 'package:rotary_district_3131_flutter/widget/ProfileWidget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EditProfile_repo().getProfiledata("29429", "Member").then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    final user = ProfileResponse();

    return /*ThemeSwitchingArea(
      child: */
        Scaffold(
      //builder: (context) => Scaffold(
        //appBar: buildAppBar(context),
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.userPhoto.toString(),
              onClicked: () {
                /* Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );*/
              },
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 24),
            Center(child: buildUpgradeButton()),
            const SizedBox(height: 24),
            NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(user),
          ],
        ),
     // ),
      //),
    );
  }

  Widget buildName(ProfileResponse user) => Column(
        children: [
          Text(
            user.firstName.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email.toString(),
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
      );

  Widget buildAbout(ProfileResponse user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.professionalSalutation.toString(),
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}

class EditProfile_repo {
  Future<ProfileResponse?> getProfiledata(
      String userId, String AccessLevel) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSUserProfile.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSUserProfile.php'));
    request.bodyFields = {
      'userId': "29429",
      'AccessLevel': "President Elect",
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    ProfileResponse? result;
    if (jsonData.toString().contains("UserId")) {
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
  }
}
