import 'package:flutter/material.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/repository/ProjectDetailsListrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProjectViewDetails extends StatefulWidget {
  String Tag;
  String Title;
  String startDate;
  String EndDate;
  String ProDesc;
  String ProId;
  String PresidentName;
  String PARAM_POJECT;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ProjectViewDetails({
    required this.Tag,
    required this.Title,
    required this.startDate,
    required this.EndDate,
    required this.ProDesc,
    required this.ProId,
    required this.PresidentName,
    required this.PARAM_POJECT,
  });

  @override
  _ProjectViewDetailsState createState() => _ProjectViewDetailsState(
        Tag,
        Title,
        startDate,
        EndDate,
        ProDesc,
        ProId,
        PresidentName,
        PARAM_POJECT,
      );
}

class _ProjectViewDetailsState extends State<ProjectViewDetails> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false;
  String? Tag, Title, startDate, EndDate, ProDesc, ProId;
  String? PresidentName;
  String? PARAM_POJECT;

  //String? MeetingId;
  _ProjectViewDetailsState(
      String Tag,
      String Title,
      String startDate,
      String EndDate,
      String ProDesc,
      String ProId,
      String PresidentName,
      String PARAM_POJECT) {
    this.Tag = Tag;
    this.Title = Title;
    this.startDate = startDate;
    this.EndDate = EndDate;
    this.ProDesc = ProDesc;
    this.ProId = ProId;
    this.PresidentName = PresidentName;
    this.PARAM_POJECT = PARAM_POJECT;
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _prefs.then((SharedPreferences prefs) async {
      Tag = prefs.getString('Tag')!;
      Title = prefs.getString('Title')!;
      startDate = prefs.getString('startDate')!;
      EndDate = prefs.getString('EndDate')!;
      ProDesc = prefs.getString('ProDesc')!;
      ProId = prefs.getString('ProId')!;
      PresidentName = prefs.getString('PresidentName');
      PARAM_POJECT = prefs.getString('PARAM_POJECT');
    });
    print("Tag:" + Tag!);
    print("Title: " + Title!);
    print("startDate: " + startDate!);
    print("endDate:" + EndDate!);
    print("ProjectDesc: " + ProDesc!);
    print("ProjectId: " + ProId!);
    print("PresidentName: " + PresidentName!);
    print("PARAM_POJECT: " + PARAM_POJECT!);
  }

  @override
  Widget build(BuildContext context) {
    var margin_for_text = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 15,
      bottom: MediaQuery.of(context).size.width / 40,
    );
    var margin_for_value = EdgeInsets.only(
      top: MediaQuery.of(context).size.width / 15,
      left: MediaQuery.of(context).size.width / 15,
    );
    var margin_for_icon = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 15,
      right: MediaQuery.of(context).size.width / 15,
    );
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
              leading: BackButton(
                color: Constant.color_club_project_theme,
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.white,
              title: Text("Project",
                  style: TextStyle(
                      color: Constant.color_club_project_theme,
                      fontWeight: FontWeight.bold))),
          body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10.sp, left: 10.sp),
                      child: Text("Tag"),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.sp),
                      padding: EdgeInsets.all(5.sp),
                      height: 5.h,
                      width: double.maxFinite,
                      alignment: Alignment.topLeft,
                      child: Text(
                        Tag!,
                        style: TextStyle(),
                      ),
                      decoration: BoxDecoration(
                        color: Constant.color_club_project,
                        border: Border.all(
                            color: Constant.color_club_project_theme),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10.sp, left: 10.sp),
                      child: Text("Title"),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.sp),
                      padding: EdgeInsets.all(5.sp),
                      // height: 5.h,
                      width: double.maxFinite,
                      alignment: Alignment.topLeft,
                      child: Text(
                        Title!,
                        style: TextStyle(),
                      ),
                      decoration: BoxDecoration(
                        color: Constant.color_club_project,
                        border: Border.all(
                            color: Constant.color_club_project_theme),
                      ),
                    ),
                    if (PresidentName != null)
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 10.sp, left: 10.sp),
                        child: Text("President Name"),
                      ),
                    if (PresidentName != null)
                      Container(
                        margin: EdgeInsets.all(10.sp),
                        padding: EdgeInsets.all(5.sp),
                        // height: 5.h,
                        width: double.maxFinite,
                        alignment: Alignment.topLeft,
                        child: Text(
                          PresidentName!,
                          style: TextStyle(),
                        ),
                        decoration: BoxDecoration(
                          color: Constant.color_club_project,
                          border: Border.all(
                              color: Constant.color_club_project_theme),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.all(10.sp),
                      padding: EdgeInsets.all(6.sp),
                      height: 5.h,
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: Text(
                        "Project Details",
                        style: TextStyle(color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Constant.color_club_project_theme),
                          color: Constant.color_club_project_theme),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10.sp, left: 10.sp),
                      child: Text("Start Date"),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.sp),
                      padding: EdgeInsets.all(5.sp),
                      height: 5.h,
                      width: double.maxFinite,
                      alignment: Alignment.topLeft,
                      child: Text(
                        startDate!,
                        style: TextStyle(),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Constant.color_club_project_theme),
                          color: Constant.color_club_project),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10.sp, left: 10.sp),
                      child: Text("End Date"),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.sp),
                      padding: EdgeInsets.all(5.sp),
                      height: 5.h,
                      width: double.maxFinite,
                      alignment: Alignment.topLeft,
                      child: Text(
                        EndDate!,
                        style: TextStyle(),
                      ),
                      decoration: BoxDecoration(
                        color: Constant.color_club_project,
                        border: Border.all(
                            color: Constant.color_club_project_theme),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10.sp, left: 10.sp),
                      child: Text("Project Description"),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.sp),
                      padding: EdgeInsets.all(5.sp),
                      //height: 5.h,
                      width: double.maxFinite,
                      alignment: Alignment.topLeft,
                      // keyboardType: TextInputType.multiline,
                      child: Text(
                        ProDesc!,
                        softWrap: true,
                        style: TextStyle(),
                      ),
                      decoration: BoxDecoration(
                        color: Constant.color_club_project,
                        border: Border.all(
                            color: Constant.color_club_project_theme),
                      ),
                    ),
                    if (PARAM_POJECT == "YOUR CLUB PROJECT")
                      DefaultTabController(
                        length: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            /*Container(
                                child: */
                            TabBar(
                                indicatorColor:
                                    Constant.color_club_project_theme,
                                padding: EdgeInsets.zero,
                                indicatorPadding: EdgeInsets.zero,
                                labelPadding: EdgeInsets.zero,
                                //  physics: ScrollPhysics(),
                                //isScrollable: true,
                                tabs: [
                                  Tab(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      child: Text(
                                        "Attending",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  // Tab(text: "Articles"),
                                  Tab(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7,
                                      child: Text(
                                        "Comments",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                      child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                    child: Text(
                                      "Likes",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                ]),
                            //),
                            Container(
                              //Add this to give height
                              height: MediaQuery.of(context).size.height,
                              child: TabBarView(children: [
                                Container(
                                  child: FutureBuilder<dynamic>(
                                      future: ProjectDEtailsList_repo()
                                          .getAttendingList(ProId!),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasError) {
                                          showDialog(
                                            builder: (context) => AlertDialog(
                                              title: Text("Error"),
                                              content: Text(
                                                  snapshot.error.toString()),
                                            ),
                                            context: context,
                                          );
                                        } else if (snapshot!.hasData) {
                                          return Column(children: <Widget>[
                                            if (snapshot.data.length != 0)
                                              Container(
                                                margin: margin_for_value,
                                                child: Text(
                                                  "Attending " +
                                                      snapshot.data.length
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              25),
                                                ),
                                                alignment: Alignment.topLeft,
                                              ),
                                            if (snapshot.data.length == 0)
                                              Container(
                                                margin: margin_for_value,
                                                child: Text("Attending 0"),
                                                alignment: Alignment.center,
                                              ),
                                            ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemCount:
                                                    snapshot.data.length!,
                                                itemBuilder: (context, index) =>
                                                    ListTile(
                                                        title: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0.sp),
                                                            ),
                                                            elevation: 1,
                                                            // margin: EdgeInsets.all(20),
                                                            child: Container(
                                                                height: 10.h,
                                                                //height: 100,
                                                                /* height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            14,*/
                                                                child: Row(
                                                                    /* mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,*/
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: <Widget>[
                                                                      Container(
                                                                          alignment: Alignment
                                                                              .center,
                                                                          margin:
                                                                              EdgeInsets.only(left: 8.sp),
                                                                          child: CircleAvatar(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            radius:
                                                                                20.sp,
                                                                            /*child: CircleAvatar(
                                                                  radius: 48.0
                                                                      .sp,*/
                                                                            backgroundImage:
                                                                                NetworkImage(Constant.BASE_PATH + snapshot.data[index].userPhoto),
                                                                            /*backgroundColor:
                                                                      Colors
                                                                          .black12*/
                                                                            // Colors.transparent,
                                                                          )),
                                                                      Container(
                                                                          margin: EdgeInsets.only(
                                                                              left: 10
                                                                                  .sp),
                                                                          child: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  child: Text(snapshot.data[index].firstName + " " + snapshot.data[index].lastName),
                                                                                ),
                                                                                Container(child: Text(snapshot.data[index].PComments + "(" + snapshot.data[index].attendedBy + ")"))
                                                                              ])),
                                                                    ])))))
                                          ]);
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }),
                                ),
                                Container(
                                  child: FutureBuilder<dynamic>(
                                      future: ProjectDEtailsList_repo()
                                          .getCommentList(ProId!),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasError) {
                                          showDialog(
                                            builder: (context) => AlertDialog(
                                              title: Text("Error"),
                                              content: Text(
                                                  snapshot.error.toString()),
                                            ),
                                            context: context,
                                          );
                                        } else if (snapshot!.hasData) {
                                          return Column(children: <Widget>[
                                            if (snapshot.data.length != 0)
                                              Container(
                                                margin: margin_for_value,
                                                child: Text(
                                                  "Comments " +
                                                      snapshot.data.length
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              25),
                                                ),
                                                alignment: Alignment.topLeft,
                                              ),
                                            if (snapshot.data.length == 0)
                                              Container(
                                                margin: margin_for_value,
                                                child: Text("Comments 0"),
                                                alignment: Alignment.center,
                                              ),
                                            ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemCount:
                                                    snapshot.data.length!,
                                                itemBuilder: (context, index) =>
                                                    ListTile(
                                                        title: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0.sp),
                                                            ),
                                                            elevation: 1,
                                                            // margin: EdgeInsets.all(20),
                                                            child: Container(
                                                                height: 10.h,
                                                                //height: 100,
                                                                /* height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            14,*/
                                                                child: Row(
                                                                    /* mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,*/
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: <Widget>[
                                                                      Container(
                                                                          alignment: Alignment
                                                                              .center,
                                                                          margin:
                                                                              EdgeInsets.only(left: 8.sp),
                                                                          child: CircleAvatar(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            radius:
                                                                                20.sp,
                                                                            /*child: CircleAvatar(
                                                                  radius: 48.0
                                                                      .sp,*/
                                                                            backgroundImage:
                                                                                NetworkImage(Constant.BASE_PATH + snapshot.data[index].userPhoto),

                                                                            /*backgroundColor:
                                                                      Colors
                                                                          .black12*/
                                                                            // Colors.transparent,
                                                                          )),
                                                                      Container(
                                                                          margin: EdgeInsets.only(
                                                                              left: 10
                                                                                  .sp),
                                                                          child: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  child: Text(snapshot.data[index].firstName + " " + snapshot.data[index].lastName),
                                                                                ),
                                                                                Container(child: Text(snapshot.data[index].PComments + "(" + snapshot.data[index].attendedBy + ")"))
                                                                              ])),
                                                                    ])))))
                                          ]);
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }),
                                ),
                                Container(
                                  child: FutureBuilder<dynamic>(
                                      future: ProjectDEtailsList_repo()
                                          .getLikesList(ProId!),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasError) {
                                          showDialog(
                                            builder: (context) => AlertDialog(
                                              title: Text("Error"),
                                              content: Text(
                                                  snapshot.error.toString()),
                                            ),
                                            context: context,
                                          );
                                        } else if (snapshot!.hasData) {
                                          return Column(children: <Widget>[
                                            if (snapshot.data.length != 0)
                                              Container(
                                                margin: margin_for_value,
                                                child: Text(
                                                  "Likes " +
                                                      snapshot.data.length
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              25),
                                                ),
                                                alignment: Alignment.topLeft,
                                              ),
                                            if (snapshot.data.length == 0)
                                              Container(
                                                margin: margin_for_value,
                                                child: Text("Likes 0"),
                                                alignment: Alignment.center,
                                              ),
                                            ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemCount:
                                                    snapshot.data.length!,
                                                itemBuilder: (context, index) =>
                                                    ListTile(
                                                        title: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0.sp),
                                                            ),
                                                            elevation: 1,
                                                            // margin: EdgeInsets.all(20),
                                                            child: Container(
                                                                height: 10.h,
                                                                //height: 100,
                                                                /* height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            14,*/
                                                                child: Row(
                                                                    /* mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,*/
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: <Widget>[
                                                                      Container(
                                                                          alignment: Alignment
                                                                              .center,
                                                                          margin:
                                                                              EdgeInsets.only(left: 8.sp),
                                                                          child: CircleAvatar(
                                                                            /*backgroundColor:
                                                                          Constant
                                                                              .color_theme,*/
                                                                            radius:
                                                                                20.sp,
                                                                            backgroundImage:
                                                                                NetworkImage(Constant.BASE_PATH + snapshot.data[index].userPhoto),
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                          )),
                                                                      Container(
                                                                          margin: EdgeInsets.only(
                                                                              left: 10
                                                                                  .sp),
                                                                          child: Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  child: Text(snapshot.data[index].firstName + " " + snapshot.data[index].lastName),
                                                                                ),
                                                                                // Container(child: Text(snapshot.data[index].PComments + "(" + snapshot.data[index].attendedBy + ")"))
                                                                              ])),
                                                                    ])))))
                                          ]);
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      )
                  ])));
    });
  }
}
