import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/repository/ClubMemberInfo_repo.dart';
import 'package:rotary_district_3131_flutter/repository/MeetingReporting_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class MeetingReporting extends StatefulWidget {
  String MeetingId;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  MeetingReporting({
    required this.MeetingId,
  });

  _MeetingReportingState createState() => _MeetingReportingState(MeetingId);
}

class _MeetingReportingState extends State<MeetingReporting> {
  //String MeetingId = "38826";
  String MeetingId = "";
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
  String? _minMeeting;
  String _attendance = "";
  String _present = "";
  String _visitingRotarian = "";
  var isLoading = false;
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;
  File? imageFile4;
  String? path1;
  String? path2;
  String? path3;
  String? path4;
  String? ReportApproveStatus;
  String? _report;
  var isUpload = false;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _MeetingReportingState(String MeetingId) {
    this.MeetingId = MeetingId;
  }
  @override
  void initState() {
    super.initState();
    isLoading = true;
    _prefs.then((SharedPreferences prefs) async {
      MeetingId = prefs.getString('MeetingId')!;
    });
    print("MeetingId:" + MeetingId);
    _loadData();
    _loadmemberinfo();
  }

  void _loadData() async {
    MeetingRepoting_repo().getMeetingReportData(MeetingId).then((result) {
      if (result != null) {
        setState(() {
          meetingNo = result.meetingNo.toString();
          meetingType = result.meetingType.toString();
          meetingDate = result.meetingDate.toString();
          _report = result.report.toString();
          _attendance = result.clubMembersPresent.toString();
          _present = result.annetPresent.toString();
          _visitingRotarian = result.visitingRotarians.toString();
          image1 = result.image1.toString();
          image2 = result.image2.toString();
          image3 = result.image3.toString();
          image4 = result.image4.toString();
          print("MeetingNo:" + meetingNo.toString());
          isLoading = false;
        });
      } else {
        setState(() {
          //Constant.displayToast("Response Failure!");
        });
      }
    });
  }

