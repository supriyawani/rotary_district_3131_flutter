import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/EditProfileResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanQrPage extends StatefulWidget {
  String MeetingId, ClubId, ClubName, MemberId, AccessLevel;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ScanQrPage({
    required this.MeetingId,
    required this.ClubId,
    required this.ClubName,
    required this.MemberId,
    required this.AccessLevel,
  });
  @override
  _ScanQrPageState createState() =>
      _ScanQrPageState(MeetingId, ClubId, ClubName, MemberId, AccessLevel);
}

class _ScanQrPageState extends State<ScanQrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String MeetingId = "",
      ClubId = "",
      ClubName = "",
      MemberId = "",
      AccessLevel = "";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _ScanQrPageState(MeetingId, ClubId, ClubName, MemberId, AccessLevel) {
    this.MeetingId = MeetingId;
    this.ClubId = ClubId;
    this.ClubName = ClubName;
    this.MemberId = MemberId;
    this.AccessLevel = AccessLevel;
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*_prefs.then((SharedPreferences prefs) async {
      MeetingId = prefs.getString('MeetingId')!;
    });*/
    _prefs.then((SharedPreferences prefs) async {
      MeetingId = prefs.getString('MeetingId')!;
      ClubId = prefs.getString('ClubNumber')!;
      ClubName = prefs.getString('ClubName')!;
      MemberId = prefs.getString('MemberId')!;
    });
    print("MeetingId:" + MeetingId);
    print("ClubId:" + ClubId);
    print("ClubName:" + ClubName);
    print("MemberId:" + MemberId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Mark Attendance"),
          backgroundColor: Constant.color_theme),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      print(scanData.code);

      //Navigator.of(context).pop();
      //if (ClubName == scanData.code.toString().contains("ClubName")) ;
      /* if ((ClubName ==
          scanData.code.toString().contains("ClubName").toString())) {
        print("abc");
      }*/
      // var res = <MeetingattQRreponse>.fromjson(jsonDecode(scanData.code.toString()));
      dynamic clubname = json.decode(scanData.code.toString())['ClubName'];
      dynamic ClubNumber = json.decode(scanData.code.toString())['ClubNumber'];
      dynamic QrType = json.decode(scanData.code.toString())['QrType'];
      print("clubname:" + clubname);
      print("clubnumber:" + ClubNumber);
      print("QrType:" + QrType);

      if (ClubName == clubname &&
          ClubId == ClubNumber &&
          QrType == "MeetingAndProject") {
        MarkAttendance()
            .postdata(MeetingId, ClubId, ClubName, MemberId, "A", "QrScan")
            .then((result) {
          if (result != null) {
            setState(() {
              print("msg:" + result.msg.toString());
              Constant.displayToast("" + result.msg.toString());
              Navigator.of(context).pop();
              /* if (AccessLevel != "Spouse") {
                AccessLevel = "Member";
              }*/
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClubMeeting(
                          ClubName: ClubName,
                          AccessLevel: AccessLevel,
                          MemberId: MemberId,
                          ClubId: ClubNumber)));*/
            });
          } else {
            setState(() {
              //isLoading = false;
              Constant.displayToast("Invalid QR Code!");
            });
          }
        });
      }
      /*if (await canLaunch(scanData.code)) {
        await launch(scanData.code);
      }
      controller.resumeCamera();*/
    });
  }
}

class MarkAttendance {
  Future<EditProfileResponse?> postdata(
      String MeetingId,
      String ClubId,
      String ClubName,
      String MemberId,
      String RegType,
      String AttendanceType) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    var request =
        //  http.Request('GET', Uri.parse(Constant.API_URL + 'iOSEditProfile.php'));
        http.Request('POST',
            Uri.parse(Constant.API_URL + 'iOSClubMeetingAttendance.php'));
    request.headers.addAll(headers);
    request.bodyFields = {
      'MeetingId': MeetingId,
      'ClubId': ClubId,
      'ClubName': ClubName,
      'MemberId': MemberId,
      'RegType': RegType,
      'AttendanceType': AttendanceType,
    };

    print(Constant.API_URL + 'iOSClubMeetingAttendance.php');
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    return responseFromJson(res);
  }
}
