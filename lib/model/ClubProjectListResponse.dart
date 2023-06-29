import 'dart:convert';

ClubProjectlistResponse responseFromJson(String str) =>
    ClubProjectlistResponse.fromJson(json.decode(str));

String responseToJson(ClubProjectlistResponse data) =>
    json.encode(data.toJson());

class ClubProjectlistResponse {
  String? title;
  String? startDate;
  String? endDate;
  String? id;
  String? beneficiaries;
  String? noBeneficiaries;
  String? rotaryVolunteerHours;
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
  String? spouseAllowed;
  String? reportApproveStatus;
  String? clubName;
  String? firstName;
  String? lastName;
  String? totalAttending;
  String? totalLike;
  String? memberLike;
  String? totalComment;
  String? memberComment;
  String? memberAttending;
  String? tag;

  ClubProjectlistResponse(
      {this.title,
      this.startDate,
      this.endDate,
      this.id,
      this.beneficiaries,
      this.noBeneficiaries,
      this.rotaryVolunteerHours,
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
      this.spouseAllowed,
      this.reportApproveStatus,
      this.clubName,
      this.firstName,
      this.lastName,
      this.totalAttending,
      this.totalLike,
      this.memberLike,
      this.totalComment,
      this.memberComment,
      this.memberAttending,
      this.tag});

  ClubProjectlistResponse.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    id = json['Id'];
    beneficiaries = json['Beneficiaries'];
    noBeneficiaries = json['NoBeneficiaries'];
    rotaryVolunteerHours = json['RotaryVolunteerHours'];
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
    spouseAllowed = json['SpouseAllowed'];
    reportApproveStatus = json['ReportApproveStatus'];
    clubName = json['ClubName'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    totalAttending = json['TotalAttending'];
    totalLike = json['TotalLike'];
    memberLike = json['MemberLike'];
    totalComment = json['TotalComment'];
    memberComment = json['MemberComment'];
    memberAttending = json['MemberAttending'];
    tag = json['Tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['Id'] = this.id;
    data['Beneficiaries'] = this.beneficiaries;
    data['NoBeneficiaries'] = this.noBeneficiaries;
    data['RotaryVolunteerHours'] = this.rotaryVolunteerHours;
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
    data['SpouseAllowed'] = this.spouseAllowed;
    data['ReportApproveStatus'] = this.reportApproveStatus;
    data['ClubName'] = this.clubName;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['TotalAttending'] = this.totalAttending;
    data['TotalLike'] = this.totalLike;
    data['MemberLike'] = this.memberLike;
    data['TotalComment'] = this.totalComment;
    data['MemberComment'] = this.memberComment;
    data['MemberAttending'] = this.memberAttending;
    data['Tag'] = this.tag;
    return data;
  }
}
