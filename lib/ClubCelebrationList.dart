import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/club_celebration_response.dart';

class ClubCelebrationList extends StatefulWidget {
  String clubName = "Pen";

  @override
  _ClubCelebrationListState createState() => _ClubCelebrationListState();
}

class _ClubCelebrationListState extends State<ClubCelebrationList> {
  String clubName = "Pen";
  var isLoading = false;

  String Birthday = "";
  String weddingday = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Constant.color_theme,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text("Club Celebration",
              style: TextStyle(
                  color: Constant.color_theme, fontWeight: FontWeight.bold))),
      body: FutureBuilder<List<ClubCelebrationResponse>>(
          future: ClubCelebration_repo().getData(clubName),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              // return listViewWidget(snapshot.data);
              return Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 50),
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      padding: const EdgeInsets.all(2.0),
                      itemBuilder: (context, position) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 50,
                                  left: MediaQuery.of(context).size.width / 30,
                                ),
                                child:
                                    Text('${snapshot.data![position]?.month}')),
                            ListView.builder(
                                itemCount: snapshot.data![position]?.jan.length,
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 5,
                                    margin: EdgeInsets.all(20),
                                    child: Container(
                                        //height: 100,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                8,
                                        //margin: EdgeInsets.all(20),
                                        // margin: EdgeInsets.only(left: 20),
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            if (snapshot.data![position]
                                                    .jan[index].userPhoto !=
                                                null)
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    14,
                                                // margin: EdgeInsets.only(left: 15),
                                                alignment: Alignment.center,
                                                /*  child: SvgPicture.asset(
                                              "assets/images/Group 60.svg"),*/
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          Constant.BASE_PATH +
                                                              snapshot
                                                                  .data![
                                                                      position]!
                                                                  .jan[index]
                                                                  .userPhoto),
                                                      // fit: BoxFit.cover,
                                                    )),
                                              ),
                                            /* if (snapshot.data![position].jan[index]
                                                .userPhoto ==
                                            "")
                                          Container(
                                            // margin: EdgeInsets.only(left: 15),
                                            alignment: Alignment.topLeft,
                                            */ /*  child: SvgPicture.asset(
                                              "assets/images/Group 60.svg"),*/ /*
                                            child: SvgPicture.asset(
                                              "assets/images/Group 60.svg",
                                            ),
                                            // fit: BoxFit.cover,
                                          ),*/
                                            Container(
                                              //  margin: EdgeInsets.only(top: 5, left: 5),
                                              margin: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10),
                                              alignment: Alignment.center,
                                              child: Column(
                                                //  mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      // snapshot.data[index].toString()
                                                      '${snapshot.data![position]?.jan[index].firstName}',
                                                    ),
                                                  ),
                                                  Container(
                                                    // margin: EdgeInsets.all(10),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.phone),
                                                        Text(
                                                            //   snapshot.data[index].toString()
                                                            '${snapshot.data![position]?.jan[index].mobile}')
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    //margin: EdgeInsets.all(5),

                                                    child: Row(
                                                      children: <Widget>[
                                                        SvgPicture.asset(
                                                            "assets/images/Group 45.svg"),
                                                        Text(
                                                            '${snapshot.data![position]?.jan[index].birthDate}')
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            16,
                                                    child: SvgPicture.asset(
                                                      "assets/images/Phone_icon.svg",
                                                      fit: BoxFit.scaleDown,
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 5,
                                                            color: Color(
                                                                0xFF147BB8)),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        15)),
                                                        color:
                                                            Color(0xFF147BB8)),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      8,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      16,
                                                  child: SvgPicture.asset(
                                                    "assets/images/whats_app_icon.svg",
                                                    fit: BoxFit.scaleDown,
                                                    alignment: Alignment.center,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 5,
                                                          color: Color(
                                                              0xFF14b844)),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                      color: Color(0xFF14b844)),
                                                )),
                                              ],
                                            )
                                          ],
                                        )),
                                  );
                                }),
                          ],
                        );

                        /*return Card(
                        child: ListTile(
                            title: Text(
                      //'${data?[position].firstName}',
                      //  snapshot.data?[position].firstName,
                      '${snapshot.data![position]?.month}',
                      // '${data?[position].firstName}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )));*/
                        /* */
                      }));
            } else {
              return Center(child: CircularProgressIndicator());
              //return Constant.displayToast("avg");
            }
          }),
    );
  }

  /* Widget listViewWidget(List<Jan>? data) {
    return Container(
        child: ListView.builder(
            itemCount: 5,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (context, position) {
              return Card(
                  child: ListTile(
                      title: Text(
                '${data?[position].firstName}',
                // data[position].firstName!,
                // '${data?[position].firstName}',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )));
            }));
  }*/
}

