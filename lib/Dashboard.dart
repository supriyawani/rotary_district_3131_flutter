import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_district_3131_flutter/ClubCelebrationList.dart';
import 'package:rotary_district_3131_flutter/ClubMeeting.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/widget/ClubBulletin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Dashboard extends StatefulWidget {
  String UserId;
  String AccessLevel;
  String Mobile_no, RotaryId, ClubNumber, ClubName, MemberId;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Dashboard({
    required this.UserId,
    required this.AccessLevel,
    required this.Mobile_no,
    required this.RotaryId,
    required this.ClubNumber,
    required this.ClubName,
    required this.MemberId,
  });
  @override
  _DashboardState createState() => _DashboardState(
      UserId, AccessLevel, Mobile_no, RotaryId, ClubNumber, ClubName, MemberId);
}

class _DashboardState extends State<Dashboard> {
  String UserId = "";
  String AccessLevel = "";
  String Mobile_no = "";
  String RotaryId = "";
  String ClubNumber = "";
  String ClubName = "";
  String MemberId = "";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false;
  _DashboardState(String UserId, String AccessLevel, String Mobile_no,
      String RotaryId, String ClubNumber, String ClubName, String MemberId) {
    this.UserId = UserId;
    this.AccessLevel = AccessLevel;
    this.Mobile_no = Mobile_no;
    this.RotaryId = AccessLevel;
    this.ClubNumber = ClubNumber;
    this.ClubName = ClubName;
    this.MemberId = MemberId;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    _prefs.then((SharedPreferences prefs) async {
      UserId = prefs.getString('UserId')!;
      AccessLevel = prefs.getString('AccessLevel')!;
      Mobile_no = prefs.getString('Mobile')!;
      RotaryId = prefs.getString('RotaryId')!;
      ClubNumber = prefs.getString('ClubNumber')!;
      ClubName = prefs.getString('ClubName')!;
      MemberId = prefs.getString('MemberId')!;
    });
    print("UserId: " + UserId);
    print("AccessLevel: " + AccessLevel);
    print("Mobile_no: " + Mobile_no);
    print("RotaryId: " + RotaryId);
    print("ClubNumber: " + ClubNumber);
    print("ClubName: " + ClubName);
    print("MemberId: " + MemberId);
  }

  @override
  Widget build(BuildContext context) {
    final myImageAndCaption = [
      ["assets/images/club_meeting.png", "club meeting"],
      ["assets/images/club_roaster.png", "club roaster"],
    ];
    int position;

    var scaffoldKey = GlobalKey<ScaffoldState>();
    //GlobalKey<ScaffoldState>() scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      /* debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Scaffold(*/
      appBar: AppBar(
          /*automaticallyImplyLeading: false,
        title: Text("Hi",
            style: TextStyle(
                color: Constant.color_theme, fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();

            //Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: SvgPicture.asset(
            'assets/images/Path 274.svg',
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/images/Path 5379.svg"),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset("assets/images/Group 30.svg"),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset(
                "assets/images/Rotary International logo Orange.png"),
            onPressed: () {},
          ),
        ],*/
          leading: BackButton(
            color: Constant.color_theme,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text(" Hi",
              style: TextStyle(
                  color: Constant.color_theme, fontWeight: FontWeight.bold))),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        DrawerHeader(
          child: SvgPicture.asset("assets/images/Path 274.svg"),
        ),
        ListTile(
          title: Text('FAQ'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
      ])),
      body: GridView.count(
          padding: EdgeInsets.all(20),
          crossAxisCount: 2,
          crossAxisSpacing: 30.0,
          mainAxisSpacing: 20.0,
          children: List.generate(choices.length, (index) {
            return GestureDetector(
              child: Center(
                child: SelectCard(
                  choice: choices[index],
                  key: null,
                ),
              ),
              onTap: () {
                int position = index;
                print(position);
                getposition(position);
              },
            );
          })),
    );
  }

  void getposition(int position) {
    switch (position) {
      case 0:
        print(position);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClubMeeting(
                    ClubName: ClubName,
                    AccessLevel: AccessLevel,
                    MemberId: MemberId,
                    ClubId: ClubNumber)));
        break;
      case 1:
        print(position);
        /* Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddMeeting(
                      ClubId: ClubNumber,
                    )));*/
        Constant.displayToast("Coming Soon");
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ClubCelebrationList()));

        break;

      case 3:
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingReporting()));
        Constant.displayToast("Coming Soon");
        break;
      case 4:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClubBulletin(ClubNumber: ClubNumber)));
        break;
    }
  }
}

class Choice {
  const Choice({required this.title, required this.icon, required this.color});

  final String title;
  final String icon;
  final Color color;
}

const List<Choice> choices = const <Choice>[
  const Choice(
      title: 'Club Meeting',
      // icon: "assets/images/club_meeting_svg.svg",
      icon: "assets/images/Group 18.png",
      color: Constant.color_clubmeeting),
  const Choice(
      title: 'Club Roaster',
      icon: "assets/images/Group 19.png",
      color: Constant.color_clubroaster),
  const Choice(
      title: 'Club Celebration',
      icon: "assets/images/Group 20.png",
      color: Constant.coior_clubcelebration),
  const Choice(
      title: 'Project',
      icon: "assets/images/Group 21.png",
      color: Constant.color_project),
  const Choice(
      title: 'Club Bulletines',
      icon: "assets/images/Group 22.png",
      color: Constant.color_clubbulletins),
  const Choice(
      title: 'Member Search',
      icon: "assets/images/Group 23.png",
      color: Constant.color_membersearch),
  const Choice(
      title: 'Member Search',
      icon: "assets/images/Group 24.png",
      color: Constant.color_districtcommitees),
  const Choice(
      title: 'District Commitee',
      icon: "assets/images/Group 25.png",
      color: Constant.color_infoofleaders),
];

class SelectCard extends StatelessWidget {
  const SelectCard({required key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    //final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: choice.color),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(8),
                /* height: 120,
                width: 120,*/
                child: Material(
                  shape: CircleBorder(),
                  child: SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.asset(
                        choice.icon,
                      )),
                )),
            Container(
                alignment: Alignment.bottomCenter,
                transformAlignment: Alignment.center,
                //margin: EdgeInsets.only(top: 10),
                margin: EdgeInsets.all(10),
                child: Text(
                  choice.title,
                  style: TextStyle(
                      color: Constant.color_theme, fontWeight: FontWeight.bold),
                )),
          ],
        )

            /* child: Icon(choice.icon, size: 50.0, color: Colors.pink)),
                Text(choice.title, style: TextStyle(fontSize: 10)),*/
            ));
  }

  void getSAvedData() {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  }
}
