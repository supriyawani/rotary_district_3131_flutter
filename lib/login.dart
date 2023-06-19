import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rotary_district_3131_flutter/EditProfile.dart';
import 'package:rotary_district_3131_flutter/model/EditProfileResponse.dart';
import 'package:rotary_district_3131_flutter/model/LoginResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/Constant.dart';
import 'repository/Login_repo.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password, _mailId;
  var isLoading = false;

  String? category;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      category = "Member";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Container(
                      child: Image.asset(
                          "assets/images/rotary_district_horizontal.png"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25.0),
                    child: Container(
                      child: Image.asset("assets/images/Welcome.png"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0, left: 30),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Color(0xff104494),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                      child: new Form(
                    key: this._formKey,
                    // child: (_future == null) ? buildColumn() : buildFutureBuilder(),
                    child: buildColumn(),
                  ))
                ])));
  }

  Column buildColumn() {
    //final ProgressDialog pr = ProgressDialog(context);
    return Column(children: <Widget>[
      Container(
        //margin: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
        // padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: TextFormField(
          //  obscureText: true,
          key: Key("_email"),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            labelText: 'User Name*',
            prefixIcon: Image.asset(
              "assets/images/userid_icon.png",
              color: Color(0xff104494),
            ),
          ),
          onSaved: (value) {
            _email = value!.trim();
          },
          validator: (value) {
            if (value!.trim().isEmpty) {
              return 'Username is required';
            }
            _formKey.currentState!.save();
            return null;
          },
        ),
      ),
      Container(
        // margin: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 10),
        // padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: TextFormField(
          obscureText: true,
          key: Key("_password"),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            //border: OutlineInputBorder(),
            labelText: 'Password*',
            prefixIcon: Image.asset(
              "assets/images/password_icon.png",
              color: Color(0xff104494),
            ),
            /*focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(25.0),
                 borderSide: BorderSide(
                color: Colors.red,
              ),
                ),*/
          ),
          onSaved: (value) {
            _password = value!.trim();
          },
          validator: (value) {
            if (value!.trim().isEmpty) {
              return 'Password is required';
            }
            _formKey.currentState!.save();
            return null;
          },
        ),
      ),
      GestureDetector(
        child: Container(
          alignment: Alignment.topRight,
          margin: EdgeInsets.all(15),
          child: Text(
            "Forgot Password?",
            style: TextStyle(color: Color(0xff104494), fontSize: 12),
          ),
        ),
        onTap: () async {
          // _showSelectionDialog(context);
        },
      ),
      Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: RadioListTile(
              title: Text("Rotarian"),
              value: "Member",
              groupValue: category,
              selectedTileColor: Color(0xff104494),
              onChanged: (value) {
                setState(() {
                  category = value.toString();
                  print("value: " + value.toString());
                });
              },
            )),
            Expanded(
                child: RadioListTile(
              title: Text("Spouse"),
              value: "Spouse",
              groupValue: category,
              selectedTileColor: Color(0xff104494),
              onChanged: (value) {
                setState(() {
                  category = value.toString();
                  print("value: " + value.toString());
                });
              },
            )),
          ]),
      Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 50,
        width: 200,
        //margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: ElevatedButton(
            onPressed: () async {
              //await pr.show();

              if (this._formKey.currentState!.validate()) {
                String con = await Constant().checkConnectivity();
                if (con != '') {
                  setState(() {
                    isLoading = true;
                  });
                  Login_repo()
                      .getLogin(_email, _password, category!)
                      .then((result) {
                    // print('In Builder'+' '+result.message);
                    //Constant.displayToast(result.payload!.accessToken);

                    //pr.hide();
                    if (result != null) {
                      saveData(result);
                      setState(() {
                        //isLoading = false;
                        print("result:" + result!.firstName.toString());

                        /* Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Dashboard()));*/
                      });

                      // saveData(result);
                    } else {
                      setState(() {
                        isLoading = false;
                        Constant.displayToast(
                            "please enter valid credentials!");
                      });
                    }
                  });
                } else {
                  Constant.displayToast(
                      "Please check your internet connection..!");
                }
              }
            },
            style: ElevatedButton.styleFrom(
              //primary: Color(0xffdd1a27),
              onPrimary: Colors.white, // foreground
            ),
            child: Text("Login")),
      ),
      GestureDetector(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15),
          child: Text(
            "Don't have an account? SIGN UP",
            style: TextStyle(color: Color(0xff104494), fontSize: 15),
          ),
        ),
        onTap: () {
          Constant.displayToast("Please contact your president to Sign-Up");
        },
      ),
    ]);
  }

  Future<void> saveData(LoginResult user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('FirstName', user.firstName.toString());
    prefs.setString('Email', user.email.toString());
    prefs.setString('ClubNumber', user.clubNumber.toString());
    prefs.setString('ClubName', user.clubName.toString());
    prefs.setString('UserId', user.userId.toString());
    prefs.setString('RotaryId', user.rotaryId.toString());
    prefs.setString('AccessLevel', user.accessLevel.toString());
    prefs.setString('Mobile', user.mobile.toString());
    prefs.setString('MiddleName', user.middleName.toString());
    prefs.setString('LastName', user.lastName.toString());
    prefs.setString('BirthDate', user.birthDate.toString());
    prefs.setString('WeddingDate', user.weddingDate.toString());
    prefs.setString('BloodGroup', user.bloodGroup.toString());
    prefs.setString('MemberId', user.memberId.toString());

    prefs.setInt('level', 1);
    String UserId = prefs.getString('UserId').toString();
    String AccessLevel = prefs.getString('AccessLevel').toString();
    String Mobile_no = prefs.getString('Mobile').toString();
    String RotaryId = prefs.getString('RotaryId').toString();
    String ClubNumber = prefs.getString('ClubNumber').toString();
    String ClubName = prefs.getString('ClubName').toString();
    String MemberId = prefs.getString('MemberId').toString();
    //String view_id;
    /*await Login_repo().getApplicationData(store_id).then((result) {
      prefs.setString('store_name', result.payload.data.storeName.toString());
      prefs.setString(
          'service_charge', result.payload.data.serviceCharge.toString());
      prefs.setString('store_phone', result.payload.data.storePhone.toString());
      prefs.setString('store_address', result.payload.data.address.toString());
      prefs.setString('currency',
          result.payload.data.accountInfo.currencySymbol.toString());
      prefs.setString('currency_location',
          result.payload.data.accountInfo.currencySymbolLocation.toString());
    });*/
    setState(() {
      isLoading = false;
      Constant.displayToast("login successfully");
      Navigator.push(
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
                  )
              //Dashboard()
              ));
    });
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                  "Please enter your registred email ID to get your password"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      //  obscureText: true,
                      key: Key("_mailId"),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'Enter Email Id',
                        prefixIcon: Image.asset(
                          "assets/images/userid_icon.png",
                          color: Color(0xff104494),
                        ),
                      ),
                      onSaved: (value) {
                        _mailId = value!.trim();
                      },
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Email ID is required';
                        }
                        _formKey.currentState!.save();
                        return null;
                      },
                    )),
                    Expanded(
                        child: Row(children: <Widget>[
                      Expanded(
                          child: RadioListTile(
                        title: Text("Rotarian"),
                        value: "Member",
                        groupValue: category,
                        selectedTileColor: Color(0xff104494),
                        onChanged: (value) {
                          setState(() {
                            category = value.toString();
                            print("value: " + value.toString());
                          });
                        },
                      )),
                      Expanded(
                          child: RadioListTile(
                        title: Text("Spouse"),
                        value: "Spouse",
                        groupValue: category,
                        selectedTileColor: Color(0xff104494),
                        onChanged: (value) {
                          setState(() {
                            category = value.toString();
                            print("value: " + value.toString());
                          });
                        },
                      )),
                    ])),
                  ],
                ),
              ));
        });
  }
}

class forgot_password_repo {
  Future<EditProfileResponse?> postdata(String LoginAs, String Email) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var bodyfields = {};
    var request = http.Request(
        'POST', Uri.parse(Constant.API_URL + 'forgot-password.php'));
    http.post(Uri.parse(Constant.API_URL + 'forgot-password.php'),
        body: bodyfields, headers: headers);
    print(Constant.API_URL + 'iOSEditProfile.php');
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    //  return responseFromJson(res);
    //  request.bodyFields.addAll('MemlastName': MemlastName, 'Memfemale': Memfemale, 'MemuserId': MemuserId, MemProfessionalSalutation=Dr, MembirthDate=1987-11-29, MemcallName=Navendu, MemRotaryId=86090, MemweddingDate=-0001-11-30, MembloodGroup=O +, MemfirstName=Dummy, MemmiddleName=null);

/*  http.StreamedResponse response = await request.send();
  var res = await response.stream.bytesToString();
  return responseFromJson(res);*/
  }
}
