class MeetingReportingResult {
  String? meetingNo;
  String? meetingType;
  String? meetingDate;
  String? report;
  String? clubMembersPresent;
  String? annetPresent;
  String? visitingRotarians;
  String? image1;
  String? image2;
  String? image3;
  String? image4;

  MeetingReportingResult(
      {this.meetingNo,
      this.meetingType,
      this.meetingDate,
      this.report,
      this.clubMembersPresent,
      this.annetPresent,
      this.visitingRotarians,
      this.image1,
      this.image2,
      this.image3,
      this.image4});

  MeetingReportingResult.fromJson(Map<String, dynamic> json) {
    meetingNo = json['MeetingNo'];
    meetingType = json['MeetingType'];
    meetingDate = json['MeetingDate'];
    report = json['Report'];
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
    data['MeetingNo'] = this.meetingNo;
    data['MeetingType'] = this.meetingType;
    data['MeetingDate'] = this.meetingDate;
    data['Report'] = this.report;
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