class ClubCelebration_repo {
  Future<List<ClubCelebrationResponse>> getData(String clubName) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSBirthWeddingDayNew.php');
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'iOSBirthWeddingDayNew.php'));
    request.bodyFields = {
      'clubName': "Pune Sahyadri",
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    var jsonData = json.decode(res);
    //print("result:" + json.decode(res));
    List<ClubCelebrationResponse> result = [];
    if (jsonData != null) {
      //var data = json.decode(request.body);
      try {
        // var todayRes = jsonData['Today'] as List;

        // List<Map<String, dynamic>> celebrations = [];
        /*  celebrations[0] = jsonData['Today'];
        celebrations[1] = jsonData['Tomorrow'];
        celebrations[2] = jsonData['Rest'];
        celebrations[3] = jsonData['Jan'];
        celebrations[4] = jsonData['June'];*/

        var restRes = jsonData['Rest'] as List;
        var janRes = jsonData['Jan'] as List;
        var febRes = jsonData['Feb'] as List;
        var marRes = jsonData['March'] as List;
        var aprRes = jsonData['April'] as List;
        var mayRes = jsonData['May'] as List;
        var junRes = jsonData['June'] as List;
        var julRes = jsonData['July'] as List;
        var augRes = jsonData['Aug'] as List;
        var septRes = jsonData['Sept'] as List;
        var octRes = jsonData['Oct'] as List;
        var novRes = jsonData['Nov'] as List;
        var decRes = jsonData['Dec'] as List;

/*        result.insert(
            0,
            ClubCelebrationResponse(
                month: "Today",
                jan: janRes.map((item) => Jan.fromJson(item)).toList()));*/
        /*  if (todayRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "Today",
              jan: restRes.map((item) => Jan.fromJson(item)).toList()));
        }
        if (tomRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "Tomorrow",
              jan: restRes.map((item) => Jan.fromJson(item)).toList()));
        }*/

        /*DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);
        int currentmonth = now.month;
        print(now.month);
        //int currentmonth = 6;
        int i = currentmonth;
        int cntr = 0;
        while (cntr < 12) {
          // Log.i(TAG, "Cntr::" + cntr);
          if (i > 11) {
            i = 0;
          }
          if (null != celebrations) {
            String a = currentmonth as String;
            print("currentmonth: " + a);
            // currentmonth=jsonData[''];
          }
        }*/

        if (restRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "This Month",
              jan: restRes.map((item) => Jan.fromJson(item)).toList()));
        }

        if (janRes.length > 0) {
          result.add(ClubCelebrationResponse(
              month: "January",
              jan: janRes.map((item) => Jan.fromJson(item)).toList()));
        }

        if (febRes.length > 0) {
          result.add(ClubCelebrationResponse(
              month: "February",
              jan: febRes.map((item) => Jan.fromJson(item)).toList()));
        }
        if (marRes.length > 0) {
          result.add(ClubCelebrationResponse(
              month: "March",
              jan: marRes.map((item) => Jan.fromJson(item)).toList()));
        }
        if (aprRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "April",
              jan: aprRes.map((item) => Jan.fromJson(item)).toList()));
        }
        if (mayRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "May",
              jan: mayRes.map((item) => Jan.fromJson(item)).toList()));
        }
        if (junRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "Jun",
              jan: junRes.map((item) => Jan.fromJson(item)).toList()));
        }
        if (julRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "July",
              jan: julRes.map((item) => Jan.fromJson(item)).toList()));
        }
        if (augRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "August",
              jan: augRes.map((item) => Jan.fromJson(item)).toList()));
        }
        if (septRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "September",
              jan: septRes.map((item) => Jan.fromJson(item)).toList()));
        }

        if (octRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "October",
              jan: octRes.map((item) => Jan.fromJson(item)).toList()));
        }
        if (novRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "November",
              jan: novRes.map((item) => Jan.fromJson(item)).toList()));
        }
        if (decRes.isNotEmpty) {
          result.add(ClubCelebrationResponse(
              month: "December",
              jan: decRes.map((item) => Jan.fromJson(item)).toList()));
        }

/*        result.addAll(janRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(febRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(marRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(aprRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(mayRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(junRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(julRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(augRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(septRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(octRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(novRes.map((item) => Jan.fromJson(item)).toList());
        result.addAll(decRes.map((item) => Jan.fromJson(item)).toList());*/

        // result = janRes.map<Jan>((json) => Jan.fromJson(json)).toList();
        print("List Size: ${result.length}");

        result;
      } catch (e) {
        print(e);
      }
    } else {
      result = List.empty();
    }

    return result;
  }
}
