class ProjectReportResult {
  String? title;
  String? president;
  String? startDate;
  String? endDate;
  String? description;
  String? currency;
  String? amount;
  String? rotaryVolunteerHours;
  String? noBeneficiaries;
  String? partnerClubs;
  String? nonRotaryPartner;
  String? clubMembersPresent;
  String? annetPresent;
  String? visitingRotarians;
  String? image1;
  String? image2;
  String? image3;
  String? image4;

  ProjectReportResult(
      {this.title,
      this.president,
      this.startDate,
      this.endDate,
      this.description,
      this.currency,
      this.amount,
      this.rotaryVolunteerHours,
      this.noBeneficiaries,
      this.partnerClubs,
      this.nonRotaryPartner,
      this.clubMembersPresent,
      this.annetPresent,
      this.visitingRotarians,
      this.image1,
      this.image2,
      this.image3,
      this.image4});

  ProjectReportResult.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    president = json['President'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    description = json['Description'];
    currency = json['Currency'];
    amount = json['Amount'];
    rotaryVolunteerHours = json['RotaryVolunteerHours'];
    noBeneficiaries = json['NoBeneficiaries'];
    partnerClubs = json['PartnerClubs'];
    nonRotaryPartner = json['NonRotaryPartner'];
    clubMembersPresent = json['ClubMembersPresent'];
    annetPresent = json['AnnetPresent'];
    visitingRotarians = json['VisitingRotarians'];
    image1 = json['Image1'];
    image2 = json['Image2'];
    image3 = json['Image3'];
    image4 = json['Image4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['President'] = this.president;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['Description'] = this.description;
    data['Currency'] = this.currency;
    data['Amount'] = this.amount;
    data['RotaryVolunteerHours'] = this.rotaryVolunteerHours;
    data['NoBeneficiaries'] = this.noBeneficiaries;
    data['PartnerClubs'] = this.partnerClubs;
    data['NonRotaryPartner'] = this.nonRotaryPartner;
    data['ClubMembersPresent'] = this.clubMembersPresent;
    data['AnnetPresent'] = this.annetPresent;
    data['VisitingRotarians'] = this.visitingRotarians;
    data['Image1'] = this.image1;
    data['Image2'] = this.image2;
    data['Image3'] = this.image3;
    data['Image4'] = this.image4;
    return data;
  }
}