  void _loadmemberinfo() {
    ClubMemberInfo_repo().getPresident(clubName).then((result) {
      if (result != null) {
        setState(() {
          //  president = result[0]!.firstName.toString();
          //president = result.length.toString();
          result.toString();
          print("president:" + result.toString());
        });
      } else {
        setState(() {
          print("president not found");
        });
      }
    });
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

    var imgheight = MediaQuery.of(context).size.height / 20;
    var imgwidth = MediaQuery.of(context).size.width / 20;
    var imgmargin =
        EdgeInsets.only(top: MediaQuery.of(context).size.width / 10);
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
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _buildReport());
  }

  _buildReport() {
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

    var imgheight = MediaQuery.of(context).size.height / 20;
    var imgwidth = MediaQuery.of(context).size.width / 20;
    var imgmargin =
        EdgeInsets.only(top: MediaQuery.of(context).size.width / 10);
    return Sizer(builder: (context, orientation, deviceType) {
      return SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Card(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                      Container(
                                          margin: margin_for_bottom,
                                          child: Text(
                                            "Meeting Number",
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
                                          meetingNo!,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Container(
                                          margin: margin_for_bottom,
                                          child: Text(
                                            "Meeting Date",
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Container(
                                                margin: margin_for_bottom,
                                                height: height,
                                                alignment: Alignment.center,
                                                width: widthofContainer,
                                                decoration: BoxDecoration(
                                                    color: Constant.color_theme,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  meetingType!,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                  margin: margin_for_bottom,
                                                  child: Text(
                                                    "President",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Container(
                                                margin: margin_for_bottom,
                                                height: height,
                                                alignment: Alignment.center,
                                                width: widthofContainer,
                                                decoration: BoxDecoration(
                                                    color: Constant.color_theme,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                  "Rutuja Sontakke",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ]))),
                              ])),
                      Container(
                          margin: margin_for_text,
                          child: Form(
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
                                        // initialValue: "Minutes of Meeting",
                                        initialValue: "" + _report!,
                                        style: TextStyle(
                                          //fontSize: 15,
                                          color: Constant.color_theme,
                                        ),
                                        key: Key("_report"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            // labelText: "" + _minMeeting!,
                                            contentPadding: content_padding),
                                        onSaved: (value) {
                                          _report = value!.trim();
                                          print("report:" + _report!);
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
                                          "Non QR members + Markup Attendance (Enter only Numbers)",
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
                                        // initialValue: "Enter only Numbers",
                                        initialValue: "" + _attendance!,
                                        style: TextStyle(
                                          //fontSize: 15,
                                          color: Constant.color_theme,
                                        ),
                                        key: Key("_attendance"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            //labelText: "" + _attendance!,
                                            contentPadding: content_padding),
                                        onSaved: (value) {
                                          _attendance = value!.trim();
                                          print("_attendance:" + _attendance!);
                                        },
                                        /* validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'this field is required';
                                          }
                                          _formKey.currentState!.save();
                                          return null;
                                        },*/
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
                                        //  initialValue: "Ann Present",
                                        initialValue: "" + _present!,
                                        style: TextStyle(
                                          //fontSize: 15,
                                          color: Constant.color_theme,
                                        ),
                                        key: Key("_present"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            //labelText: "" + _present!,
                                            contentPadding: content_padding),
                                        onSaved: (value) {
                                          _present = value!.trim();
                                          print("_present:" + _present!);
                                        },
                                        /*  validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'this field is required';
                                          }
                                          _formKey.currentState!.save();
                                          return null;
                                        },*/
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
                                        //initialValue: "Visiting Rotarians",
                                        initialValue: "" + _visitingRotarian!,
                                        style: TextStyle(
                                          //fontSize: 15,
                                          color: Constant.color_theme,
                                        ),
                                        key: Key("_visitingRotarian"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            // labelText: "" + _visitingRotarian!,
                                            contentPadding: content_padding),
                                        onSaved: (value) {
                                          _visitingRotarian = value!.trim();
                                          print("_visitingRotarian:" +
                                              _visitingRotarian!);
                                        },
                                        /* validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'this field is required';
                                          }
                                          _formKey.currentState!.save();
                                          return null;
                                        },*/
                                      ),
                                    ),
                                    Container(
                                      margin: margin_for_bottom,
                                      height: height,
                                      alignment: Alignment.centerLeft,
                                      // width: widthofContainer,
                                      decoration: BoxDecoration(
                                          color: Constant.color_theme,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "   Upload Images",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        child: Text(
                                      "Size should be less than 1MB for each photo",
                                      style: TextStyle(color: Colors.red),
                                    )),
                                    // Column(children:[
                                    Container(
                                        margin: EdgeInsets.only(top: 5.sp),
                                        height: 8.h,
                                        child: Row(
                                            // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              /*if (image1 != null ||
                                                imageFile1 == null)
                                              Expanded(
                                                  child: Container(
                                                      height: imgheight,
                                                      width: imgwidth,
                                                      child: Image.network(
                                                          Constant.BASE_PATH +
                                                              image1!))),*/ /*
                                        if (imageFile1 == null)
                                          Expanded(
                                              child: Container(
                                                  child: SvgPicture.asset(
                                                      'assets/images/Icon metro-image.svg'))),
                                        if (imageFile1 != null)
                                          Expanded(
                                              child: Container(
                                            height: imgheight,
                                            width: imgwidth,
                                            child: Image.file(
                                              imageFile1!,
                                            ),
                                          )),*/
                                              if (image1 != "" &&
                                                  imageFile1 == null)
                                                Expanded(
                                                    child: Container(
                                                        height: imgheight,
                                                        width: imgwidth,
                                                        child: Image.network(
                                                            Constant.BASE_PATH +
                                                                image1!))),
                                              if (image1 == "" ||
                                                  image1 == null)
                                                if (imageFile1 == null)
                                                  Expanded(
                                                      child: Container(
                                                          child: SvgPicture.asset(
                                                              'assets/images/Icon metro-image.svg'))),
                                              if (imageFile1 != null)
                                                Expanded(
                                                    child: Container(
                                                  height: imgheight,
                                                  width: imgwidth,
                                                  child: Image.file(
                                                    imageFile1!,
                                                    width: imgwidth,
                                                    height: 8.h,
                                                  ),
                                                )),
                                              Expanded(
                                                  child: Container(
                                                      child: Text("Image 1"))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 20.sp),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      // _getFromGallery();
                                                      PickedFile? pickedFile =
                                                          await ImagePicker()
                                                              .getImage(
                                                        source:
                                                            ImageSource.gallery,
                                                      );

                                                      if (pickedFile != null) {
                                                        setState(() {
                                                          isUpload = true;
                                                          imageFile1 = File(
                                                              pickedFile.path);
                                                          path1 =
                                                              imageFile1!.path;
                                                          print("path1:" +
                                                              path1!);
                                                        });
                                                      }
                                                    },
                                                    child: Icon(Icons.upload),
                                                  ))
                                            ])),
                                    Container(
                                        height: 8.h,
                                        margin: imgmargin,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              if (image2 != "" &&
                                                  imageFile2 == null)
                                                Expanded(
                                                    child: Container(
                                                        height: imgheight,
                                                        width: imgwidth,
                                                        child: Image.network(
                                                            Constant.BASE_PATH +
                                                                image2!))),
                                              if (image2 == "" ||
                                                  image2 == null)
                                                if (imageFile2 == null)
                                                  Expanded(
                                                      child: Container(
                                                          child: SvgPicture.asset(
                                                              'assets/images/Icon metro-image.svg'))),
                                              if (imageFile2 != null)
                                                Expanded(
                                                    child: Container(
                                                  height: imgheight,
                                                  width: imgwidth,
                                                  child: Image.file(
                                                    imageFile2!,
                                                    width: imgwidth,
                                                  ),
                                                )),
                                              Expanded(
                                                  child: Container(
                                                      child: Text("Image 2"))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 20.sp),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      // _getFromGallery();
                                                      PickedFile? pickedFile =
                                                          await ImagePicker()
                                                              .getImage(
                                                        source:
                                                            ImageSource.gallery,
                                                      );
                                                      if (pickedFile != null) {
                                                        setState(() {
                                                          isUpload = true;
                                                          imageFile2 = File(
                                                              pickedFile.path);
                                                          path2 =
                                                              imageFile2!.path;
                                                          print(
                                                              "path2" + path2!);
                                                        });
                                                      }
                                                    },
                                                    child: Icon(Icons.upload),
                                                  ))
                                            ])),
                                    Container(
                                        height: 8.h,
                                        margin: imgmargin,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              if (image3 != "" &&
                                                  imageFile3 == null)
                                                Expanded(
                                                    child: Container(
                                                        height: imgheight,
                                                        width: imgwidth,
                                                        child: Image.network(
                                                            Constant.BASE_PATH +
                                                                image3!))),
                                              if (image3 == "" ||
                                                  image3 == null)
                                                if (imageFile3 == null)
                                                  Expanded(
                                                      child: Container(
                                                          child: SvgPicture.asset(
                                                              'assets/images/Icon metro-image.svg'))),
                                              if (imageFile3 != null)
                                                Expanded(
                                                    child: Container(
                                                  height: imgheight,
                                                  width: imgwidth,
                                                  child: Image.file(
                                                    imageFile3!,
                                                    width: imgwidth,
                                                  ),
                                                )),
                                              Expanded(
                                                  child: Container(
                                                      child: Text("Image 3"))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 20.sp),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      // _getFromGallery();
                                                      PickedFile? pickedFile =
                                                          await ImagePicker()
                                                              .getImage(
                                                        source:
                                                            ImageSource.gallery,
                                                      );
                                                      if (pickedFile != null) {
                                                        setState(() {
                                                          isUpload = true;
                                                          imageFile3 = File(
                                                              pickedFile.path);
                                                          path3 =
                                                              imageFile3!.path;
                                                          print(
                                                              "path3" + path3!);
                                                        });
                                                      }
                                                    },
                                                    child: Icon(Icons.upload),
                                                  ))
                                            ])),
                                    //]))),
                                    Container(
                                        height: 8.h,
                                        margin: imgmargin,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              if (image4 != "" &&
                                                  imageFile4 == null)
                                                Expanded(
                                                    child: Container(
                                                        height: imgheight,
                                                        width: imgwidth,
                                                        child: Image.network(
                                                            Constant.BASE_PATH +
                                                                image4!))),
                                              if (image4 == "" ||
                                                  image4 == null)
                                                if (imageFile4 == null)
                                                  Expanded(
                                                      child: Container(
                                                          child: SvgPicture.asset(
                                                              'assets/images/Icon metro-image.svg'))),
                                              if (imageFile4 != null)
                                                Expanded(
                                                    child: Container(
                                                  height: imgheight,
                                                  width: imgwidth,
                                                  child: Image.file(
                                                    imageFile4!,
                                                    width: imgwidth,
                                                  ),
                                                )),
                                              Expanded(
                                                  child: Container(
                                                      child: Text("Image 4"))),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 20.sp),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      // _getFromGallery();
                                                      PickedFile? pickedFile =
                                                          await ImagePicker()
                                                              .getImage(
                                                        source:
                                                            ImageSource.gallery,
                                                      );
                                                      if (pickedFile != null) {
                                                        setState(() {
                                                          isUpload = true;
                                                          imageFile4 = File(
                                                              pickedFile.path);
                                                          path4 =
                                                              imageFile4!.path;
                                                          print(
                                                              "path4" + path4!);
                                                        });
                                                      }
                                                    },
                                                    child: Icon(Icons.upload),
                                                  ))
                                            ])),
                                    // ])),
                                    /*  Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            // width: MediaQuery.of(context).size.width / 2,
                                            margin: margin_for_textform,
                                            alignment: Alignment.center,
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                ReportApproveStatus = "Draft";

                                                saveData();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  //primary: Color(0xffdd1a27),
                                                  onPrimary: Colors.white,
                                                  backgroundColor: Constant
                                                      .color_theme // foreground
                                                  ),
                                              child: Text("Save"),
                                            ),
                                          ),
                                          // if (AccessLevel == "President")
                                          Container(
                                            // width: MediaQuery.of(context).size.width / 2,
                                            margin: margin_for_textform,
                                            alignment: Alignment.center,
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                ReportApproveStatus = "Publish";
                                                saveData();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  //primary: Color(0xffdd1a27),
                                                  onPrimary: Colors.white,
                                                  backgroundColor: Constant
                                                      .color_theme // foreground
                                                  ),
                                              child: Text("Approve"),
                                            ),
                                          ),
                                        ])*/
                                  ]))),
                      /*Container(
                          margin: EdgeInsets.only(top: 5.w),
                          child: ElevatedButtonTheme(
                            data: ElevatedButtonThemeData(
                              style: ElevatedButton.styleFrom(
                                  //primary: Color(0xffdd1a27),
                                  alignment: Alignment.center,
                                  onPrimary: Colors.white,
                                  backgroundColor:
                                      Constant.color_theme // foreground
                                  ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: 40.0.w,
                                    child: ElevatedButton(
                                      child: Text('Save'),
                                      onPressed: () {
                                        ReportApproveStatus = "Draft";

                                        saveData();
                                      },
                                    )),
                                Container(
                                    width: 40.0.w,
                                    child: ElevatedButton(
                                      child: Text('Approve'),
                                      onPressed: () {
                                        ReportApproveStatus = "Publish";
                                        saveData();
                                      },
                                    )),
                              ],
                            ),
                          )),*/
                    ])),
            Container(
                margin: EdgeInsets.only(top: 2.w, bottom: 5.w),
                child: ElevatedButtonTheme(
                  data: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        //primary: Color(0xffdd1a27),
                        alignment: Alignment.center,
                        onPrimary: Colors.white,
                        backgroundColor: Constant.color_theme // foreground
                        ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 40.0.w,
                          child: ElevatedButton(
                            child: Text('Save'),
                            onPressed: () {
                              ReportApproveStatus = "Draft";

                              saveData();
                            },
                          )),
                      Container(
                          width: 40.0.w,
                          child: ElevatedButton(
                            child: Text('Approve'),
                            onPressed: () {
                              ReportApproveStatus = "Publish";
                              saveData();
                            },
                          )),
                    ],
                  ),
                )),
          ]));
    });
  }

  saveData() async {
    if (this._formKey.currentState!.validate()) {
      String con = await Constant().checkConnectivity();
      if (con != '') {
        setState(() {
          //isLoading = true;
        });
        if (imageFile1 == null && image1 != null) {
          path1 = Constant.BASE_PATH + image1.toString();
        }
        if (imageFile1 == null && image1 == null) {
          path1 = "";
        }
        if (imageFile2 == null && image2 != null) {
          path2 = Constant.BASE_PATH + image2.toString();
        }
        if (imageFile2 == null && image2 == null) {
          path2 = "";
        }
        if (imageFile3 == null && image3 != null) {
          path3 = Constant.BASE_PATH + image3.toString();
        }
        if (imageFile3 == null && image3 == null) {
          path3 = "";
        }
        if (imageFile4 == null && image4 != null) {
          path4 = Constant.BASE_PATH + image4.toString();
        }
        if (imageFile4 == null && image4 == null) {
          path4 = "";
        }
        MeetingRepoting_repo()
            .postdata(
                MeetingId,
                _report.toString()!,
                _attendance.toString()!,
                _present.toString(),
                _visitingRotarian.toString(),
                path1.toString(),
                path2.toString(),
                path3.toString(),
                path4.toString(),
                ReportApproveStatus.toString(),
                isUpload)
            .then((result) {
          if (result != null) {
            setState(() {
              print("msg:" + result.msg.toString());
              Constant.displayToast("" + result.msg.toString());
              Navigator.of(context).pop();
            });
          } else {
            setState(() {
              //isLoading = false;
              Constant.displayToast("please enter valid credentials!");
            });
          }
        });
      }
      //upload(File(imageFile));
      else {
        Constant.displayToast("Please check your internet connection..!");
      }
    } else {
      print("_formKey.currentState is null!");
    }
  }
}
