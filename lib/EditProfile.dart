import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rotary_district_3131_flutter/Dashboard.dart';
import 'package:rotary_district_3131_flutter/common/Constant.dart';
import 'package:rotary_district_3131_flutter/model/EditProfileResponse.dart';
import 'package:rotary_district_3131_flutter/repository/EditProfile_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  // String UserId;
  String view_id;
  String access_Level;
  String Mobile_no;
  String RotaryId;
  String ClubNumber;
  String ClubName;
  String MemberId;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  EditProfile(
      {required this.view_id,
      required this.access_Level,
      required this.Mobile_no,
      required this.RotaryId,
      required this.ClubNumber,
      required this.ClubName,
      required this.MemberId});

  @override
  _EditProfileState createState() => _EditProfileState(view_id, access_Level,
      Mobile_no, RotaryId, ClubNumber, ClubName, MemberId);
}

class _EditProfileState extends State<EditProfile> {
  var font_header = 12;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? UserId;
  String user_Id = "", accessLevel = "", MemberId = "";
  var isLoading = false;
  var isUpload = false;
  final _formKey = GlobalKey<FormState>();
  String Name = "";
  String? Surname,
      Email,
      Mobile,
      isFemale,
      City,
      Pincode,
      State,
      DateOfBirth,
      RotaryId,
      ClubNumber,
      ClubName;
  String Userphoto = "";
  String birthDate = '';
  String Birthday = '';
  String weddingDate = '';
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  File? imageFile;
  String? path;
  String? _Name, _surname, _email, _mobile, _city, _state, _pincode;
  var base64Image;
  var isupload = false;
  String? tmpFile;

  // String userId = "29429", AccessLevel = "President Elect";

  _EditProfileState(view_id, access_Level, Mobile_no, RotaryId, ClubNumber,
      ClubName, MemberId) {
    this.user_Id = view_id;
    this.accessLevel = access_Level;
    this.Mobile = Mobile_no;
    this.RotaryId = RotaryId;
    this.ClubNumber = ClubNumber;
    this.ClubName = ClubName;
    this.MemberId = MemberId;
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _prefs.then((SharedPreferences prefs) async {
      user_Id = prefs.getString('UserId')!;
      accessLevel = prefs.getString('AccessLevel')!;
      Mobile = prefs.getString('Mobile')!;
      RotaryId = prefs.getString('RotaryId')!;
      ClubNumber = prefs.getString('ClubNumber')!;
      ClubName = prefs.getString('ClubName')!;
      MemberId = prefs.getString('MemberId')!;
    });
    //_scaffoldKey = GlobalKey();
    print("user_id: " + user_Id);
    print("accesslevel:" + accessLevel);
    print("mobile_no.:" + Mobile!);
    print("RotaryId.:" + RotaryId!);
    print("ClubNumber.:" + ClubNumber!);
    print("ClubName.:" + ClubName!);
    print("MemberId.:" + MemberId!);
    _loadData();
    /*   setState(() {
      Gender = gender.toString();
    });*/
  }

