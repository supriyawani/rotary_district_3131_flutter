import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/TagList.dart';
import 'package:rotary_district_3131_flutter/repository/AddMeeting_repo.dart';
import 'package:rotary_district_3131_flutter/repository/AgDetails_repo.dart';
import 'package:rotary_district_3131_flutter/repository/MeetingId_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMeeting extends StatefulWidget {
  String ClubId, AccessLevel;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  AddMeeting({
    required this.ClubId,
    required this.AccessLevel,
  });

  @override
  _AddMeetingState createState() => _AddMeetingState(ClubId, AccessLevel);
}

class _AddMeetingState extends State<AddMeeting> {
  var data;
  String ClubId = "";
  String AccessLevel = "";

  String dropdownvalue = 'Select Meeting Type';
  String dropdownvaluefortag = 'Select Tag';
  var isLoading = false;
  //String dropdownvalueforTag = '';

  final _formKey = GlobalKey<FormState>();
  List<TagList> taglist = [];
  String? tagname;
  TextEditingController timeinput = TextEditingController();
  String meetingDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String? _chiefGuest, _meetingAgenda, _topic;
  String? _location = "";
  String? meetingId = "";
  String approvestatus = "Draft";

  //var time = DateFormat('hh:mm:ss').format(DateTime.now());

  // var _taglist = <TagList>[];
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  _AddMeetingState(ClubId, AccessLevel) {
    this.ClubId = ClubId;
    this.AccessLevel = AccessLevel;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeinput.text = "";
    _prefs.then((SharedPreferences prefs) async {
      ClubId = prefs.getString('ClubNumber')!;
      AccessLevel = prefs.getString('AccessLevel')!;
    });
    print("ClubId:" + ClubId);
    print("AccessLevel:" + AccessLevel);
    _loadData();
    //populatedropdropdown();
  }

  void _loadData() async {
    AGDetails_repo().getLocation(ClubId).then((result) {
      if (result != null) {
        setState(() {
          print("result:" + result.toString());
          _location = result.toString();
          print("location:" + _location.toString());
        });

        // saveData(result);
      } else {
        setState(() {
          // Constant.displayToast("please enter valid credentials!");
        });
      }
    });
  }

  populatedropdropdown() async {
    // TagList data = await getTagLIst();
    setState(() {
      taglist = data as List<TagList>;
    });
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = [
      'Select Meeting Type',
      'Regular',
      'BOD',
      'Club Assembly'
    ];
    return ddl
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    var margin_for_text = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 20,
      top: MediaQuery.of(context).size.width / 30,
    );
    var height = MediaQuery.of(context).size.height / 20;
    //margin: EdgeInsets.all(10),

