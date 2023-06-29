import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/repository/AddComment_repo.dart';
import 'package:rotary_district_3131_flutter/repository/AddLike_repo.dart';
import 'package:rotary_district_3131_flutter/repository/MeetingAttendingList_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class MeetingDetails extends StatefulWidget {
  String MemberId, MeetingId, MeetingDate, topic, chiefGuest, PreMeetingNotes;
  String ClubName, AttendedBy, TotalLikes, TotalComments, ClubId, MemberLike;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  MeetingDetails({
    required this.MemberId,
    required this.MeetingId,
    required this.MeetingDate,
    required this.topic,
    required this.chiefGuest,
    required this.PreMeetingNotes,
    required this.ClubName,
    required this.AttendedBy,
    required this.TotalLikes,
    required this.TotalComments,
    required this.ClubId,
    required this.MemberLike,
  });

  @override
  _MeetingDetailsState createState() => _MeetingDetailsState(
      MemberId,
      MeetingId,
      MeetingDate,
      topic,
      chiefGuest,
      PreMeetingNotes,
      ClubName,
      AttendedBy,
      TotalLikes,
      TotalComments,
      ClubId,
      MemberLike);
}

class _MeetingDetailsState extends State<MeetingDetails> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false;
  String? MeetingId;
  String? MemberId;
  String? MeetingDate;
  String? topic;
  String? chiefGuest;
  String? PreMeetingNotes;
  String? ClubName;
  String? AttendedBy, TotalLikes, TotalComments, ClubId, MemberLike;
  Color _iconColor = Colors.white;

  String? _comment;

  String? MComments;

  //String? MeetingId;
  _MeetingDetailsState(
    String MemberId,
    String MeetingId,
    String MeetingDate,
    String topic,
    String chiefGuest,
    String PreMeetingNotes,
    String ClubName,
    String AttendedBy,
    String TotalLikes,
    String TotalComments,
    String ClubId,
    String MemberLike,
  ) {
    this.MemberId = MemberId;
    this.MeetingId = MeetingId;
    this.MeetingDate = MeetingDate;
    this.topic = topic;
    this.chiefGuest = chiefGuest;
    this.PreMeetingNotes = PreMeetingNotes;
    this.ClubName = ClubName;
    this.AttendedBy = AttendedBy;
    this.TotalLikes = TotalLikes;
    this.TotalComments = TotalComments;
    this.ClubId = ClubId;
    this.MemberLike = MemberLike;
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _prefs.then((SharedPreferences prefs) async {
      MemberId = prefs.getString('MemberId')!;
      MeetingId = prefs.getString('MeetingId')!;
      MeetingDate = prefs.getString('MeetingDate')!;
      topic = prefs.getString('topic')!;
      chiefGuest = prefs.getString('chiefGuest')!;
      PreMeetingNotes = prefs.getString('PreMeetingNotes')!;
      ClubName = prefs.getString('ClubName')!;
      AttendedBy = prefs.getString('AttendedBy')!;
      TotalLikes = prefs.getString('TotalLikes')!;
      TotalComments = prefs.getString('TotalComments')!;
      ClubId = prefs.getString('ClubId')!;
      MemberLike = prefs.getString('MemberLike')!;
    });
    print("MemberId: " + MemberId!);
    print("MeetingId: " + MeetingId!);
    print("MeetingDate: " + MeetingDate!);
    print("topic: " + topic!);
    print("chiefGuest: " + chiefGuest!);
    print("PreMeetingNotes: " + PreMeetingNotes!);
    print("ClubName: " + ClubName!);
    print("AttendedBy: " + AttendedBy!);
    print("TotalComments: " + TotalComments!);
    print("TotalLikes: " + TotalLikes!);
    print("ClubId: " + ClubId!);
    print("MemberLike: " + MemberLike!);
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
                color: Constant.color_theme,
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.white,
              title: Text("Club Meeting",
                  style: TextStyle(
                      color: Constant.color_theme,
                      fontWeight: FontWeight.bold))),
          body: SingleChildScrollView(
              child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 90),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height / 20,
                          margin: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 80),
                          child: Text(
                            MeetingDate!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height / 50),
                          ),
                          decoration: BoxDecoration(
                            color: Constant.color_theme,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      /*margin: margin_for_text,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(*/
                                      margin: margin_for_text,
                                      alignment: Alignment.topLeft,
                                      // child: Row(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            //margin: margin_for_text,
                                            child: Text(
                                              "Club Name:  ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                // fontSize: MediaQuery.of(context).size.width / 25
                                              ),
                                            ),
                                          ),
                                          /*SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5),*/
                                          /*Expanded(
                                              child: */
                                          Container(
                                            // margin: margin_for_text,
                                            child: Text(
                                              ClubName!,
                                              style: TextStyle(
                                                  //fontSize: MediaQuery.of(context).size.width / 25
                                                  ),
                                            ),
                                          )
                                        ],
                                      )),
                                  Container(
                                      /*  alignment: Alignment.topRight,
                                      margin: margin_for_text,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            //  margin: margin_for_text,*/
                                      margin: margin_for_text,
                                      alignment: Alignment.topLeft,
                                      // child: Row(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            //margin: margin_for_text,
                                            child: Text(
                                              "Topic:  ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                // fontSize: MediaQuery.of(context).size.width / 25
                                              ),
                                            ),
                                          ),
                                          /*  SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3),*/
                                          /* Expanded(
                                              child:*/
                                          Container(
                                            // margin: margin_for_text,
                                            child: Text(
                                              topic!,
                                              style: TextStyle(
                                                  //fontSize: MediaQuery.of(context).size.width / 25
                                                  ),
                                            ),
                                          )
                                        ],
                                      )),
                                  if (chiefGuest != null && chiefGuest != "")
                                    Container(
                                        margin: margin_for_text,
                                        alignment: Alignment.topLeft,
                                        // child: Row(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              //margin: margin_for_text,
                                              child: Text(
                                                "ChiefGuest:  ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  // fontSize: MediaQuery.of(context).size.width / 25
                                                ),
                                              ),
                                            ),
                                            /* Expanded(
                                                child:*/
                                            Container(
                                              // margin: margin_for_text,
                                              child: Text(
                                                chiefGuest!,
                                                style: TextStyle(
                                                    // fontSize: MediaQuery.of(context).size.width / 25
                                                    ),
                                              ),
                                            )
                                          ],
                                        )),
                                  if (PreMeetingNotes != null &&
                                      PreMeetingNotes != "")
                                    Container(
                                        margin: margin_for_text,
                                        alignment: Alignment.topLeft,
                                        // child: Row(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                //  margin: margin_for_text,
                                                child: Text(
                                                  "PreMeetingNotes:  ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    // fontSize: MediaQuery.of(context).size.width / 25
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  // margin: margin_for_text,
                                                  child: Text(
                                                PreMeetingNotes!,
                                                style: TextStyle(
                                                    // fontSize: MediaQuery.of(context).size.width / 25
                                                    ),
                                              )),
                                            ])),
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Constant.color_theme,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              17,
                                      padding: margin_for_icon,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                              child: Container(
                                                child: Text(
                                                  "Comment",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {
                                                MeetingId;
                                                AttendedBy;
                                                showAlertDialog(context);
                                              }),
                                          VerticalDivider(
                                            color: Colors.white,
                                            //color of divider
                                            width: 0.5.w,
                                            //width space of divider
                                            thickness: 0.2.w,
                                            //thickness of divier line
                                            indent: 6.sp,
                                            //Spacing at the top of divider.
                                            endIndent: 6
                                                .sp, //Spacing at the bottom of divider.
                                          ),
                                          if (MemberLike == "0")
                                            IconButton(
                                              icon: SvgPicture.asset(
                                                "assets/images/Icon awesome-heart.svg",
                                                color: _iconColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  /* MeetingId =
                                                      snapshot
                                                          .data[index]
                                                          .meetingId;
                                                  AttendedBy =
                                                      AccessLevel;
                                                  MLike = "1";*/
                                                  addlike();
                                                });
                                              },
                                            ),
                                          if (MemberLike == "1")
                                            IconButton(
                                              icon: SvgPicture.asset(
                                                "assets/images/Icon awesome-heart.svg",
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {});
                                              },
                                            ),
                                          VerticalDivider(
                                            color: Colors.white,
                                            //color of divider
                                            width: 0.5.w,
                                            //width space of divider
                                            thickness: 0.2.w,
                                            //thickness of divier line
                                            indent: 6.sp,
                                            //Spacing at the top of divider.
                                            endIndent: 6
                                                .sp, //Spacing at the bottom of divider.
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      90),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                        child: Container(
                                                      // margin: EdgeInsets.only(top: MediaQuery.of(context).size.width/90),
                                                      child: SvgPicture.asset(
                                                        "assets/images/Icon ionic-ios-thumbs-up.svg",
                                                        // height: MediaQuery.of(context).size.height/40,
                                                        //width: MediaQuery.of(context).size.width/50,
                                                      ),
                                                    )),
                                                    Expanded(
                                                        child: Container(
                                                            child: Text(
                                                      TotalLikes.toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              70),
                                                    )))
                                                  ])),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      90),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                        child: Container(
                                                      // margin: EdgeInsets.only(top: MediaQuery.of(context).size.width/90),
                                                      child: SvgPicture.asset(
                                                        "assets/images/comment_icon.svg",
                                                        // height: MediaQuery.of(context).size.height/40,
                                                        //width: MediaQuery.of(context).size.width/50,
                                                      ),
                                                    )),
                                                    Expanded(
                                                        child: Container(
                                                            child: Text(
                                                      TotalComments.toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              70),
                                                    )))
                                                  ])),
                                        ],
                                      )),
                                ])),
                        /* Container(
                        margin: margin_for_value,
                        child: Text(
                          "Attending",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 25),
                        ),
                        alignment: Alignment.topLeft,
                      ),*/
                        DefaultTabController(
                          length: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              /*Container(
                                child: */
                              TabBar(tabs: [
                                Tab(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.height / 7,
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
                                        MediaQuery.of(context).size.height / 7,
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
                                  width: MediaQuery.of(context).size.width / 3,
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
                                        future: MeetingAttendingList_repo()
                                            .getAttendingList(MeetingId!,
                                                AttendedBy!, ClubId!),
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
                                                        fontSize: MediaQuery.of(
                                                                    context)
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  physics: ScrollPhysics(),
                                                  itemCount:
                                                      snapshot.data.length!,
                                                  itemBuilder: (context,
                                                          index) =>
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
                                                                            alignment:
                                                                                Alignment.center,
                                                                            margin: EdgeInsets.only(left: 8.sp),
                                                                            child: CircleAvatar(
                                                                              backgroundColor: Constant.color_theme,
                                                                              radius: 20.sp,
                                                                              /*child: CircleAvatar(
                                                                  radius: 48.0
                                                                      .sp,*/
                                                                              backgroundImage: NetworkImage(Constant.BASE_PATH + snapshot.data[index].userPhoto),
                                                                              /*backgroundColor:
                                                                      Colors
                                                                          .black12*/
                                                                              // Colors.transparent,
                                                                            )),
                                                                        Container(
                                                                            margin:
                                                                                EdgeInsets.only(left: 10.sp),
                                                                            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                                                              Container(
                                                                                child: Text(snapshot.data[index].firstName + " " + snapshot.data[index].lastName),
                                                                              ),
                                                                              Container(child: Text(snapshot.data[index].mComments + "(" + snapshot.data[index].attendedBy + ")"))
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
                                        future: MeetingAttendingList_repo()
                                            .getCommentList(MeetingId!,
                                                AttendedBy!, ClubId!),
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
                                                        fontSize: MediaQuery.of(
                                                                    context)
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  physics: ScrollPhysics(),
                                                  itemCount:
                                                      snapshot.data.length!,
                                                  itemBuilder: (context,
                                                          index) =>
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
                                                                            alignment:
                                                                                Alignment.center,
                                                                            margin: EdgeInsets.only(left: 8.sp),
                                                                            child: CircleAvatar(
                                                                              backgroundColor: Constant.color_theme,
                                                                              radius: 20.sp,
                                                                              /*child: CircleAvatar(
                                                                  radius: 48.0
                                                                      .sp,*/
                                                                              backgroundImage: NetworkImage(Constant.BASE_PATH + snapshot.data[index].userPhoto),
                                                                              /*backgroundColor:
                                                                      Colors
                                                                          .black12*/
                                                                              // Colors.transparent,
                                                                            )),
                                                                        Container(
                                                                            margin:
                                                                                EdgeInsets.only(left: 10.sp),
                                                                            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                                                              Container(
                                                                                child: Text(snapshot.data[index].firstName + " " + snapshot.data[index].lastName),
                                                                              ),
                                                                              Container(child: Text(snapshot.data[index].mComments + "(" + snapshot.data[index].attendedBy + ")"))
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
                                        future: MeetingAttendingList_repo()
                                            .getLikeslist(MeetingId!,
                                                AttendedBy!, ClubId!),
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
                                                        fontSize: MediaQuery.of(
                                                                    context)
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  physics: ScrollPhysics(),
                                                  itemCount:
                                                      snapshot.data.length!,
                                                  itemBuilder: (context,
                                                          index) =>
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
                                                                            alignment:
                                                                                Alignment.center,
                                                                            margin: EdgeInsets.only(left: 8.sp),
                                                                            child: CircleAvatar(
                                                                              backgroundColor: Constant.color_theme,
                                                                              radius: 20.sp,
                                                                              /*child: CircleAvatar(
                                                                  radius: 48.0
                                                                      .sp,*/
                                                                              backgroundImage: NetworkImage(Constant.BASE_PATH + snapshot.data[index].userPhoto),
                                                                              /*backgroundColor:
                                                                      Colors
                                                                          .black12*/
                                                                              // Colors.transparent,
                                                                            )),
                                                                        Container(
                                                                            margin:
                                                                                EdgeInsets.only(left: 10.sp),
                                                                            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                                                              Container(
                                                                                child: Text(snapshot.data[index].firstName + " " + snapshot.data[index].lastName),
                                                                              ),
                                                                              // Container(child: Text(snapshot.data[index].mComments + "(" + snapshot.data[index].attendedBy + ")"))
                                                                            ])),
                                                                      ])))))
                                            ]);
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        )
                      ]))));
    });
  }

  addlike() async {
    MemberLike = "1";
    String con = await Constant().checkConnectivity();
    if (con != '') {
      setState(() {
        isLoading = true;
      });
      AddLike_repo()
          .addlike(MemberId!, ClubName!, MemberLike!, MeetingId!, AttendedBy!,
              ClubId!)
          .then((result) {
        if (result != null) {
          setState(() {
            print("msg:" + result.response.toString());
            Constant.displayToast("" + result.response.toString());
            if (result.response.toString() == "Success")
              _iconColor = Colors.red;
          });
        } else {
          setState(() {
            isLoading = false;
            print("msg:" + result!.response.toString());
            Constant.displayToast("" + result!.response.toString());
          });
        }
      });
    }
    //upload(File(imageFile));
    else {
      Constant.displayToast("Please check your internet connection..!");
    }
  }

  showAlertDialog(BuildContext context) {
    final TextEditingController _textFieldController = TextEditingController();

    AlertDialog alert = AlertDialog(
      title: Text("Enter Your Comment"),
      content: TextField(
        onChanged: (value) {
          setState(() {
            _comment = value;
          });
        },
        controller: _textFieldController,
        decoration: const InputDecoration(hintText: "Add Comment"),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: <Widget>[
        TextButton(
            onPressed: () {
              MComments = _comment.toString();
              print("MComments:" + MComments!);
              if (_comment != null) {
                print("_comment:" + MComments!);
                AddComment();
              } else {
                Constant.displayToast("Please add Comment");
              }
            },
            child: Text("Save")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel")),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  AddComment() async {
    String con = await Constant().checkConnectivity();
    if (con != '') {
      setState(() {
        isLoading = true;
      });
      AddComment_repo()
          .addComment(MemberId!, ClubName!, MComments!, MeetingId!, AttendedBy!,
              ClubId!)
          .then((result) {
        if (result != null) {
          setState(() {
            print("msg:" + result.response.toString());
            Constant.displayToast("" + result.response.toString());
            Navigator.of(context).pop();
          });
        } else {
          setState(() {
            isLoading = false;
            print("msg:" + result!.response.toString());
            Constant.displayToast("" + result!.response.toString());
            Navigator.of(context).pop();
          });
        }
      });
    }
    //upload(File(imageFile));
    else {
      Constant.displayToast("Please check your internet connection..!");
    }
  }
}
