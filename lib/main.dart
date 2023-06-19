import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rotary_district_3131_flutter/EditProfile.dart';
import 'package:rotary_district_3131_flutter/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // static const myColor = Color(0xff104494);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rotary 3131',
        theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Montserrat'
            // primaryColor: Color(0xffdd1a27),
            ),
        /*theme:
          ThemeData(primaryColor: Color(0xff104494), primarySwatch: Colors.blue
              //Colors.blue,
              //#104494
              ),*/
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        debugShowCheckedModeBanner: false);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    /*Timer(
        Duration(milliseconds: 100),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login())));*/
    _prefs.then((SharedPreferences prefs) async {
      var level = prefs.getInt('level');
      String UserId = prefs.getString('UserId').toString();
      String AccessLevel = prefs.getString('AccessLevel').toString();
      String Mobile_no = prefs.getString('Mobile').toString();
      String RotaryId = prefs.getString('RotaryId').toString();
      String ClubNumber = prefs.getString('ClubNumber').toString();
      String ClubName = prefs.getString('ClubName').toString();
      String MemberId = prefs.getString('MemberId').toString();
      if (level == 1) {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfile(
                          view_id: UserId!,
                          access_Level: AccessLevel!,
                          Mobile_no: Mobile_no!,
                          RotaryId: RotaryId!,
                          ClubNumber: ClubNumber!,
                          ClubName: ClubName!,
                          MemberId: MemberId!,
                        ))));
      } else {
        Timer(
            Duration(seconds: 3),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /*return new DecoratedBox(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/images/splash_screen.png'),
        ),
      ),
    );*/
    /*return Container(
        color: Colors.white, child: Image.asset("assets/logo.webp"));*/

    return Container(
        color: Colors.white,
        // color: Colors.pink,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(child: Image.asset('assets/images/rotary_district.png')),
            Container(child: Image.asset('assets/images/splash_screen.png')),
          ],
        )
        // child: FlutterLogo(size: MediaQuery.of(context).size.height)
        );
  }
}
