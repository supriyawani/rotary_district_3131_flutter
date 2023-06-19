import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(child: Image.asset('assets/images/rotary_district.png')),
          Container(child: Image.asset('assets/images/splash_screen.png')),
          /*  Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset('assets/images/dot.png')),
          InkWell(
            child:
                Container(child: Image.asset('assets/images/next_button.png')),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => login()));
            },
          ),*/
        ],
      )),
    );
  }
}
