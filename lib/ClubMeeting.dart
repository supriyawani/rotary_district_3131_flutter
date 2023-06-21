import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rotary_district_3131_flutter/AddMeeting.dart';
import 'package:rotary_district_3131_flutter/MeetingDetails.dart';
import 'package:rotary_district_3131_flutter/MeetingReporting.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/MeetingListResponse.dart';
import 'package:rotary_district_3131_flutter/repository/AddComment_repo.dart';
import 'package:rotary_district_3131_flutter/repository/AddLike_repo.dart';
import 'package:rotary_district_3131_flutter/repository/MeetingAttendance_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClubMeeting extends StatefulWidget {
  String ClubName;
  String AccessLevel;
  String MemberId;
  String ClubId;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ClubMeeting({
    required this.ClubName,
    required this.AccessLevel,
    required this.MemberId,
    required this.ClubId,
  });

  @override
  _ClubMeetingState createState() =>
      _ClubMeetingState(ClubName, AccessLevel, MemberId, ClubId);
}

class _ClubMeetingState extends State<ClubMeeting> {
  String ClubName = "";
  String AccessLevel = "";
  String MemberId = "";
  String ClubId = "";
  var Date;

  DateFormat dateFormat = DateFormat("dd MMMM yyyy, EEEE");

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isLoading = false;

  String? MeetingId;
  String? MeetingDate, topic, chiefGuest, PreMeetingNotes;
  String? AttendedBy;
  String MAttending = "Attending";

  String? MComments;
  String? MLike;

  String? _comment;
  final _formKey = GlobalKey<FormState>();
  String? date;

  Color _iconColor = Colors.white;

