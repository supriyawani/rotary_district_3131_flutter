import 'dart:convert';

AllClubProjectResult responseFromJson(String str) =>
    AllClubProjectResult.fromJson(json.decode(str));

String responseToJson(AllClubProjectResult data) => json.encode(data.toJson());

class AllClubProjectResult {
  String? title;
  String? startDate;
  String? endDate;
  String? id;
  String? beneficiaries;
  String? rotaryVolunteerHours;
  String? noBeneficiaries;
  String? partnerClubs;
  String? nonRotaryPartner;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? mGNumber;
  String? mGDistrict;
  String? mGClub;
  String? description;
  String? rotarianTeam;
  String? amount;
  String? currency;
  String? approveStatus;
  String? clubName;
  String? firstName;
  String? lastName;
  String? tag;

  AllClubProjectResult(
      {this.title,
      this.startDate,
      this.endDate,
      this.id,
      this.beneficiaries,
      this.rotaryVolunteerHours,
      this.noBeneficiaries,
      this.partnerClubs,
      this.nonRotaryPartner,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.mGNumber,
      this.mGDistrict,
      this.mGClub,
      this.description,
      this.rotarianTeam,
      this.amount,
      this.currency,
      this.approveStatus,
      this.clubName,
      this.firstName,
      this.lastName,
      this.tag});

  AllClubProjectResult.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    id = json['Id'];
    beneficiaries = json['Beneficiaries'];
    rotaryVolunteerHours = json['RotaryVolunteerHours'];
    noBeneficiaries = json['NoBeneficiaries'];
    partnerClubs = json['PartnerClubs'];
    nonRotaryPartner = json['NonRotaryPartner'];
    image1 = json['Image1'];
    image2 = json['Image2'];
    image3 = json['Image3'];
    image4 = json['Image4'];
    mGNumber = json['MGNumber'];
    mGDistrict = json['MGDistrict'];
    mGClub = json['MGClub'];
    description = json['Description'];
    rotarianTeam = json['RotarianTeam'];
    amount = json['Amount'];
    currency = json['Currency'];
    approveStatus = json['ApproveStatus'];
    clubName = json['ClubName'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    tag = json['Tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['Id'] = this.id;
    data['Beneficiaries'] = this.beneficiaries;
    data['RotaryVolunteerHours'] = this.rotaryVolunteerHours;
    data['NoBeneficiaries'] = this.noBeneficiaries;
    data['PartnerClubs'] = this.partnerClubs;
    data['NonRotaryPartner'] = this.nonRotaryPartner;
    data['Image1'] = this.image1;
    data['Image2'] = this.image2;
    data['Image3'] = this.image3;
    data['Image4'] = this.image4;
    data['MGNumber'] = this.mGNumber;
    data['MGDistrict'] = this.mGDistrict;
    data['MGClub'] = this.mGClub;
    data['Description'] = this.description;
    data['RotarianTeam'] = this.rotarianTeam;
    data['Amount'] = this.amount;
    data['Currency'] = this.currency;
    data['ApproveStatus'] = this.approveStatus;
    data['ClubName'] = this.clubName;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Tag'] = this.tag;
    return data;
  }
}