  void _loadData() async {
    EditProfile_repo().getProfiledata(user_Id, accessLevel).then((result) {
      if (result != null) {
        setState(() {
          print("result:" + result!.firstName.toString());
          Name = result.firstName.toString();
          Surname = result!.lastName.toString();
          Email = result!.email.toString();
          // Mobile = result.mo.toString();
          isFemale = result.female.toString();
          Userphoto = result.userPhoto.toString();
          City = result.city.toString();
          Pincode = result.pincode.toString();
          State = result.state.toString();

          birthDate = result.birthDate.toString();
          // Birthday = result.birthDate;
          weddingDate = result.weddingDate.toString();
          isLoading = false;
          Constant.displayToast("Data received");
        });

        // saveData(result);
      } else {
        setState(() {
          Constant.displayToast("please enter valid credentials!");
        });
      }
    });
    // setting the initial value in the input controller
    //firstNameInputController.text = ProfileResponse().firstName!;
    //lastNameInputController.text = ProfileResponse().lastName!;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildEditForm(),
    );
  }

  buildEditForm() {
    return Container(
      child: Text("Data is inprogress"),
    );
  }

  _buildEditForm() {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = MediaQuery.of(context).size.height / 20;
    //margin: EdgeInsets.all(10),
    var margin_for_text = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 20,
      top: MediaQuery.of(context).size.width / 30,
    );
    var margin_for_textformfield = EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 20,
      top: MediaQuery.of(context).size.width / 30,
      right: MediaQuery.of(context).size.width / 20,
    );
    var content_padding = EdgeInsets.all(
      MediaQuery.of(context).size.width / 40,
    );
    return SingleChildScrollView(
        child: Container(
            //margin: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 25),
            margin: EdgeInsets.all(
              MediaQuery.of(context).size.width / 30,
            ),
            child: Center(
                child: Column(children: [
              Container(
                // margin: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 20,
                  right: MediaQuery.of(context).size.width / 30,
                ),
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Dashboard(
                                UserId: user_Id!,
                                AccessLevel: accessLevel!,
                                Mobile_no: Mobile!,
                                RotaryId: RotaryId!,
                                ClubNumber: ClubNumber!,
                                ClubName: ClubName!,
                                MemberId: MemberId!,
                                FirstName: Name!)));
                  },
                  child: Text(
                    "SKIP",
                    style: TextStyle(
                      color: Constant.color_theme,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Card(
                  elevation: 5,
                  child: SingleChildScrollView(
                      child: Container(
                          child: new Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      /*margin: EdgeInsets.only(
                                            left: 10, bottom: 5, top: 10),*/
                                      margin: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width /
                                            20,
                                      ),
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                            color: Constant.color_theme,
                                            fontSize: 18 *
                                                MediaQuery.textScaleFactorOf(
                                                    context),
                                            fontWeight: FontWeight.w900),
                                      )),

                                  /* if (Userphoto == null)
                                        //  if (imageFile != null)
                                            Container(
                                                alignment: Alignment.center,
                                                */ /*margin: EdgeInsets.only(left: 10, bottom: 5),
                            child: Image.network(
                                "https://members.rotary3131.org/member-login/" +
                                    Userphoto!)*/ /*
                                                child: Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 75,
                                                      backgroundColor:
                                                          Colors.grey.shade200,
                                                      child: CircleAvatar(
                                                        radius: 70,
                                                        */ /*backgroundImage: NetworkImage(
                                            "https://members.rotary3131.org/member-login/" +
                                                Userphoto!),*/ /*
                                                        backgroundImage:
                                                            Image.file(
                                                                    imageFile!)
                                                                .image,
                                                        // AssetImage('assets/images/Group 18.png'),
                                                      ),
                                                    ),
                                                    Positioned(
                                                        bottom: 1,
                                                        right: 1,
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            _showSelectionDialog(
                                                                context);
                                                          },
                                                          child: Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: Icon(
                                                                  Icons
                                                                      .add_a_photo,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width: 3,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius
                                                                          .circular(
                                                                        50,
                                                                      ),
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                    offset:
                                                                        Offset(
                                                                            2,
                                                                            4),
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                      0.3,
                                                                    ),
                                                                    blurRadius:
                                                                        3,
                                                                  ),
                                                                ]),
                                                          ),
                                                        )),
                                                  ],
                                                )),*/
                                  //  if (Userphoto != null)
                                  if (imageFile == null)
                                    Container(
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: [
                                            CircleAvatar(
                                              radius: 75,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              child: CircleAvatar(
                                                radius: 70,
                                                backgroundImage: NetworkImage(
                                                    Constant.BASE_PATH +
                                                        Userphoto!),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 1,
                                                right: 1,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    _showSelectionDialog(
                                                        context);
                                                  },
                                                  child: Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Icon(
                                                          Icons.add_a_photo,
                                                          color: Colors.black),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 3,
                                                          color: Colors.white,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                            50,
                                                          ),
                                                        ),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset:
                                                                Offset(2, 4),
                                                            color: Colors.black
                                                                .withOpacity(
                                                              0.3,
                                                            ),
                                                            blurRadius: 3,
                                                          ),
                                                        ]),
                                                  ),
                                                )),
                                          ],
                                        )),
                                  if (imageFile != null)
                                    Container(
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: [
                                            CircleAvatar(
                                              radius: 75,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              child: CircleAvatar(
                                                radius: 70,
                                                backgroundImage:
                                                    Image.file(imageFile!)
                                                        .image,
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 1,
                                                right: 1,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    _showSelectionDialog(
                                                        context);
                                                  },
                                                  child: Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Icon(
                                                          Icons.add_a_photo,
                                                          color: Colors.black),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 3,
                                                          color: Colors.white,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                            50,
                                                          ),
                                                        ),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            offset:
                                                                Offset(2, 4),
                                                            color: Colors.black
                                                                .withOpacity(
                                                              0.3,
                                                            ),
                                                            blurRadius: 3,
                                                          ),
                                                        ]),
                                                  ),
                                                )),
                                          ],
                                        )),
                                  /*  if (imageFile != null)
                                    Container(
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: [
                                            CircleAvatar(
                                              radius: 75,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              child: CircleAvatar(
                                                radius: 70,

                                                backgroundImage:
                                                    Image.file(imageFile!)
                                                        .image,
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 1,
                                                right: 1,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    _showSelectionDialog(
                                                        context);
                                                  },
                                                  child: Container(
                                                    child: Padding(
                                                      // padding: const EdgeInsets.all(2.0),
                                                      padding:
                                                          MediaQuery.paddingOf(
                                                                  context) *
                                                              2,
                                                      child: Icon(
                                                          Icons.add_a_photo,
                                                          color: Colors.black),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 3,
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                          50,
                                                        ),
                                                      ),
                                                      color: Colors.white,
                                                       boxShadow: [
                                                          BoxShadow(
                                                            offset:
                                                                Offset(2, 4),
                                                            color: Colors.black
                                                                .withOpacity(
                                                              0.3,
                                                            ),
                                                            blurRadius: 3,
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        )),*/

                                  Container(
                                      /* margin: EdgeInsets.only(
                                            left: 10, bottom: 5),*/
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20),
                                      child: Text(
                                        "Name",
                                        style: TextStyle(
                                            color: Constant.color_theme,
                                            // fontSize: 12,
                                            fontSize: 12 *
                                                MediaQuery.textScaleFactorOf(
                                                    context),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Center(
                                      child: Container(
                                    height: height,
                                    //EditProfile_repo().getProfiledata(name, surname),
                                    // margin: EdgeInsets.all(10),
                                    margin: margin_for_textformfield,
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      initialValue: "" + Name!,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Constant.color_theme,
                                      ),
                                      key: Key("_Name"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        //isCollapsed: true,
                                        contentPadding: content_padding,
                                        border: OutlineInputBorder(),
                                      ),
                                      onSaved: (value) {
                                        _Name = value!.trim();
                                        print("_Name:" + _Name!);
                                      },
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'name is required';
                                        }
                                        _formKey.currentState!.save();
                                        return null;
                                      },
                                    ),
                                  )),
                                  Container(
                                      /* margin: EdgeInsets.only(
                                            left: 10, bottom: 5),*/
                                      margin: margin_for_text,
                                      child: Text(
                                        "SurName",
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
                                      initialValue: "" + Surname!,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Constant.color_theme,
                                      ),
                                      key: Key("_surname"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: content_padding,
                                      ),
                                      onSaved: (value) {
                                        _surname = value!.trim();
                                        print("_surname:" + _surname!);
                                      },
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'Surname is required';
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
                                        "Email",
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
                                      initialValue: "" + Email!,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Constant.color_theme,
                                      ),
                                      key: Key("_email"),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: content_padding,
                                      ),
                                      onSaved: (value) {
                                        _email = value!.trim();
                                        print("_email:" + _email!);
                                      },
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'email is required';
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
                                        "Mobile",
                                        style: TextStyle(
                                            color: Constant.color_theme,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    //EditProfile_repo().getProfiledata(name, surname),
                                    // margin: EdgeInsets.all(10),
                                    height: height,
                                    //margin: EdgeInsets.all(10),
                                    margin: margin_for_textformfield,
                                    child: TextFormField(
                                      initialValue: "" + Mobile!,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Constant.color_theme,
                                      ),
                                      key: Key("_mobile"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: content_padding,
                                      ),
                                      onSaved: (value) {
                                        _mobile = value!.trim();
                                        print("_mobile: " + _mobile!);
                                      },
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'molbile is required';
                                        }
                                        _formKey.currentState!.save();
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                      //   margin: EdgeInsets.only(left: 10, bottom: 5),
                                      margin: margin_for_text,
                                      child: Text(
                                        "Gender",
                                        style: TextStyle(
                                            color: Constant.color_theme,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                        Expanded(
                                            child: RadioListTile(
                                          title: Text("Male"),
                                          value: "false",
                                          groupValue: isFemale,
                                          selectedTileColor: Color(0xff104494),
                                          onChanged: (value) {
                                            setState(() {
                                              isFemale = value.toString();
                                              print(
                                                  "value: " + value.toString());
                                            });
                                          },
                                        )),
                                        Expanded(
                                            child: RadioListTile(
                                          title: Text("Female"),
                                          value: "true",
                                          groupValue: isFemale,
                                          selectedTileColor: Color(0xff104494),
                                          onChanged: (value) {
                                            setState(() {
                                              isFemale = value.toString();
                                              print(
                                                  "value: " + value.toString());
                                            });
                                          },
                                        )),
                                      ])),
                                  Container(
                                      // margin: EdgeInsets.only(left: 10, bottom: 5),
                                      margin: margin_for_text,
                                      child: Text(
                                        "BirthDate",
                                        style: TextStyle(
                                            color: Constant.color_theme,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    /*width: 340,
                                      height: 40,
                                      margin: EdgeInsets.only(
                                        top: 10,
                                        left: 5,
                                      ),*/
                                    width:
                                        MediaQuery.of(context).size.width * 80,
                                    height: height,
                                    //margin: EdgeInsets.all(10),
                                    margin: margin_for_textformfield,
                                    child: TextButton.icon(
                                      style: flatButtonStyle,
                                      onPressed: () =>
                                          _selectBirthDate(context),
                                      icon: Icon(
                                        Icons.calendar_month,
                                      ),
                                      label: Text(birthDate.toString(),
                                          style: TextStyle(),
                                          textAlign: TextAlign.left),
                                    ),
                                  ),
                                  Container(
                                      // margin: EdgeInsets.only(left: 10, bottom: 5, top: 10),
                                      margin: margin_for_text,
                                      child: Text(
                                        "City",
                                        style: TextStyle(
                                            color: Constant.color_theme,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    //margin: EdgeInsets.all(10),
                                    height: height,
                                    //margin: EdgeInsets.all(10),
                                    margin: margin_for_textformfield,
                                    child: TextFormField(
                                      initialValue: "" + City!,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Constant.color_theme,
                                      ),
                                      key: Key("_city"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: content_padding,
                                      ),
                                      onSaved: (value) {
                                        _city = value!.trim();
                                        print("_city:" + _city!);
                                      },
                                    ),
                                  ),
                                  Container(
                                      //  margin: EdgeInsets.only(left: 10, bottom: 5, top: 10),
                                      margin: margin_for_text,
                                      child: Text(
                                        "PinCode",
                                        style: TextStyle(
                                            color: Constant.color_theme,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    //  margin: EdgeInsets.all(10),
                                    height: height,
                                    //margin: EdgeInsets.all(10),
                                    margin: margin_for_textformfield,
                                    child: TextFormField(
                                      initialValue: "" + Pincode!,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Constant.color_theme,
                                      ),
                                      key: Key("_pincode"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: content_padding,
                                      ),
                                      onSaved: (value) {
                                        _pincode = value!.trim();
                                        print("_pincode:" + _pincode!);
                                      },
                                    ),
                                  ),
                                  Container(
                                      //  margin: EdgeInsets.only(left: 10, bottom: 5, top: 10),
                                      margin: margin_for_text,
                                      child: Text(
                                        "State",
                                        style: TextStyle(
                                            color: Constant.color_theme,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                    // margin: EdgeInsets.all(10),
                                    height: height,
                                    //margin: EdgeInsets.all(10),
                                    margin: margin_for_textformfield,
                                    child: TextFormField(
                                      initialValue: "" + State!,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Constant.color_theme,
                                      ),
                                      key: Key("_state"),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: content_padding,
                                      ),
                                      onSaved: (value) {
                                        _state = value!.trim();
                                        print("_state:" + _state!);
                                      },
                                    ),
                                  ),
                                  /* Container(
                                        margin: EdgeInsets.only(
                                            left: 10, bottom: 5, top: 10),
                                        child: Text(
                                          "WeddingDate",
                                          style: TextStyle(
                                              color: Constant.color_theme,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width: 340,
                                      height: 40,
                                      margin: EdgeInsets.only(
                                        top: 10,
                                        left: 5,
                                      ),
                                      child: TextButton(
                                        style: flatButtonStyle,
                                        onPressed: () =>
                                            _selectWddingDate(context),
                                        child: Text(weddingDate.toString()),
                                      ),
                                    ),*/
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, top: 10),
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              print(
                                                Name,
                                              );
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
                                                  if (isUpload = false) {
                                                    path = Userphoto;
                                                  }
                                                  Profile_repo()
                                                      .postdata(
                                                          _surname!,
                                                          isFemale!,
                                                          user_Id!,
                                                          birthDate,
                                                          RotaryId!,
                                                          weddingDate,
                                                          _Name!,
                                                          _city!,
                                                          _pincode!,
                                                          _state!,
                                                          // imageFile!.path,
                                                          path.toString(),
                                                          isUpload)
                                                      .then((result) {
                                                    if (result != null) {
                                                      setState(() {
                                                        print("msg:" +
                                                            result.msg
                                                                .toString());
                                                        Constant.displayToast(
                                                            "" +
                                                                result.msg
                                                                    .toString());
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => Dashboard(
                                                                    UserId:
                                                                        user_Id!,
                                                                    AccessLevel:
                                                                        accessLevel!,
                                                                    Mobile_no:
                                                                        Mobile!,
                                                                    RotaryId:
                                                                        RotaryId!,
                                                                    ClubNumber:
                                                                        ClubNumber!,
                                                                    ClubName:
                                                                        ClubName!,
                                                                    MemberId:
                                                                        MemberId!,
                                                                    FirstName:
                                                                        _Name!)
                                                                //Dashboard()
                                                                ));
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
                                                print(
                                                    "_formKey.currentState is null!");
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              //primary: Color(0xffdd1a27),
                                              onPrimary:
                                                  Colors.white, // foreground
                                            ),
                                            child: Text("Update"),
                                          ),
                                        ),
                                      ])
                                ],
                              )))))
            ]))));
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        //firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        birthDate = dateFormat.format(picked);
        // start_date = dateFormat.format(picked);
        //_buildReportView();
      });
    }
  }

  Future<void> _selectWddingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        //firstDate: DateTime.now().subtract(Duration(days: 7)),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        weddingDate = dateFormat.format(picked);
        // start_date = dateFormat.format(picked);
        //_buildReportView();
      });
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      setState(() {
        isUpload = true;
        imageFile = File(pickedFile.path);
        path = imageFile!.path;
      });
    }
    Navigator.of(context).pop();
  }

  _getFromCamera() async {
    //isupload = true;
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      setState(() {
        isUpload = true;
        imageFile = File(pickedFile.path);
        path = imageFile!.path;
      });
    }
    Navigator.of(context).pop();
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _getFromGallery();
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _getFromCamera();
                      },
                    )
                  ],
                ),
              ));
        });
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.grey,
    //padding: EdgeInsets.symmetric(horizontal: 4.0),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        side: BorderSide(color: Colors.grey)),
    backgroundColor: Colors.transparent,
  );
}

