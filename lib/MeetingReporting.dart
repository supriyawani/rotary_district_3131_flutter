import 'package:flutter/material.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/repository/MeetingReporting_repo.dart';

class MeetingReporting extends StatefulWidget {
  _MeetingReportingState createState() => _MeetingReportingState();
}

class _MeetingReportingState extends State<MeetingReporting> {
  String MeetingId = "38826";
  String clubName = "Pune Sahyadri";
  String? president;
  String? meetingNo, meetingType;
  String? meetingDate;
  String? report;
  String? clubMembersPresent;
  String? annetPresent;
  String? visitingRotarians;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  final _formKey = GlobalKey<FormState>();
  String? _minMeeting, _attendance, _present, _visitingRotarian;

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadmemberinfo();
  }

  void _loadData() {
    MeetingRepoting_repo().getMeetingReportData(MeetingId).then((result) {
      if (result != null) {
        setState(() {
          meetingNo = result.meetingNo.toString();
          meetingType = result.meetingType.toString();
          meetingDate = result.meetingDate.toString();
          print("MeetingNo:" + meetingNo.toString());
        });
      }
    });
  }

  void _loadmemberinfo() {
    /* ClubMemberInfo_repo().getPresident(clubName).then((result) {
      if (result != null) {
        setState(() {
          president =
              result.first!.firstName.toString() + " " + result.first!.lastName.toString();
          print("president:" + president.toString());
        });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    var margin_for_text = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 30,
      // top: MediaQuery.of(context).size.width / 50,
    );
    var margin_for_bottom = EdgeInsets.only(
      bottom: MediaQuery.of(context).size.width / 30,
      // top: MediaQuery.of(context).size.width / 50,
    );
    var margin_for_textform = EdgeInsets.only(
      //  left: MediaQuery.of(context).size.width / 30,
      right: MediaQuery.of(context).size.width / 30,
      bottom: MediaQuery.of(context).size.width / 30,
      // top: MediaQuery.of(context).size.width / 50,
    );
    var content_padding = EdgeInsets.all(
      MediaQuery.of(context).size.width / 40,
    );
    var height = MediaQuery.of(context).size.height / 20;
    var widthofContainer = MediaQuery.of(context).size.width * 0.40;
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Constant.color_theme,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text("Meeting Reporting",
              style: TextStyle(
                  color: Constant.color_theme, fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(
            MediaQuery.of(context).size.width / 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: margin_for_text,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              Container(
                                  margin: margin_for_bottom,
                                  child: Text(
                                    "Meeting Number",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                margin: margin_for_bottom,
                                height: height,
                                alignment: Alignment.center,
                                width: widthofContainer,
                                decoration: BoxDecoration(
                                    color: Constant.color_theme,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  meetingNo!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                  margin: margin_for_bottom,
                                  child: Text(
                                    "Meeting Date",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                margin: margin_for_bottom,
                                height: height,
                                alignment: Alignment.center,
                                width: widthofContainer,
                                decoration: BoxDecoration(
                                    color: Constant.color_theme,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  meetingDate!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ])),
                        Expanded(
                            child: Container(
                                margin: margin_for_text,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          margin: margin_for_bottom,
                                          child: Text(
                                            "Meeting Type",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Container(
                                        margin: margin_for_bottom,
                                        height: height,
                                        alignment: Alignment.center,
                                        width: widthofContainer,
                                        decoration: BoxDecoration(
                                            color: Constant.color_theme,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          meetingType!,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                          margin: margin_for_bottom,
                                          child: Text(
                                            "President",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Container(
                                        margin: margin_for_bottom,
                                        height: height,
                                        alignment: Alignment.center,
                                        width: widthofContainer,
                                        decoration: BoxDecoration(
                                            color: Constant.color_theme,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          "Rutuja Sontakke",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ]))),
                      ])),
              Container(
                  margin: margin_for_text,
                  child: new Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: margin_for_bottom,
                                child: Text(
                                  "Minutes Of Meeting",
                                  style: TextStyle(
                                      color: Constant.color_theme,
                                      // fontSize: 12,
                                      // fontSize: 12 * MediaQuery.textScaleFactorOf(context),
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                              margin: margin_for_textform,
                              height: height,
                              child: TextFormField(
                                initialValue: "Minutes of Meeting",
                                style: TextStyle(
                                  //fontSize: 15,
                                  color: Constant.color_theme,
                                ),
                                key: Key("_minMeeting"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    //labelText: 'Minutes of Meeting',
                                    contentPadding: content_padding),
                                onSaved: (value) {
                                  _minMeeting = value!.trim();
                                  print("_minMeeting:" + _minMeeting!);
                                },
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'this field is required';
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                              ),
                            ),
                            Container(
                                margin: margin_for_bottom,
                                child: Text(
                                  "Non QR members + Markup Attendance",
                                  style: TextStyle(
                                      color: Constant.color_theme,
                                      // fontSize: 12,
                                      // fontSize: 12 * MediaQuery.textScaleFactorOf(context),
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                              margin: margin_for_textform,
                              height: height,
                              child: TextFormField(
                                initialValue: "Enter only Numbers",
                                style: TextStyle(
                                  //fontSize: 15,
                                  color: Constant.color_theme,
                                ),
                                key: Key("_attendance"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: ,
                                    contentPadding: content_padding),
                                onSaved: (value) {
                                  _attendance = value!.trim();
                                  print("_attendance:" + _attendance!);
                                },
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'this field is required';
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                              ),
                            ),
                            Container(
                                margin: margin_for_bottom,
                                child: Text(
                                  "Ann Present",
                                  style: TextStyle(
                                      color: Constant.color_theme,
                                      // fontSize: 12,
                                      // fontSize: 12 * MediaQuery.textScaleFactorOf(context),
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                              margin: margin_for_textform,
                              height: height,
                              child: TextFormField(
                                initialValue: "Ann Present",
                                style: TextStyle(
                                  //fontSize: 15,
                                  color: Constant.color_theme,
                                ),
                                key: Key("_present"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: ,
                                    contentPadding: content_padding),
                                onSaved: (value) {
                                  _present = value!.trim();
                                  print("_present:" + _present!);
                                },
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'this field is required';
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                              ),
                            ),
                            Container(
                                margin: margin_for_bottom,
                                child: Text(
                                  "Visiting Rotarians",
                                  style: TextStyle(
                                      color: Constant.color_theme,
                                      // fontSize: 12,
                                      // fontSize: 12 * MediaQuery.textScaleFactorOf(context),
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                              margin: margin_for_textform,
                              height: height,
                              child: TextFormField(
                                initialValue: "Visiting Rotarians",
                                style: TextStyle(
                                  //fontSize: 15,
                                  color: Constant.color_theme,
                                ),
                                key: Key("_visitingRotarian"),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: ,
                                    contentPadding: content_padding),
                                onSaved: (value) {
                                  _visitingRotarian = value!.trim();
                                  print("_visitingRotarian:" +
                                      _visitingRotarian!);
                                },
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'this field is required';
                                  }
                                  _formKey.currentState!.save();
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              margin: margin_for_bottom,
                              height: height,
                              alignment: Alignment.centerLeft,
                              // width: widthofContainer,
                              decoration: BoxDecoration(
                                  color: Constant.color_theme,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "   Upload Images",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(child: Row())
                          ])))
            ],
          ),
        ),
      ),
    );
  }
}
