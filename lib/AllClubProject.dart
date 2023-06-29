import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rotary_district_3131_flutter/ProjectViewDetails.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/repository/ClubProjectListrepo.dart';
import 'package:sizer/sizer.dart';

class AllClubProject extends StatefulWidget {
  @override
  _AllClubProjectState createState() => _AllClubProjectState();
}

class _AllClubProjectState extends State<AllClubProject> {
  var isLoading = false;
  var Date;

  DateFormat dateFormat = DateFormat("dd MMMM yyyy, EEEE");
  String ClubName = "";

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
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
      left: MediaQuery.of(context).size.width / 15,
      //bottom: MediaQuery.of(context).size.width / 25,
    );
    var margin_for_icon = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 15,
      right: MediaQuery.of(context).size.width / 15,
    );
    return FutureBuilder<dynamic>(
        future: ClubProjectList_repo().getAllClubProjectlist(ClubName),
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
                                height: MediaQuery.of(context).size.height / 20,
                                margin: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 80),

                                //   getDateformat();

                                child: Text(
                                  dateFormat.format(DateTime.parse(
                                      snapshot.data[index].startDate)),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.height /
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
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.only(bottom: 4.sp),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: Container(
                                              margin: margin_for_text,
                                              child: Text(
                                                "Club Name:  ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: Text(
                                                snapshot.data[index].clubName,
                                                style: TextStyle(),
                                              ),
                                            ))
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 4.sp),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: Container(
                                              margin: margin_for_text,
                                              child: Text(
                                                "Title:  ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: Text(
                                                snapshot.data[index].title,
                                                style: TextStyle(),
                                              ),
                                            ))
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 4.sp),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                  margin: margin_for_text,
                                                  child: Text(
                                                    "President Name:",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )),
                                            ),
                                            Expanded(
                                                child: Container(
                                              child: Text(
                                                snapshot.data[index].firstName +
                                                    " " +
                                                    snapshot
                                                        .data[index].lastName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(),
                                              ),
                                            ))
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 6.sp),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: Container(
                                              margin: margin_for_text,
                                              child: Text(
                                                "Project Description:",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: Text(
                                                snapshot
                                                    .data[index].description,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(),
                                              ),
                                            ))
                                          ],
                                        )),
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
                                            onPrimary: Constant
                                                .color_club_project_theme,
                                            backgroundColor: Colors.white
                                            // foreground
                                            ),
                                        onPressed: () {
                                          String Tag = snapshot.data[index].tag
                                              .toString();
                                          String Title = snapshot
                                              .data[index].title
                                              .toString();
                                          String startDate = snapshot
                                              .data[index].startDate
                                              .toString();
                                          String EndDate = snapshot
                                              .data[index].endDate
                                              .toString();
                                          String ProDesc = snapshot
                                              .data[index].description
                                              .toString();
                                          String ProId = snapshot.data[index].id
                                              .toString();
                                          String PresidentName =
                                              snapshot.data[index].firstName +
                                                  " " +
                                                  snapshot.data[index].lastName;
                                          String Desc = snapshot
                                              .data[index].description
                                              .toString();
                                          String PARAM_POJECT =
                                              "ALL CLUB PROJECT";
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProjectViewDetails(
                                                          Tag: Tag,
                                                          Title: Title,
                                                          startDate: startDate,
                                                          EndDate: EndDate,
                                                          ProDesc: ProDesc,
                                                          ProId: ProId,
                                                          PresidentName:
                                                              PresidentName,
                                                          PARAM_POJECT:
                                                              PARAM_POJECT)));
                                        },
                                        child: Text("View Details"),
                                      ),
                                    ),
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
}