    var margin_for_textformfield = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 20,
      top: MediaQuery.of(context).size.width / 30,
      right: MediaQuery.of(context).size.width / 20,
    );
    var content_padding = EdgeInsets.all(
      MediaQuery.of(context).size.width / 40,
    );
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Constant.color_theme,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text("Add Meeting",
              style: TextStyle(
                  color: Constant.color_theme, fontWeight: FontWeight.bold))),
      body: Card(
          margin: EdgeInsets.all(
            MediaQuery.of(context).size.width / 30,
          ),
          elevation: 5,
          child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.all(
                    MediaQuery.of(context).size.width / 50,
                  ),
                  child: new Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            // margin: EdgeInsets.only(left: 10, bottom: 5),
                            margin: margin_for_text,
                            child: Text(
                              "Select Meeting Type",
                              style: TextStyle(
                                  color: Constant.color_theme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                            margin: margin_for_text,
                            child: DropdownButton(
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: _dropDownItem(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            )),

                        Container(
                            // margin: EdgeInsets.only(left: 10, bottom: 5),
                            margin: margin_for_text,
                            child: Text(
                              "Select Tag",
                              style: TextStyle(
                                  color: Constant.color_theme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )),
                        tagwidget(),

                        Container(
                            // margin: EdgeInsets.only(left: 10, bottom: 5),
                            margin: margin_for_text,
                            child: Text(
                              "Select MeetingDate",
                              style: TextStyle(
                                  color: Constant.color_theme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )),
                        // TagWidget(),
                        meetingwidget(),
                        Container(
                          margin: margin_for_text,
                          child: FutureBuilder<String?>(
                              future: MeetingId_repo().getMeetingId(ClubId),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  showDialog(
                                    builder: (context) => AlertDialog(
                                      title: Text("Error"),
                                      content: Text(snapshot.error.toString()),
                                    ),
                                    context: context,
                                  );
                                } else if (snapshot.hasData) {
                                  meetingId = snapshot.data.toString();
                                  return Container(
                                    child: Text(snapshot.data.toString()),
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ),
                        meetingdeatilswidget(),
                        Container(
                            // margin: EdgeInsets.only(left: 10, bottom: 5),
                            margin: margin_for_text,
                            child: Text(
                              "Meeting Loation",
                              style: TextStyle(
                                  color: Constant.color_theme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          height: height,
                          //margin: EdgeInsets.all(10),
                          margin: margin_for_textformfield,
                          child: TextFormField(
                            initialValue: "" + _location!.toString(),
                            //keyboardType: TextInputType.multiline,
                            //maxLines: 1,
                            style: TextStyle(
                              //fontSize: 15,
                              color: Colors.black,
                            ),
                            key: Key(_location.toString()),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: content_padding),
                            onSaved: (value) {
                              _location = value!.trim();
                              print("_location:" + _location!);
                            },
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'location is required';
                              }
                              _formKey.currentState!.save();
                              return null;
                            },
                          ),
                        ),
                        Container(
                            // margin: EdgeInsets.only(left: 10, bottom: 5),
                            margin: margin_for_text,
                            child: Text(
                              "Topic",
                              style: TextStyle(
                                  color: Constant.color_theme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          height: height,
                          //margin: EdgeInsets.all(10),
                          margin: margin_for_textformfield,
                          child: TextFormField(
                            initialValue: "",
                            style: TextStyle(
                              fontSize: 15,
                              color: Constant.color_theme,
                            ),
                            key: Key("_topic"),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: content_padding),
                            onSaved: (value) {
                              _topic = value!.trim();
                              print("_topic:" + _topic!);
                            },
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'topic is required';
                              }
                              _formKey.currentState!.save();
                              return null;
                            },
                          ),
                        ),
                        Container(
                            // margin: EdgeInsets.only(left: 10, bottom: 5),
                            margin: margin_for_text,
                            child: Text(
                              "Chief Guest",
                              style: TextStyle(
                                  color: Constant.color_theme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          height: height,
                          //margin: EdgeInsets.all(10),
                          margin: margin_for_textformfield,
                          child: TextFormField(
                            initialValue: "",
                            style: TextStyle(
                              fontSize: 15,
                              color: Constant.color_theme,
                            ),
                            key: Key("_chiefGuest"),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: content_padding),
                            onSaved: (value) {
                              _chiefGuest = value!.trim();
                              print("_chiefGuest:" + _chiefGuest!);
                            },
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'chief guest is required';
                              }
                              _formKey.currentState!.save();
                              return null;
                            },
                          ),
                        ),
                        Container(
                            // margin: EdgeInsets.only(left: 10, bottom: 5),
                            margin: margin_for_text,
                            child: Text(
                              "Meeting Agenda",
                              style: TextStyle(
                                  color: Constant.color_theme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          height: height,
                          //margin: EdgeInsets.all(10),
                          margin: margin_for_textformfield,
                          child: TextFormField(
                            initialValue: "",
                            style: TextStyle(
                              fontSize: 15,
                              color: Constant.color_theme,
                            ),
                            key: Key("_meetingAgenda"),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: content_padding),
                            onSaved: (value) {
                              _meetingAgenda = value!.trim();
                              print("_meetingAgenda:" + _meetingAgenda!);
                            },
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Meeting Agenda guest is required';
                              }
                              _formKey.currentState!.save();
                              return null;
                            },
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                // width: MediaQuery.of(context).size.width / 20,
                                margin: margin_for_textformfield,
                                alignment: Alignment.center,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    //saveData();
                                    if (this
                                        ._formKey
                                        .currentState!
                                        .validate()) {
                                      String con =
                                          await Constant().checkConnectivity();
                                      if (con != '') {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        //AddMeeting_repo().postdata(dropdownvalue,dropdownvaluefortag,meetingDate,meetingId,).then((result) {
                                        AddMeeting_repo()
                                            .postdata(
                                                meetingId!,
                                                meetingDate,
                                                dropdownvalue,
                                                _chiefGuest!,
                                                timeinput.text,
                                                dropdownvaluefortag,
                                                _topic!,
                                                _meetingAgenda!,
                                                ClubId,
                                                _location!,
                                                approvestatus)
                                            .then((result) {
                                          if (result != null) {
                                            setState(() {
                                              print("msg:" +
                                                  result.msg.toString());
                                              Constant.displayToast(
                                                  " " + result.msg.toString());
                                              Navigator.of(context).pop();
                                            });
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                              Constant.displayToast(
                                                  "please enter valid credentials!");
                                            });
                                          }
                                        });
                                      }
                                      //upload(File(imageFile));
                                      else {
                                        Constant.displayToast(
                                            "Please check your internet connection..!");
                                      }
                                    } else {
                                      print("_formKey.currentState is null!");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      //primary: Color(0xffdd1a27),
                                      onPrimary: Colors.white,
                                      backgroundColor:
                                          Constant.color_theme // foreground
                                      ),
                                  child: Text("Save"),
                                ),
                              ),
                              if (AccessLevel == "President")
                                Container(
                                  //  width: MediaQuery.of(context).size.width / 20,
                                  margin: margin_for_textformfield,
                                  alignment: Alignment.center,
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      //saveData();
                                      if (this
                                          ._formKey
                                          .currentState!
                                          .validate()) {
                                        String con = await Constant()
                                            .checkConnectivity();
                                        if (con != '') {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          //AddMeeting_repo().postdata(dropdownvalue,dropdownvaluefortag,meetingDate,meetingId,).then((result) {
                                          AddMeeting_repo()
                                              .postdata(
                                                  meetingId!,
                                                  meetingDate,
                                                  dropdownvalue,
                                                  _chiefGuest!,
                                                  timeinput.text,
                                                  dropdownvaluefortag,
                                                  _topic!,
                                                  _meetingAgenda!,
                                                  ClubId,
                                                  _location!,
                                                  "Publish")
                                              .then((result) {
                                            if (result != null) {
                                              setState(() {
                                                print("msg:" +
                                                    result.msg.toString());
                                                Constant.displayToast(" " +
                                                    result.msg.toString());
                                                Navigator.of(context).pop();
                                              });
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                                Constant.displayToast(
                                                    "please enter valid credentials!");
                                              });
                                            }
                                          });
                                        }
                                        //upload(File(imageFile));
                                        else {
                                          Constant.displayToast(
                                              "Please check your internet connection..!");
                                        }
                                      } else {
                                        print("_formKey.currentState is null!");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        //primary: Color(0xffdd1a27),
                                        onPrimary: Colors.white,
                                        backgroundColor:
                                            Constant.color_theme // foreground
                                        ),
                                    child: Text("Approve"),
                                  ),
                                ),
                            ])
                      ],
                    ),
                  )))),
    );
  }

  Widget meetingwidget() {
    var height = MediaQuery.of(context).size.height / 20;
    //margin: EdgeInsets.all(10),

    var margin_for_textformfield = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 20,
      top: MediaQuery.of(context).size.width / 30,
      right: MediaQuery.of(context).size.width / 20,
    );
    var content_padding = EdgeInsets.all(
      MediaQuery.of(context).size.width / 40,
    );
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width * 80,
        height: height,
        //margin: EdgeInsets.all(10),
        margin: margin_for_textformfield,
        child: TextButton.icon(
          style: flatButtonStyle,
          onPressed: () => _selectMeetingDate(context),
          icon: Icon(
            Icons.calendar_month,
          ),
          label: Text(meetingDate.toString(),
              style: TextStyle(), textAlign: TextAlign.justify),
        ),
      ),
    );
  }

  meetingdeatilswidget() {
    return TextField(
      controller: timeinput, //editing controller of this TextField
      decoration: InputDecoration(
          icon: Icon(Icons.timer), //icon of text field
          labelText: "Enter Time" //label text of field
          ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          // initialTime: TimeOfDay.now(),
          initialTime: TimeOfDay.now(),
          context: context,
        );

        if (pickedTime != null) {
          var time = pickedTime.format(context);
          setState(() {
            var df = DateFormat("h:mm a");
            var dt = df.parse(pickedTime.format(context));
            print(DateFormat('HH:mm:ss').format(dt));
            timeinput.text = time;
          });
        } else {
          print("Time is not selected");
        }
      },
    );
  }

  Future<void> _selectMeetingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime(2024));
    if (picked != null) {
      setState(() {
        meetingDate = dateFormat.format(picked);
        // start_date = dateFormat.format(picked);
        //_buildReportView();
      });
    }
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.grey,
    //padding: EdgeInsets.symmetric(horizontal: 4.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        side: BorderSide(color: Colors.grey)),
    backgroundColor: Colors.transparent,
  );

  tagwidget() {
    var height = MediaQuery.of(context).size.height / 20;
    //margin: EdgeInsets.all(10),

    var margin_for_textformfield = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 20,
      top: MediaQuery.of(context).size.width / 30,
      right: MediaQuery.of(context).size.width / 20,
    );
    return Container(
        margin: margin_for_textformfield,
        child: FutureBuilder<List<String>>(
          future: Tag_repo().getTagLIst(),
          builder: (context, snapshot) {
            if (snapshot!.hasData) {
              var data = snapshot.data!;
              return DropdownButton(
                // Initial Value
                value: dropdownvaluefortag,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: data.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvaluefortag = newValue!;
                  });
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }

  void saveData() {
    /* var datetimedata = meetingDate + " " + timeinput.text;
    datetimedata = dateTimeFormat.format(DateTime.parse(datetimedata));
    Constant.displayToast(datetimedata);*/
  }
}

class Tag_repo {
  var items = [
    'Select Tag',
  ];

  Future<List<String>> getTagLIst() async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'iOSClubMeetingTags.php');
    var request = http.Request(
        'GET', Uri.parse(Constant.API_URL + 'iOSClubMeetingTags.php'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    print(json.decode(res));
    var jsonData = json.decode(res);
    print(jsonData);
    List<String> result = List.empty();
    if (jsonData != null) {
      for (var element in jsonData) {
        items.add(element["TagName"]);
      }
      return items;
    } else {
      //Handle Errors
      throw response.statusCode;
    }

    //return result;
  }
}
