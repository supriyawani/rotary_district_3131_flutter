import 'dart:convert';

ProfileResponse responseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String responseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  String? professionalSalutation;
  String? firstName;
  String? middleName;
  String? lastName;
  String? callName;
  String? birthDate;
  String? weddingDate;
  String? bloodGroup;
  String? female;
  String? email;
  String? userPhoto;
  String? clubName;
  String? city;
  String? pincode;
  String? state;

  ProfileResponse(
      {this.professionalSalutation,
      this.firstName,
      this.middleName,
      this.lastName,
      this.callName,
      this.birthDate,
      this.weddingDate,
      this.bloodGroup,
      this.female,
      this.email,
      this.userPhoto,
      this.clubName,
      this.city,
      this.pincode,
      this.state});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    professionalSalutation = json['ProfessionalSalutation'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    callName = json['CallName'];
    birthDate = json['BirthDate'];
    weddingDate = json['WeddingDate'];
    bloodGroup = json['BloodGroup'];
    female = json['Female'];
    email = json['Email'];
    userPhoto = json['User_Photo'];
    clubName = json['ClubName'];
    city = json['City1'];
    state = json['State1'];
    pincode = json['PinCode1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProfessionalSalutation'] = this.professionalSalutation;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['CallName'] = this.callName;
    data['BirthDate'] = this.birthDate;
    data['WeddingDate'] = this.weddingDate;
    data['BloodGroup'] = this.bloodGroup;
    data['Female'] = this.female;
    data['Email'] = this.email;
    data['User_Photo'] = this.userPhoto;
    data['ClubName'] = this.clubName;
    data['City1'] = this.city;
    data['State1'] = this.state;
    data['PinCode1'] = this.pincode;

    return data;
  }
}
