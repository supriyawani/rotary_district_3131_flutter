import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/repository/MeetingAttendingList_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeetingDetails extends StatefulWidget {
  String MeetingId, MeetingDate, topic, chiefGuest, PreMeetingNotes;
  String ClubName, AttendedBy, TotalLikes, TotalComments, ClubId;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  MeetingDetails({
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
  });

  @override
  _MeetingDetailsState createState() => _MeetingDetailsState(
      MeetingId,
      MeetingDate,
      topic,
      chiefGuest,
      PreMeetingNotes,
      ClubName,
      AttendedBy,
      TotalLikes,
      TotalComments,
      ClubId);
}

class _MeetingDetailsState extends State<MeetingDetails> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false;
  String? MeetingId;
  String? MeetingDate;
  String? topic;
  String? chiefGuest;
  String? PreMeetingNotes;
  String? ClubName;
  String? AttendedBy, TotalLikes, TotalComments, ClubId;

  //String? MeetingId;
  _MeetingDetailsState(
      String MeetingId,
      String MeetingDate,
      String topic,
      String chiefGuest,
      String PreMeetingNotes,
      String ClubName,
      String AttendedBy,
      String TotalLikes,
      String TotalComments,
      String ClubId) {
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
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _prefs.then((SharedPreferences prefs) async {
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
    });
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

    return Scaffold(
        appBar: AppBar(
            leading: BackButton(
              color: Constant.color_theme,
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            title: Text("Club Meeting",
                style: TextStyle(
                    color: Constant.color_theme, fontWeight: FontWeight.bold))),
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.width / 90),
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
                                    margin: margin_for_text,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Club Name:  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5),
                                        Container(
                                          // margin: margin_for_text,
                                          child: Text(
                                            ClubName!,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25),
                                          ),
                                        )
                                      ],
                                    )),
                                Container(
                                    margin: margin_for_text,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          //  margin: margin_for_text,
                                          child: Text(
                                            "Topic:  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3),
                                        Container(
                                          // margin: margin_for_text,
                                          child: Text(
                                            topic!,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25),
                                          ),
                                        )
                                      ],
                                    )),
                                Container(
                                    margin: margin_for_text,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          //  margin: margin_for_text,
                                          child: Text(
                                            "ChiefGuest:  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.5),
                                        Container(
                                          // margin: margin_for_text,
                                          child: Text(
                                            chiefGuest!,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25),
                                          ),
                                        )
                                      ],
                                    )),
                                Container(
                                    margin: margin_for_text,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          //  margin: margin_for_text,
                                          child: Text(
                                            "PreMeetingNotes:  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25),
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8),
                                        Container(
                                          // margin: margin_for_text,
                                          child: Text(
                                            PreMeetingNotes!,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25),
                                          ),
                                        )
                                      ],
                                    )),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Constant.color_theme,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    height:
                                        MediaQuery.of(context).size.height / 17,
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
                                            onTap: () {}),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    90),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
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
                                                mainAxisSize: MainAxisSize.min,
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
                                        IconButton(
                                          icon: SvgPicture.asset(
                                            "assets/images/Icon awesome-heart.svg",
                                          ),
                                          onPressed: () {
                                            setState(() {});
                                          },
                                        ),
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
                      Container(
                        child: FutureBuilder<dynamic>(
                            future: MeetingAttendingList_repo()
                                .getAttendingList(
                                    MeetingId!, AttendedBy!, ClubId!),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasError) {
                                showDialog(
                                  builder: (context) => AlertDialog(
                                    title: Text("Error"),
                                    content: Text(snapshot.error.toString()),
                                  ),
                                  context: context,
                                );
                              } else if (snapshot!.hasData) {
                                return Column(children: <Widget>[
                                  Container(
                                    margin: margin_for_value,
                                    child: Text(
                                      "Attending " +
                                          snapshot.data.length.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length!,
                                      itemBuilder: (context, index) => ListTile(
                                          title: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              elevation: 1,
                                              // margin: EdgeInsets.all(20),
                                              child: Container(
                                                  //height: 100,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      14,
                                                  child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                            backgroundColor:
                                                                Constant
                                                                    .color_theme,
                                                            radius: 26,
                                                            child: CircleAvatar(
                                                                radius: 25.0,
                                                                backgroundImage: NetworkImage(Constant
                                                                        .BASE_PATH +
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .userPhoto),
                                                                backgroundColor:
                                                                    Colors
                                                                        .black12
                                                                // Colors.transparent,
                                                                )),
                                                        Column(
                                                            children: <Widget>[
                                                              Container(
                                                                child: Text(snapshot
                                                                        .data[
                                                                            index]
                                                                        .firstName +
                                                                    " " +
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .lastName),
                                                              ),
                                                              Container(
                                                                  child: Text(snapshot
                                                                          .data[
                                                                              index]
                                                                          .mComments +
                                                                      "(" +
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .attendedBy +
                                                                      ")"))
                                                            ]),
                                                      ])))))
                                ]);
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      )
                    ]))));
  }
}
