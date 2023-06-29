import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rotary_district_3131_flutter/ProjectViewDetails.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/repository/AddComment_repo.dart';
import 'package:rotary_district_3131_flutter/repository/AddLike_repo.dart';
import 'package:rotary_district_3131_flutter/repository/ClubProjectListrepo.dart';
import 'package:rotary_district_3131_flutter/repository/MeetingAttendance_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class YourClubProject extends StatefulWidget {
  String ClubName;
  String AccessLevel;
  String MemberId;
  String ClubId;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  YourClubProject({
    required this.ClubName,
    required this.AccessLevel,
    required this.MemberId,
    required this.ClubId,
  });

  @override
  _YourClubProjectState createState() =>
      _YourClubProjectState(ClubName, AccessLevel, MemberId, ClubId);
}

class _YourClubProjectState extends State<YourClubProject> {
  String ClubName = "";
  String AccessLevel = "";
  String MemberId = "";
  String ClubId = "";
  var Date;

  DateFormat dateFormat = DateFormat("dd MMMM yyyy, EEEE");

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isLoading = false;

  String? ProjectId;
  String? MeetingDate, topic, chiefGuest, PreMeetingNotes;
  String? AttendedBy;
  String PAttending = "Attending";

  String? PComments;
  String? PLike;

  String? _comment;
  final _formKey = GlobalKey<FormState>();
  String? date;

  Color _iconColor = Colors.white;

