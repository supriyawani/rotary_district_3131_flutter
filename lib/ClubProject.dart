import 'package:flutter/material.dart';
import 'package:rotary_district_3131_flutter/AddProject.dart';
import 'package:rotary_district_3131_flutter/AllClubProject.dart';
import 'package:rotary_district_3131_flutter/SearchProject.dart';
import 'package:rotary_district_3131_flutter/YourClubProject.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClubProject extends StatefulWidget {
  String ClubName;
  String AccessLevel;
  String MemberId;
  String ClubId;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ClubProject({
    required this.ClubName,
    required this.AccessLevel,
    required this.MemberId,
    required this.ClubId,
  });

  @override
  _ClubProjectState createState() =>
      _ClubProjectState(ClubName, AccessLevel, MemberId, ClubId);
}

class _ClubProjectState extends State<ClubProject> {
  String ClubName = "";
  String AccessLevel = "";
  String MemberId = "";
  String ClubId = "";
  var Date;
  String searchvalue = "";
  //DateFormat dateFormat = DateFormat("dd MMMM yyyy, EEEE");

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isLoading = false;

  _ClubProjectState(ClubName, AccessLevel, MemberId, ClubId) {
    this.ClubName = ClubName;
    this.AccessLevel = AccessLevel;
    this.MemberId = MemberId;
    this.ClubId = ClubId;
  }

  @override
  void initState() {
    // TODO: implement initState
    //_tabController = TabController(length: 2, vsync: this);

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
    return /* Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Constant.color_club_project_theme,
          primaryColorDark: Constant.color_club_project_theme,
        ),*/
        /*MaterialApp(
        title: 'Rotary 3131',
        theme: ThemeData(
          //   primarySwatch: Color(0xFF851717), fontFamily: 'Montserrat'
          primaryColor: Color(0xFF851717),
        ),
        home:*/
        Scaffold(

            /* appBar: AppBar(
            leading: BackButton(
              color: Constant.color_theme,
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            title: Text("Meeting Reporting",
                style: TextStyle(
                    color: Constant.color_theme, fontWeight: FontWeight.bold))),*/

            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildTab());
  }

  _buildTab() {
    final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Constant.color_club_project_theme,
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            title: Text("Projects",
                style: TextStyle(
                    color: Constant.color_club_project_theme,
                    fontWeight: FontWeight.bold)),
            // title: Text("GeeksForGeeks"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProject(
                              ClubNumber: ClubId, ClubName: ClubName)));
                },
                icon: Container(
                    //width: MediaQuery.of(context).size.width / 5,
                    // color: Constant.color_theme,
                    child: Icon(
                  Icons.add,
                  color: Constant.color_club_project_theme,
                  size: MediaQuery.of(context).devicePixelRatio * 15,
                )),
              ),
            ],
            bottom: TabBar(
              onTap: (index) {
                print(index);
                // showAlert(tabController.index);
                setState(() {
                  if (index == 2) {
                    showAlertDialog(context);
                  }
                });

                //  tabController.index = tabController.previousIndex;
              },
              indicatorColor: Constant.color_club_project_theme,
              isScrollable: true,
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              physics: ScrollPhysics(),
              tabs: [
                Tab(
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 7,
                      child: Text(
                        "Your Club",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(10),
                          color: Constant.color_club_project,
                          border: Border.all(
                            color: Constant.color_club_project_theme,
                            width: 2,
                          ))),
                ),
                Tab(
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 7,
                      child: Text(
                        "All Club",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(10),
                          color: Constant.color_club_project,
                          border: Border.all(
                            color: Constant.color_club_project_theme,
                            width: 2,
                          ))),
                ),
                Tab(
                    child: GestureDetector(
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 7,
                      child: Text(
                        "Search",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(10),
                          color: Constant.color_club_project,
                          border: Border.all(
                            color: Constant.color_club_project_theme,
                            width: 2,
                          ))),
                  //onTap: showAlertDialog(context),
                )),
              ],
            ),
          ),
          body: TabBarView(children: [
            YourClubProject(
                ClubName: ClubName,
                AccessLevel: AccessLevel,
                MemberId: MemberId,
                ClubId: ClubId),
            AllClubProject(),
            SearchProject(searchvalue: searchvalue),
          ])),
    );
  }

  showAlertDialog(BuildContext context) {
    final TextEditingController _textFieldController = TextEditingController();

    AlertDialog alert = AlertDialog(
      title: Text("Enter Club Name"),
      content: TextField(
        onChanged: (value) {
          setState(() {
            searchvalue = value;
            print("searchvalue1:" + searchvalue);
          });
        },
        controller: _textFieldController,
        decoration: const InputDecoration(hintText: "Enter Club Name"),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: <Widget>[
        TextButton(
            onPressed: () {
              searchvalue = searchvalue;
              print("searchvalue: " + searchvalue);
              // Navigator.pop(context);
              // Navigator.of(context, rootNavigator: true).pop('dialog');
              Navigator.pop(context, searchvalue);

              /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchProject(ClubName: ClubName)));*/
            },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.black),
            )),
        // TextButton(onPressed: () {}, child: Text("Cancel")),
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
}
