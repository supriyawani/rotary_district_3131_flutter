import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/repository/ProjectReporting_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProjectReport extends StatefulWidget {
  String ProjectId;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ProjectReport({
    required this.ProjectId,
  });

  @override
  _ProjectReportState createState() => _ProjectReportState(
        ProjectId,
      );
}

class _ProjectReportState extends State<ProjectReport> {
  String ProjectId = "";

  //DateFormat dateFormat = DateFormat("dd MMMM yyyy, EEEE");

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String? _rupee,
      _amount,
      _workinghrs,
      _beneficiary,
      _partnerclub,
      non_roatary_partner;
  File? imageFile1;
  String? path1;
  String? Image1;
  var isUpload = false;

  _ProjectReportState(ProjectId) {
    this.ProjectId = ProjectId;
  }

  String? title, President, startDate, endDate, project_desc;

  @override
  void initState() {
    // TODO: implement initState
    //_tabController = TabController(length: 2, vsync: this);

    super.initState();
    isLoading = true;
    _prefs.then((SharedPreferences prefs) async {
      ProjectId = prefs.getString('ProjectId')!;
    });
    //_scaffoldKey = GlobalKey();
    print("ProjectId:" + ProjectId);
    loadData();
  }

  loadData() {
    ProjectRepoting_repo().getProjectReportData(ProjectId).then((result) => {
          if (result != null)
            {
              setState(() {
                title = result.title.toString();
                President = result.president.toString();
                startDate = result.startDate.toString();
                endDate = result.endDate.toString();
                project_desc = result.description.toString();
                Image1 = result.image1.toString();
                print("title:" + title.toString());
                print("President:" + President.toString());
                print("startDate:" + startDate.toString());
                print("endDate:" + endDate.toString());
                print("project_desc:" + project_desc.toString());

                isLoading = false;
              }),
            }
          else
            Constant.displayToast(""),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Constant.color_club_project_theme,
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            title: Text("Project Report",
                style: TextStyle(
                    color: Constant.color_club_project_theme,
                    fontWeight: FontWeight.bold)),
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _buildForm());
    });
  }

  _buildForm() {
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
                      height: 5.h,
                      width: 500.w,
                      margin: EdgeInsets.only(bottom: 4.sp),
                      alignment: Alignment.center,
                      child: Text(
                        "Project Details",
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          color: Constant.color_club_project_theme,
                          borderRadius: BorderRadius.circular(5)),
                    ),
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
                                          "Title",
                                          style: TextStyle(
                                              color: Constant
                                                  .color_club_project_theme,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      margin: margin_for_bottom,
                                      height: height,
                                      alignment: Alignment.center,
                                      width: widthofContainer,
                                      decoration: BoxDecoration(
                                          color: Constant.color_club_project,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        title!,
                                        style: TextStyle(
                                            color: Constant
                                                .color_club_project_theme),
                                      ),
                                    ),
                                    Container(
                                        margin: margin_for_bottom,
                                        child: Text(
                                          "Start Date",
                                          style: TextStyle(
                                              color: Constant
                                                  .color_club_project_theme,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      margin: margin_for_bottom,
                                      height: height,
                                      alignment: Alignment.center,
                                      width: widthofContainer,
                                      decoration: BoxDecoration(
                                          color: Constant.color_club_project,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        startDate!,
                                        style: TextStyle(
                                            color: Constant
                                                .color_club_project_theme),
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
                                                  "President",
                                                  style: TextStyle(
                                                      color: Constant
                                                          .color_club_project_theme,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Container(
                                              margin: margin_for_bottom,
                                              height: height,
                                              alignment: Alignment.center,
                                              width: widthofContainer,
                                              decoration: BoxDecoration(
                                                  color: Constant
                                                      .color_club_project,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                President!,
                                                style: TextStyle(
                                                    color: Constant
                                                        .color_club_project_theme),
                                              ),
                                            ),
                                            Container(
                                                margin: margin_for_bottom,
                                                child: Text(
                                                  "End Date",
                                                  style: TextStyle(
                                                      color: Constant
                                                          .color_club_project_theme,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Container(
                                              margin: margin_for_bottom,
                                              height: height,
                                              alignment: Alignment.center,
                                              width: widthofContainer,
                                              decoration: BoxDecoration(
                                                  color: Constant
                                                      .color_club_project,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                endDate!,
                                                style: TextStyle(
                                                    color: Constant
                                                        .color_club_project_theme),
                                              ),
                                            ),
                                          ]))),
                            ])),
                    Container(
                      height: 5.h,
                      width: 500.w,
                      margin: EdgeInsets.only(bottom: 4.sp),
                      alignment: Alignment.center,
                      child: Text(
                        "Project Cost",
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          color: Constant.color_club_project_theme,
                          borderRadius: BorderRadius.circular(5)),
                    ),
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
                                        "Indian Rupees",
                                        style: TextStyle(
                                            color: Constant
                                                .color_club_project_theme,
                                            // fontSize: 12,
                                            // fontSize: 12 * MediaQuery.textScaleFactorOf(context),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    margin: margin_for_textform,
                                    height: height,
                                    child: TextFormField(
                                      // initialValue: "Minutes of Meeting",
                                      // initialValue: "" + _rupee!,
                                      style: TextStyle(
                                        //fontSize: 15,
                                        color:
                                            Constant.color_club_project_theme,
                                      ),
                                      key: Key("_rupee"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          // labelText: "" + _minMeeting!,
                                          contentPadding: content_padding),
                                      onSaved: (value) {
                                        _rupee = value!.trim();
                                        print("report:" + _rupee!);
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
                                        "Amount",
                                        style: TextStyle(
                                            color: Constant
                                                .color_club_project_theme,
                                            // fontSize: 12,
                                            // fontSize: 12 * MediaQuery.textScaleFactorOf(context),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    margin: margin_for_textform,
                                    height: height,
                                    child: TextFormField(
                                      // initialValue: "Minutes of Meeting",
                                      // initialValue: "" + _rupee!,
                                      style: TextStyle(
                                        //fontSize: 15,
                                        color:
                                            Constant.color_club_project_theme,
                                      ),
                                      key: Key("_amount"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 3,
                                                  color: Colors.greenAccent)),
                                          // labelText: "" + _minMeeting!,
                                          focusColor:
                                              Constant.color_club_project_theme,
                                          contentPadding: content_padding),
                                      onSaved: (value) {
                                        _amount = value!.trim();
                                        print("Amount:" + _amount!);
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
                                        "Rotary Working Hours",
                                        style: TextStyle(
                                            color: Constant
                                                .color_club_project_theme,
                                            // fontSize: 12,
                                            // fontSize: 12 * MediaQuery.textScaleFactorOf(context),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    margin: margin_for_textform,
                                    height: height,
                                    child: TextFormField(
                                      // initialValue: "Minutes of Meeting",
                                      // initialValue: "" + _rupee!,
                                      style: TextStyle(
                                        //fontSize: 15,
                                        color:
                                            Constant.color_club_project_theme,
                                      ),
                                      key: Key("_workinghrs"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),

                                          // labelText: "" + _minMeeting!,
                                          contentPadding: content_padding),
                                      onSaved: (value) {
                                        _workinghrs = value!.trim();
                                        print("Working hours:" + _workinghrs!);
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
                                        "Number of Beneficiaries",
                                        style: TextStyle(
                                            color: Constant
                                                .color_club_project_theme,
                                            // fontSize: 12,
                                            // fontSize: 12 * MediaQuery.textScaleFactorOf(context),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    margin: margin_for_textform,
                                    height: height,
                                    child: TextFormField(
                                      // initialValue: "Minutes of Meeting",
                                      // initialValue: "" + _rupee!,
                                      style: TextStyle(
                                        //fontSize: 15,
                                        color:
                                            Constant.color_club_project_theme,
                                      ),
                                      key: Key("_beneficiary"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          // labelText: "" + _minMeeting!,
                                          contentPadding: content_padding),
                                      onSaved: (value) {
                                        _beneficiary = value!.trim();
                                        print("Working hours:" + _beneficiary!);
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
                                    height: 5.h,
                                    width: 500.w,
                                    margin: EdgeInsets.only(bottom: 4.sp),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Project Organiztion",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        color:
                                            Constant.color_club_project_theme,
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  Container(
                                      margin: margin_for_bottom,
                                      child: Text(
                                        "Partner Club",
                                        style: TextStyle(
                                            color: Constant
                                                .color_club_project_theme,
                                            // fontSize: 12,
                                            // fontSize: 12 * MediaQuery.textScaleFactorOf(context),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    margin: margin_for_textform,
                                    height: height,
                                    child: TextFormField(
                                      // initialValue: "Minutes of Meeting",
                                      // initialValue: "" + _rupee!,
                                      style: TextStyle(
                                        //fontSize: 15,
                                        color:
                                            Constant.color_club_project_theme,
                                      ),
                                      key: Key("_partnerclub"),
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          // labelText: "" + _minMeeting!,
                                          contentPadding: content_padding),
                                      onSaved: (value) {
                                        _partnerclub = value!.trim();
                                        print("Partner Club:" + _partnerclub!);
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
                                        "Non Rotary Partner",
                                        style: TextStyle(
                                            color: Constant
                                                .color_club_project_theme,
                                            // fontSize: 12,
                                            // fontSize: 12 * MediaQuery.textScaleFactorOf(context),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    margin: margin_for_textform,
                                    //  height: height,
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      //expands: true,
                                      maxLines: null,
                                      // initialValue: "Minutes of Meeting",
                                      // initialValue: "" + _rupee!,
                                      style: TextStyle(
                                        //fontSize: 15,
                                        color:
                                            Constant.color_club_project_theme,
                                      ),
                                      key: Key("non_roatary_partner"),
                                      // keyboardType: TextInputType.text,

                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),

                                          // labelText: "" + _minMeeting!,
                                          contentPadding: content_padding),
                                      onSaved: (value) {
                                        non_roatary_partner = value!.trim();
                                        print("Non Rotary Partner:" +
                                            non_roatary_partner!);
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
                                      height: 8.h,
                                      child: Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            if (Image1 != "" &&
                                                imageFile1 == null)
                                              Expanded(
                                                  child: Container(
                                                      height: imgheight,
                                                      width: imgwidth,
                                                      child: Image.network(
                                                          Constant.BASE_PATH +
                                                              Image1!))),
                                            if (Image1 == "" || Image1 == null)
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
                                                ),
                                              )),
                                            Expanded(
                                                child: Container(
                                                    child: Text("Image 1"))),
                                            Expanded(
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 20.sp),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        // _getFromGallery();
                                                        PickedFile? pickedFile =
                                                            await ImagePicker()
                                                                .getImage(
                                                          source: ImageSource
                                                              .gallery,
                                                        );

                                                        if (pickedFile !=
                                                            null) {
                                                          setState(() {
                                                            isUpload = true;
                                                            imageFile1 = File(
                                                                pickedFile
                                                                    .path);
                                                            path1 = imageFile1!
                                                                .path;
                                                            print("path1" +
                                                                path1!);
                                                          });
                                                        }
                                                      },
                                                      child: Icon(
                                                        Icons.upload,
                                                      ),
                                                    )))
                                          ])),
                                ])))
                  ]))
        ]));
  }
}