  _ClubMeetingState(ClubName, AccessLevel, MemberId, ClubId) {
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
    var height = MediaQuery.of(context).size.height / 20;
    //margin: EdgeInsets.all(10),
    var margin_for_text = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 15,
    );
    var margin_for_icon = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 15,
      right: MediaQuery.of(context).size.width / 15,
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Constant.color_theme,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text("Club Meeting",
            style: TextStyle(
                color: Constant.color_theme, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddMeeting(
                          ClubId: ClubId, AccessLevel: AccessLevel)));
            },
            icon: Container(
                //width: MediaQuery.of(context).size.width / 5,
                // color: Constant.color_theme,
                child: Icon(
              Icons.add,
              color: Constant.color_theme,
              size: MediaQuery.of(context).devicePixelRatio * 15,
            )),
          ),
        ],
      ),
      body: FutureBuilder<dynamic>(
          future: ClubMeeting_repo()
              .getMeetinglist(ClubId, ClubName, AccessLevel, MemberId),
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
                      title: Container(
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 1,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  margin: EdgeInsets.all(
                                      MediaQuery.of(context).size.width / 80),

                                  //   getDateformat();

                                  child: Text(
                                    dateFormat.format(DateTime.parse(
                                        snapshot.data[index].meetingDate)),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Constant.color_theme,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      if (snapshot.data[index].approveStatus ==
                                          "Draft")
                                        Container(
                                          margin: margin_for_text,
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Pending for President approval",
                                            style: TextStyle(color: Colors.red),
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
                                      Row(
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
                                      ),
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
                                                  .data[index].memberAttending,
                                              style: TextStyle(),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            /* width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,*/
                                            margin: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    50),
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  //primary: Color(0xffdd1a27),
                                                  onPrimary:
                                                      Constant.color_theme,
                                                  backgroundColor: Colors.white
                                                  // foreground
                                                  ),
                                              onPressed: () {
                                                MeetingId = snapshot
                                                    .data[index].meetingId
                                                    .toString();
                                                print(
                                                    "MeetingId:" + MeetingId!);

                                                MeetingDate = dateFormat.format(
                                                    DateTime.parse(snapshot
                                                        .data[index]
                                                        .meetingDate));

                                                topic = snapshot
                                                    .data[index].topic
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
                                                print("chiefGuest:" +
                                                    chiefGuest!);
                                                print("PreMeetingNotes:" +
                                                    PreMeetingNotes!);
                                                print("ClubName:" + ClubName!);

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MeetingDetails(
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
                                                                ClubId:
                                                                    ClubId)));
                                              },
                                              child: Text("View Details"),
                                            ),
                                          ),
                                          if (AccessLevel == "President" ||
                                              AccessLevel == "Secretary" ||
                                              AccessLevel == "IT Office")
                                            if (DateTime.parse(snapshot
                                                        .data[index]
                                                        .meetingDate)
                                                    .isAfter(DateTime.now()) ||
                                                snapshot.data[index]
                                                        .approveStatus ==
                                                    "Publish")
                                              Container(
                                                /* width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,*/
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            50),
                                                alignment: Alignment.center,
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            //primary: Color(0xffdd1a27),
                                                            onPrimary: Constant
                                                                .color_theme,
                                                            backgroundColor:
                                                                Colors.white
                                                            // foreground
                                                            ),
                                                    onPressed: () {
                                                      isLoading = false;
                                                      MeetingId = snapshot
                                                          .data[index].meetingId
                                                          .toString();
                                                      print("Meeting Id:" +
                                                          MeetingId!);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MeetingReporting(
                                                                    MeetingId:
                                                                        MeetingId!,
                                                                  )));
                                                    },
                                                    child: Text(
                                                        "Add/Edit Report")),
                                              ),
                                        ],
                                      ),
                                      if (snapshot
                                              .data[index].memberAttending ==
                                          "")
                                        setAttendace(
                                            snapshot.data[index].meetingDate,
                                            snapshot.data[index].memberAttending
                                                .toString(),
                                            snapshot.data[index].meetingId
                                                .toString(),
                                            snapshot.data[index].approveStatus
                                                .toString()),
                                      if (snapshot.data[index]
                                                  .memberAttending ==
                                              "Attending" &&
                                          (DateTime.parse(snapshot
                                                  .data[index].meetingDate)
                                              .isAfter(DateTime.now())))
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
                                              "Attending" &&
                                          (DateTime.parse(snapshot
                                                  .data[index].meetingDate)
                                              .isBefore(DateTime.now())))
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
                                      /*Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                // alignment: Alignment.center,
                                                child: ElevatedButton(
                                                  */ /* style: ElevatedButton.styleFrom(
                                                //primary: Color(0xffdd1a27),
                                                onPrimary: Constant.color_theme,
                                                backgroundColor: Colors.white,
                                                side: const BorderSide(
                                                  //width: 5.0,
                                                  color: Constant.color_theme,
                                                ),
                                                borderRadius: BorderRadius.zero,
                                                // foreground
                                              ),*/ /*
                                                  style: ButtonStyle(
                                                      foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                          Constant.color_theme),
                                                      backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                          Colors.white),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                          RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.zero,
                                                              side: BorderSide(
                                                                  color: Constant
                                                                      .color_theme)))),
                                                  onPressed: () {
                                                    MeetingId =
                                                        snapshot.data[index]
                                                            .meetingId;

                                                    if (AccessLevel ==
                                                        "Spouse") {
                                                      AttendedBy = AccessLevel;
                                                    }
                                                    else {
                                                      AttendedBy = "Member";
                                                    }
                                                    print("MettingId:" +
                                                        MeetingId.toString());
                                                    isAttending();
                                                  },
                                                  child: Text("ATTENDING"),
                                                ),
                                              ),
                                              Expanded(
                                                //alignment: Alignment.center,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                          Constant.color_theme),
                                                      backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                          Colors.white),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                          RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.zero,
                                                              side: BorderSide(
                                                                  color: Constant
                                                                      .color_theme)))),
                                                  onPressed: () {},
                                                  child: Text("NOT NOW"),
                                                ),
                                              )
                                            ],
                                          ),*/

                                      Container(
                                          decoration: BoxDecoration(
                                            color: Constant.color_theme,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          height: MediaQuery.of(context)
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
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    MeetingId = snapshot
                                                        .data[index].meetingId;
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
                                                      top:
                                                          MediaQuery.of(context)
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
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/Icon ionic-ios-thumbs-up.svg",
                                                            // height: MediaQuery.of(context).size.height/40,
                                                            //width: MediaQuery.of(context).size.width/50,
                                                          ),
                                                        )),
                                                        Expanded(
                                                            child: Container(
                                                                child: Text(
                                                          snapshot.data[index]
                                                              .totalLike,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  70),
                                                        )))
                                                      ])),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(context)
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
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/comment_icon.svg",
                                                            // height: MediaQuery.of(context).size.height/40,
                                                            //width: MediaQuery.of(context).size.width/50,
                                                          ),
                                                        )),
                                                        Expanded(
                                                            child: Container(
                                                                child: Text(
                                                          snapshot.data[index]
                                                              .totalComment,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: MediaQuery.of(
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
                                                      /* MeetingId = snapshot
                                                          .data[index].meetingId;
                                                      AttendedBy = AccessLevel;
                                                      MLike = "1";
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
                                                      MeetingId = snapshot
                                                          .data[index]
                                                          .meetingId;
                                                      AttendedBy = AccessLevel;
                                                      MLike = "1";
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
          }),
    );
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
          .postdata(
              MemberId, ClubName, MAttending, MeetingId!, AttendedBy!, ClubId)
          .then((result) {
        //AddMeeting_repo().postdata(dropdownvalue,dropdownvaluefortag,meetingDate,meetingId,).then((result) {
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
          .addComment(
              MemberId, ClubName, MComments!, MeetingId!, AttendedBy!, ClubId)
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
          .addlike(MemberId, ClubName, MLike!, MeetingId!, AttendedBy!, ClubId)
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
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Constant.color_theme),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Constant.color_theme)))),
              onPressed: () {
                MeetingId = meetingId;

                if (AccessLevel == "Spouse") {
                  AttendedBy = AccessLevel;
                } else {
                  AttendedBy = "Member";
                }
                print("MettingId:" + MeetingId.toString());
                isAttending();
              },
              child: Text("ATTENDING"),
            ),
          ),
          Expanded(
            //alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Constant.color_theme),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Constant.color_theme)))),
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

class ClubMeeting_repo {
  Future<List<MeetingListResponse?>> getMeetinglist(String ClubId,
      String ClubName, String AttendedBy, String MemberId) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubMeetingNewApprove.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSClubMeetingNewApprove.php'));
    request.bodyFields = {
      'ClubId': ClubId,
      'ClubName': ClubName,
      'AttendedBy': AttendedBy,
      'MemberId': MemberId
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    print(json.decode(res));
    List<MeetingListResponse?> result;
    if (jsonData != null) {
      // LoginResult userData = LoginResult.fromJson(json.decode(res));
      final List t = json.decode(res);

      final List<MeetingListResponse> userList =
          t.map((item) => MeetingListResponse.fromJson(item)).toList();
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