class Profile_repo {
  Future<EditProfileResponse?> postdata(
      String MemlastName,
      String Memfemale,
      String MemuserId,
      // String MemProfessionalSalutation,
      String MembirthDate,
      // String MemcallName,
      String MemRotaryId,
      String MemweddingDate,
      //    String MembloodGroup,
      String MemfirstName,
      String City1,
      String PinCode1,
      String State1,
      String Memuser_photo,
      /*String MemmiddleName*/
      bool isUpload) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    var bodyfields = {
      'MemlastName': MemlastName,
      'Memfemale': Memfemale,
      'MemuserId': MemuserId,
      /*'MemProfessionalSalutation': MemProfessionalSalutation,*/
      'MembirthDate': MembirthDate,
      /* 'MemcallName': MemcallName,*/
      'MemRotaryId': MemRotaryId,
      'MemweddingDate': MemweddingDate,
      /* 'MembloodGroup': MembloodGroup,*/
      'MemfirstName': MemfirstName,
      /* 'Memuser_photo': Memuser_photo,*/
      'City1': City1,
      'State1': State1,
      'PinCode1': PinCode1
      /* 'MemmiddleName': MemmiddleName,*/
    };
    /* request.bodyFields = {
      'MemlastName': 'MemlastName',
      'Memfemale': 'Memfemale',
      'MemuserId': 'MemuserId',
      'MemProfessionalSalutation': 'MemProfessionalSalutation',
      'MembirthDate': 'MembirthDate',
      'MemcallName': 'MemcallName',
      'MemRotaryId': 'MemRotaryId',
      'MemweddingDate': 'MemweddingDate',
      'MembloodGroup': 'MembloodGroup',
      'MemfirstName': 'MemfirstName',
      'MemmiddleName': 'MemmiddleName',
    };*/