  _YourClubProjectState(ClubName, AccessLevel, MemberId, ClubId) {
    this.ClubName = ClubName;
    this.AccessLevel = AccessLevel;
    this.MemberId = MemberId;
    this.ClubId = ClubId;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _prefs.then((SharedPreferences prefs) async {
      ClubName = prefs.getString('ClubName')!;
      AccessLevel = prefs.getString('AccessLevel')!;
      MemberId = prefs.getString('MemberId')!;
      ClubId = prefs.getString('ClubNumber')!;
    });
    //_scaffoldKey = GlobalKey();
    print("accesslevel:" + AccessLevel);
    print("ClubNumber.:" + ClubId!);
    print("ClubName.:" + ClubName!);
    print("MemberId.:" + MemberId!);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType)
    {
      return Scaffold(
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : _buildList(),
      );
    });
  }

  _buildList() {
    var margin_for_text = EdgeInsets.only(
      left: MediaQuery
          .of(context)
          .size
          .width / 15,
    );
    var margin_for_icon = EdgeInsets.only(
      left: MediaQuery
          .of(context)
          .size
          .width / 15,
      right: MediaQuery
          .of(context)
          .size
          .width / 15,
    );

    return FutureBuilder<dynamic>(
        future: ClubProjectList_repo()
            .getMeetinglist(ClubId, ClubName, AccessLevel, MemberId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            showDialog(
              builder: (context) =>
                  AlertDialog(
                    title: Text("Error"),
                    content: Text(snapshot.error.toString()),
                  ),
              context: context,
            );
          } else if (snapshot!.hasData) {
            //print(snapshot.data);
            return ListView.builder(
                itemCount: snapshot.data.length!,
                itemBuilder: (context, index) =>
                    ListTile(
                        title: Container(
                            alignment: Alignment.center,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 20,
                                    margin: EdgeInsets.all(
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width / 80),

                                    //   getDateformat();

                                    child: Text(
                                      dateFormat.format(DateTime.parse(
                                          snapshot.data[index].startDate)),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .height /
                                              50),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Constant.color_club_project_theme,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        if (snapshot.data[index]
                                            .approveStatus ==
                                            "Draft")
                                          Container(
                                            margin: margin_for_text,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Pending for President approval",
                                              style: TextStyle(
                                                  color: Colors.red),
                                            ),
                                          ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: margin_for_text,
                                              child: Text(
                                                "Club Name:  ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                ClubName,
                                                style: TextStyle(),
                                              ),
                                            )
                                          ],
                                        ),
                                        /*  Row(
                                      children: <Widget>[
                                        Container(
                                          margin: margin_for_text,
                                          child: Text(
                                            "Topic:  ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            snapshot.data[index].topic,
                                            style: TextStyle(),
                                          ),
                                        )
                                      ],
                                    ),*/
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              margin: margin_for_text,
                                              child: Text(
                                                "Members Responded:  ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                snapshot
                                                    .data[index]
                                                    .totalAttending,
                                                style: TextStyle(),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width /
                                                  50),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              //primary: Color(0xffdd1a27),
                                                onPrimary: Constant
                                                    .color_club_project_theme,
                                                backgroundColor: Colors.white
                                              // foreground
                                            ),
                                            child: Text("Mark Attendance"),
                                            onPressed: () {
                                              ProjectId =
                                                  snapshot.data[index].id
                                                      .toString();
                                              print("ProjectId:" + ProjectId!);

                                              /* Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      // ScanQrPage()
                                                      ScanQrPage(
                                                          ProjectId: ProjectId!,
                                                          ClubId: ClubId,
                                                          ClubName: ClubName,
                                                          MemberId: MemberId)
                                              ));*/
                                            },
                                          ),
                                        ),
                                        /*Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          */ /* width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,*/ /*
                                          margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  50),
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                //primary: Color(0xffdd1a27),
                                                onPrimary: Constant
                                                    .color_club_project_theme,
                                                backgroundColor: Colors.white
                                                // foreground
                                                ),
                                            onPressed: () {
                                              ProjectId = snapshot
                                                  .data[index].id
                                                  .toString();
                                              print("ProjectId:" + ProjectId!);

                                              MeetingDate = dateFormat.format(
                                                  DateTime.parse(snapshot
                                                      .data[index].startDate));

                                              */ /* topic = snapshot.data[index].topic
                                                  .toString();
                                              chiefGuest = snapshot
                                                  .data[index].chiefGuest
                                                  .toString();
                                              PreMeetingNotes = snapshot
                                                  .data[index].preMeetingNotes
                                                  .toString();
                                              String AttendedBy = AccessLevel;
                                              String TotalComments = snapshot
                                                  .data[index].totalComment;
                                              String TotalLikes = snapshot
                                                  .data[index].totalLike;
                                              print("MeetingDate:" +
                                                  MeetingDate!);
                                              print("topic:" + topic!);
                                              print(
                                                  "chiefGuest:" + chiefGuest!);
                                              print("PreMeetingNotes:" +
                                                  PreMeetingNotes!);
                                              print("ClubName:" + ClubName!);

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MeetingDetails(
                                                              ProjectId:
                                                                  ProjectId!,
                                                              MeetingDate:
                                                                  MeetingDate!,
                                                              topic: topic!,
                                                              chiefGuest:
                                                                  chiefGuest!,
                                                              PreMeetingNotes:
                                                                  PreMeetingNotes!,
                                                              ClubName:
                                                                  ClubName!,
                                                              AttendedBy:
                                                                  AttendedBy,
                                                              TotalLikes:
                                                                  TotalLikes,
                                                              TotalComments:
                                                                  TotalComments,
                                                              ClubId: ClubId)));*/ /*
                                            },
                                            child: Text("View Details"),
                                          ),
                                        ),
                                        if (AccessLevel == "President" ||
                                            AccessLevel == "Secretary" ||
                                            AccessLevel == "IT Office")
                                          */ /* if (snapshot.data[index]
                                                      .approveStatus ==
                                                  "Publish")*/ /*
                                          Container(
                                            */ /* width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,*/ /*
                                            margin: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50),
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    //primary: Color(0xffdd1a27),
                                                    onPrimary: Constant
                                                        .color_club_project_theme,
                                                    backgroundColor:
                                                        Colors.white
                                                    // foreground
                                                    ),
                                                onPressed: () {
                                                  isLoading = false;
                                                  ProjectId = snapshot
                                                      .data[index].id
                                                      .toString();
                                                  print("Meeting Id:" +
                                                      ProjectId!);
                                                  */ /*  Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MeetingReporting(
                                                                  ProjectId:
                                                                      ProjectId!,
                                                                )));*/ /*
                                                },
                                                child: Text("Add/Edit Report")),
                                          ),
                                      ],
                                    ),*/
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          /* crossAxisAlignment:
                                              CrossAxisAlignment.center,*/
                                          children: <Widget>[
                                            Expanded(
                                                child: Container(
                                                  /* width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,*/
                                                  /* margin: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      50),
                                              alignment: Alignment.center,*/
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        foregroundColor: MaterialStateProperty
                                                            .all<Color>(
                                                            Constant
                                                                .color_club_project_theme),
                                                        backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(Constant
                                                            .color_club_project),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                            RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                                side: BorderSide(
                                                                    color: Constant
                                                                        .color_club_project_theme)))),
                                                    onPressed: () {
                                                      String Tag=snapshot.data[index].tag.toString();
                                                      String Title=snapshot.data[index].title.toString();
                                                      String startDate=snapshot.data[index].startDate.toString();
                                                      String EndDate=snapshot.data[index].endDate.toString();
                                                      String ProDesc=snapshot.data[index].description.toString();
                                                      String ProId=snapshot.data[index].id.toString();
                                                      String PresidentName="";
                                                      String PARAM_POJECT="YOUR CLUB PROJECT";
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                          builder: (context) => ProjectViewDetails(Tag: Tag, Title: Title,
                                                              startDate: startDate, EndDate: EndDate, ProDesc: ProDesc, ProId: ProId, PresidentName:
                                                              PresidentName,PARAM_POJECT:PARAM_POJECT)));
                                                      /*MeetingId = snapshot
                                                      .data[index].meetingId
                                                      .toString();
                                                  print("MeetingId:" +
                                                      MeetingId!);

                                                  MeetingDate = dateFormat
                                                      .format(DateTime.parse(
                                                      snapshot.data[index]
                                                          .meetingDate));

                                                  topic = snapshot
                                                      .data[index].topic
                                                      .toString();
                                                  chiefGuest = snapshot
                                                      .data[index].chiefGuest
                                                      .toString();
                                                  PreMeetingNotes = snapshot
                                                      .data[index]
                                                      .preMeetingNotes
                                                      .toString();
                                                  String AttendedBy =
                                                      AccessLevel;
                                                  String TotalComments =
                                                      snapshot.data[index]
                                                          .totalComment;
                                                  String TotalLikes = snapshot
                                                      .data[index].totalLike;
                                                  print("MeetingDate:" +
                                                      MeetingDate!);
                                                  print("topic:" + topic!);
                                                  print("chiefGuest:" +
                                                      chiefGuest!);
                                                  print("PreMeetingNotes:" +
                                                      PreMeetingNotes!);
                                                  print(
                                                      "ClubName:" + ClubName!);

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => MeetingDetails(
                                                              MeetingId:
                                                              MeetingId!,
                                                              MeetingDate:
                                                              MeetingDate!,
                                                              topic: topic!,
                                                              chiefGuest:
                                                              chiefGuest!,
                                                              PreMeetingNotes:
                                                              PreMeetingNotes!,
                                                              ClubName:
                                                              ClubName!,
                                                              AttendedBy:
                                                              AttendedBy,
                                                              TotalLikes:
                                                              TotalLikes,
                                                              TotalComments:
                                                              TotalComments,
                                                              ClubId: ClubId)));*/
                                                    },
                                                    child: Text("View Details"),
                                                  ),
                                                )),
                                            if (AccessLevel == "President" ||
                                                AccessLevel == "Secretary" ||
                                                AccessLevel == "IT Office")
                                              if ((DateTime.parse(snapshot
                                                  .data[index]
                                                  .startDate) ==
                                                  DateTime.now()) ||
                                                  ((DateTime.parse(snapshot
                                                      .data[index]
                                                      .endDate) ==
                                                      DateTime.now())) ||
                                                  DateTime.now().isAfter(
                                                      DateTime.parse(snapshot
                                                          .data[index]
                                                          .startDate))
                                                  ||
                                                  (DateTime.now()).isBefore(
                                                      DateTime.parse(snapshot
                                                          .data[index]
                                                          .endDate)) ||
                                                  snapshot.data[index]
                                                      .approveStatus ==
                                                      "Publish")
                                                Expanded(
                                                    child: Container(
                                                      /* width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,*/
                                                      /*  margin: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      50),
                                              alignment: Alignment.center,*/
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                              foregroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                  Constant
                                                                      .color_club_project_theme),
                                                              backgroundColor: MaterialStateProperty
                                                                  .all<Color>(
                                                                  Constant
                                                                      .color_club_project),
                                                              shape: MaterialStateProperty
                                                                  .all<
                                                                  RoundedRectangleBorder>(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius
                                                                          .zero,
                                                                      side: BorderSide(
                                                                          color: Constant
                                                                              .color_club_project_theme)))),
                                                          onPressed: () {
                                                            /*  isLoading = false;
                                                        ProjectId = snapshot
                                                            .data[index].id
                                                            .toString();
                                                        print("Project Id:" +
                                                            ProjectId!);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ProjectReport(
                                                                      ProjectId:
                                                                      ProjectId!,
                                                                    )));*/
                                                          },
                                                          child:
                                                          Text(
                                                              "Add/Edit Report")),
                                                    )),
                                          ],
                                        ),
                                        /*if (snapshot.data[index].memberAttending ==
                                        "")
                                      setAttendace(
                                          snapshot.data[index].meetingDate,
                                          snapshot.data[index].memberAttending
                                              .toString(),
                                          snapshot.data[index].meetingId
                                              .toString(),
                                          snapshot.data[index].approveStatus
                                              .toString()),*/
                                        if (snapshot.data[index]
                                            .memberAttending ==
                                            "Attending") /*&&
                                        (DateTime.parse(snapshot
                                                .data[index].meetingDate)
                                            .isAfter(DateTime.now())))*/
                                          Container(
                                            margin: margin_for_text,
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    child: Icon(
                                                      Icons.done,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  Container(
                                                    // margin: margin_for_text,
                                                      child: Text(" ")),
                                                  Text(
                                                    "You are attending",
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  )
                                                ]),
                                          ),
                                        if (snapshot.data[index]
                                            .memberAttending ==
                                            "Attending")
                                          Container(
                                            margin: margin_for_text,
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    child: Icon(
                                                      Icons.done,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  Container(
                                                    // margin: margin_for_text,
                                                      child: Text(" ")),
                                                  Text(
                                                    "You attended meeting",
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  )
                                                ]),
                                          ),
                                        Container(
                                            decoration: BoxDecoration(
                                              color:
                                              Constant.color_club_project_theme,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                      10),
                                                  bottomRight: Radius.circular(
                                                      10)),
                                            ),
                                            height:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .height /
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
                                                        "Comment        |",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      ProjectId =
                                                          snapshot.data[index]
                                                              .id;
                                                      AttendedBy = AccessLevel;
                                                      showAlertDialog(context);
                                                    }),
                                                /* Container(
                                        child: Text(
                                          "|",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),*/
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: MediaQuery
                                                            .of(context)
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
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: <Widget>[
                                                          Expanded(
                                                              child: Container(
                                                                // margin: EdgeInsets.only(top: MediaQuery.of(context).size.width/90),
                                                                child: SvgPicture
                                                                    .asset(
                                                                  "assets/images/Icon ionic-ios-thumbs-up.svg",
                                                                  // height: MediaQuery.of(context).size.height/40,
                                                                  //width: MediaQuery.of(context).size.width/50,
                                                                ),
                                                              )),
                                                          Expanded(
                                                              child: Container(
                                                                  child: Text(
                                                                    snapshot
                                                                        .data[index]
                                                                        .totalLike,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height /
                                                                            70),
                                                                  )))
                                                        ])),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: MediaQuery
                                                            .of(context)
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
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: <Widget>[
                                                          Expanded(
                                                              child: Container(
                                                                // margin: EdgeInsets.only(top: MediaQuery.of(context).size.width/90),
                                                                child: SvgPicture
                                                                    .asset(
                                                                  "assets/images/comment_icon.svg",
                                                                  // height: MediaQuery.of(context).size.height/40,
                                                                  //width: MediaQuery.of(context).size.width/50,
                                                                ),
                                                              )),
                                                          Expanded(
                                                              child: Container(
                                                                  child: Text(
                                                                    snapshot
                                                                        .data[index]
                                                                        .totalComment,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: MediaQuery
                                                                            .of(
                                                                            context)
                                                                            .size
                                                                            .height /
                                                                            70),
                                                                  )))
                                                        ])),
                                                /* Container(
                                                child: SvgPicture.asset(
                                                    "assets/images/comment_icon.svg"),
                                              ),*/
                                                if (snapshot
                                                    .data[index].memberLike ==
                                                    "1")
                                                  IconButton(
                                                    icon: SvgPicture.asset(
                                                      "assets/images/Icon awesome-heart.svg",
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        /* ProjectId = snapshot
                                                          .data[index].id;
                                                      AttendedBy = AccessLevel;
                                                      PLike = "1";
                                                      addlike();*/
                                                        /*  if(_iconColor==Colors.white){
                                                        _iconColor=Colors.red;}
                                                      else{
                                                        _iconColor=Colors.white;
                                                      }*/
                                                      });
                                                    },
                                                  ),
                                                if (snapshot
                                                    .data[index].memberLike ==
                                                    "0")
                                                  IconButton(
                                                    icon: SvgPicture.asset(
                                                      "assets/images/Icon awesome-heart.svg",
                                                      color: _iconColor,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        ProjectId =
                                                            snapshot.data[index]
                                                                .id;
                                                        AttendedBy =
                                                            AccessLevel;
                                                        PLike = "1";
                                                        addlike();
                                                        /*  if(_iconColor==Colors.white){
                                                        _iconColor=Colors.red;}
                                                      else{
                                                        _iconColor=Colors.white;
                                                      }*/
                                                      });
                                                    },
                                                  ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ]))));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
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
              PComments = _comment.toString();
              print("PComments:" + PComments!);
              if (_comment != null) {
                print("_comment:" + PComments!);
                AddComment();
              } else {
                Constant.displayToast("Please add Comment");
              }
            },
            child: Text("Save")),
        TextButton(onPressed: () {}, child: Text("Cancel")),
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

  getDateformat() {
    DateFormat format = DateFormat("dd.MM.yyyy");
    String date = "2023-06-13";
    print(format.parse(date));
    return (format.parse(date));
  }

  isAttending() async {
    // if (this._formKey.currentState!.validate()) {
    String con = await Constant().checkConnectivity();
    if (con != '') {
      setState(() {
        isLoading = true;
      });
      MeetingAttendance_repo()
          .postdataforProject(
          MemberId, ClubName, PAttending, ProjectId!, AttendedBy!, ClubId)
      //.postdata(MemberId, ClubName, PAttending, ProjectId!, AttendedBy!, ClubId)
          .then((result) {
        //AddMeeting_repo().postdata(dropdownvalue,dropdownvaluefortag,meetingDate,ProjectId,).then((result) {
        if (result != null) {
          setState(() {
            print("msg:" + result.response.toString());
            Constant.displayToast(" " + result.response.toString());
          });
        } else {
          setState(() {
            isLoading = false;
            Constant.displayToast("received invalid response");
          });
        }
      });
    }
    //upload(File(imageFile));
    else {
      Constant.displayToast("Please check your internet connection..!");
    }
  }

  AddComment() async {
    String con = await Constant().checkConnectivity();
    if (con != '') {
      setState(() {
        isLoading = true;
      });
      AddComment_repo()
          .addCommentforProject(
          MemberId, ClubName, PComments!, ProjectId!, AttendedBy!, ClubId)
      //.addComment(MemberId, ClubName, PComments!, ProjectId!, AttendedBy!, ClubId)
          .then((result) {
        if (result != null) {
          setState(() {
            print("msg:" + result.response.toString());
            Constant.displayToast("" + result.response.toString());
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

  addlike() async {
    String con = await Constant().checkConnectivity();
    if (con != '') {
      setState(() {
        isLoading = true;
      });
      AddLike_repo()
          .addlikeforProject(
          MemberId, ClubName, PLike!, ProjectId!, AttendedBy!, ClubId)
      //.addlike(MemberId, ClubName, PLike!, ProjectId!, AttendedBy!, ClubId)
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

  setAttendace(String? date, String memberAttending, String meetingId,
      String approvalstatus) {
    DateTime meetingdate = DateTime.parse(date.toString());
    DateTime currentDate = DateTime.now();
    print("currentdate:" + currentDate.toString());

    if (meetingdate.isAfter(currentDate) || meetingdate == currentDate) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            // alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Constant.color_club_project_theme),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                              color: Constant.color_club_project_theme)))),
              onPressed: () {
                ProjectId = ProjectId;

                if (AccessLevel == "Spouse") {
                  AttendedBy = AccessLevel;
                } else {
                  AttendedBy = "Member";
                }
                print("ProjectId:" + ProjectId.toString());
                isAttending();
              },
              child: Text("ATTENDING"),
            ),
          ),
          Expanded(
            //alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Constant.color_club_project_theme),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                              color: Constant.color_club_project_theme)))),
              onPressed: () {},
              child: Text("NOT NOW"),
            ),
          )
        ],
      );
    } else if (meetingdate.isBefore(currentDate)) {
      return Container(
          child: Text(
            "You did not responded for the meeting",
            style: TextStyle(color: Colors.red),
          ));
    } else {
      return Container(
          child: Text(
            "You did not responded for the meeting",
            style: TextStyle(color: Colors.red),
          ));
    }
  }
}
