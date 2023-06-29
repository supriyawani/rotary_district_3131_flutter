import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/TagList.dart';
import 'package:rotary_district_3131_flutter/repository/AddProject_repo.dart';
import 'package:rotary_district_3131_flutter/repository/ClubMemberInfo_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AddProject extends StatefulWidget {
  String ClubNumber, ClubName;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  AddProject({
    required this.ClubNumber,
    required this.ClubName,
  });

  @override
  _AddProjectState createState() => _AddProjectState(ClubNumber, ClubName);
}

class _AddProjectState extends State<AddProject> {
  String ClubNumber = "";
  String ClubName = "";
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();
  List<TagList> taglist = [];
  String? tagname;
  String dropdownvaluefortag = 'Select Tag';
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String startDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String endDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String? _title, _president, _projDesc;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String ApproveStatus = "Draft";
  _AddProjectState(String ClubNumber, String ClubName) {
    this.ClubNumber = ClubNumber;
    this.ClubName = ClubName;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prefs.then((SharedPreferences prefs) async {
      ClubNumber = prefs.getString('ClubNumber')!;
      ClubName = prefs.getString('ClubName')!;
    });
    print("clubNumber: " + ClubNumber);
    print("ClubName: " + ClubName);
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
              title: Text("Add Project",
                  style: TextStyle(
                      color: Constant.color_club_project_theme,
                      fontWeight: FontWeight.bold))),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _buildForm());
    });
  }

  _buildForm() {
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
    return Card(
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
                                "Select Tag",
                                style: TextStyle(
                                    color: Constant.color_club_project_theme,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )),
                          tagwidget(),
                          Container(
                              // margin: EdgeInsets.only(left: 10, bottom: 5),
                              margin: margin_for_text,
                              child: Text(
                                "Title",
                                style: TextStyle(
                                    color: Constant.color_club_project_theme,
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
                                color: Constant.color_club_project_theme,
                              ),
                              key: Key("_title"),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: content_padding),
                              onSaved: (value) {
                                _title = value!.trim();
                                print("_title:" + _title!);
                              },
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return '_title is required';
                                }
                                _formKey.currentState!.save();
                                return null;
                              },
                            ),
                          ),
                          /*Container(
                              // margin: EdgeInsets.only(left: 10, bottom: 5),
                              margin: margin_for_text,
                              child: Text(
                                "President ",
                                style: TextStyle(
                                    color: Constant.color_club_project_theme,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            height: height,
                            //margin: EdgeInsets.all(10),
                            margin: margin_for_textformfield,
                            child: TextFormField(
                              //initialValue: "" + _location!.toString(),
                              //keyboardType: TextInputType.multiline,
                              //maxLines: 1,
                              style: TextStyle(
                                //fontSize: 15,
                                color: Colors.black,
                              ),
                              key: Key(*/ /*"_president"*/ /* "Rutuja Sontakke"),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: content_padding),
                              onSaved: (value) {
                                _president = value!.trim();
                                print("_president:" + _president!);
                              },
                              */ /*validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'location is required';
                                }
                                _formKey.currentState!.save();
                                return null;
                              },*/ /*
                            ),
                          ),*/
                          Container(
                            margin: margin_for_text,
                            height: height,
                            alignment: Alignment.center,
                            // width: widthofContainer,
                            decoration: BoxDecoration(
                              color: Constant.color_club_project_theme,
                              // borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              "Project Details",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              // margin: EdgeInsets.only(left: 10, bottom: 5),
                              margin: margin_for_text,
                              child: Text(
                                "Start Date",
                                style: TextStyle(
                                    color: Constant.color_club_project_theme,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width * 80,
                            height: height,
                            //margin: EdgeInsets.all(10),
                            margin: margin_for_textformfield,
                            child: TextButton.icon(
                              style: flatButtonStyle,
                              onPressed: () => _selectstarDate(context),
                              icon: Icon(
                                Icons.calendar_month,
                              ),
                              label: Text(startDate.toString(),
                                  style: TextStyle(),
                                  textAlign: TextAlign.justify),
                            ),
                          ),
                          Container(
                              // margin: EdgeInsets.only(left: 10, bottom: 5),
                              margin: margin_for_text,
                              child: Text(
                                "End Date",
                                style: TextStyle(
                                    color: Constant.color_club_project_theme,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width * 80,
                            height: height,
                            //margin: EdgeInsets.all(10),
                            margin: margin_for_textformfield,
                            child: TextButton.icon(
                              style: flatButtonStyle,
                              onPressed: () => _selectendDate(context),
                              icon: Icon(
                                Icons.calendar_month,
                              ),
                              label: Text(endDate.toString(),
                                  style: TextStyle(),
                                  textAlign: TextAlign.justify),
                            ),
                          ),
                          Container(
                              // margin: EdgeInsets.only(left: 10, bottom: 5),
                              margin: margin_for_text,
                              child: Text(
                                "Project Description",
                                style: TextStyle(
                                    color: Constant.color_club_project_theme,
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
                                color: Constant.color_club_project_theme,
                              ),
                              key: Key("_projDesc"),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: content_padding),
                              onSaved: (value) {
                                _projDesc = value!.trim();
                                print("_projDesc:" + _projDesc!);
                              },
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Project Description is required';
                                }
                                _formKey.currentState!.save();
                                return null;
                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 5.w),
                              child: ElevatedButtonTheme(
                                data: ElevatedButtonThemeData(
                                  style: ElevatedButton.styleFrom(
                                      //primary: Color(0xffdd1a27),
                                      alignment: Alignment.center,
                                      onPrimary: Colors.white,
                                      backgroundColor: Constant
                                          .color_club_project_theme // foreground
                                      ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 40.0.w,
                                        child: ElevatedButton(
                                          child: Text('Save'),
                                          onPressed: () {
                                            addProject();
                                          },
                                        )),
                                    Container(
                                        width: 40.0.w,
                                        child: ElevatedButton(
                                          child: Text('Approve'),
                                          onPressed: () {
                                            ApproveStatus = "Publish";
                                            addProject();
                                          },
                                        )),
                                  ],
                                ),
                              )),
                          // getPresident(),
                        ])))));
  }

  addProject() async {
    if (this._formKey.currentState!.validate()) {
      String con = await Constant().checkConnectivity();
      if (con != '') {
        setState(() {
          isLoading = true;
        });
        //AddMeeting_repo().postdata(dropdownvalue,dropdownvaluefortag,meetingDate,meetingId,).then((result) {
        AddProject_repo()
            .postdata(
                _title!,
                startDate,
                endDate,
                _projDesc!,
                dropdownvaluefortag,
                _president!,
                /*param1ProjectId*/ ClubNumber,
                ApproveStatus,
                "Club")
            .then((result) {
          if (result != null) {
            setState(() {
              print("msg:" + result.msg.toString());
              Constant.displayToast(" " + result.msg.toString());
              Navigator.of(context).pop();
            });
          } else {
            setState(() {
              isLoading = false;
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

  Future<void> _selectstarDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //  firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime(2024));
    if (picked != null) {
      setState(() {
        startDate = dateFormat.format(picked);
        // start_date = dateFormat.format(picked);
        //_buildReportView();
      });
    }
  }

  Future<void> _selectendDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //  firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime(2024));
    if (picked != null) {
      setState(() {
        endDate = dateFormat.format(picked);
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
  getPresident() {
    return FutureBuilder<dynamic>(
        future: ClubMemberInfo_repo().getPresident(ClubName),
        //.getMeetinglist(ClubId, ClubName, AccessLevel, MemberId),
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
                itemCount: 1,
                itemBuilder: (context, index) => ListTile(
                        title: Container(
                      child: Text(snapshot.data[index].firstName.toString()),
                    )));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  tagwidget() {
    var height = MediaQuery.of(context).size.height / 20;
    //margin: EdgeInsets.all(10),

    var margin_for_textformfield = EdgeInsets.only(
      // left: MediaQuery.of(context).size.width / 20,
      top: MediaQuery.of(context).size.width / 30,
      //right: MediaQuery.of(context).size.width / 20,
    );
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
            // margin: margin_for_textformfield,
            margin: EdgeInsets.only(left: 5.w),
            child: FutureBuilder<List<String>>(
              future: Tag_repo().getTagLIst(),
              builder: (context, snapshot) {
                if (snapshot!.hasData) {
                  var data = snapshot.data!;
                  return DropdownButton(
                    // Initial Value
                    value: dropdownvaluefortag,

                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: data.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),

                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvaluefortag = newValue!;
                        print("selected value:" + dropdownvaluefortag);
                      });
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )));
  }
}

class Tag_repo {
  var items = [
    'Select Tag',
  ];

  Future<List<String>> getTagLIst() async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    print(Constant.API_URL + 'ClubProjectTagList.php');
    var request = http.Request(
        'GET', Uri.parse(Constant.API_URL + 'ClubProjectTagList.php'));
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