    var request =
        //  http.Request('GET', Uri.parse(Constant.API_URL + 'iOSEditProfile.php'));
        http.MultipartRequest(
            'POST', Uri.parse(Constant.API_URL + 'iOSEditProfile.php'));
    /*http.post(Uri.parse(Constant.API_URL + 'iOSEditProfile.php'),
        body: bodyfields, headers: headers);*/
    var imagepath;
    request.fields.addAll(bodyfields);
    bool upload;
    if (isUpload) {
      request.files.add(
          await http.MultipartFile.fromPath("Memuser_photo", Memuser_photo));
    }

    print(Constant.API_URL + 'iOSEditProfile.php');
    http.StreamedResponse response = await request.send();
    var res = await response.stream.bytesToString();
    return responseFromJson(res);
    //  request.bodyFields.addAll('MemlastName': MemlastName, 'Memfemale': Memfemale, 'MemuserId': MemuserId, MemProfessionalSalutation=Dr, MembirthDate=1987-11-29, MemcallName=Navendu, MemRotaryId=86090, MemweddingDate=-0001-11-30, MembloodGroup=O +, MemfirstName=Dummy, MemmiddleName=null);

/*  http.StreamedResponse response = await request.send();
  var res = await response.stream.bytesToString();
  return responseFromJson(res);*/
  }
}
