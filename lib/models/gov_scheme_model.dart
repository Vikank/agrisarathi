class SchemeModel {
  int? schemeId;
  String? schemeName;
  String? details;
  String? benefits;
  String? eligibility;
  String? applicationProcess;
  String? documentRequire;
  String? schemeBy;
  String? ministryName;
  String? state;
  String? applicationformLink;
  String? reference;
  String? schemeImage;

  SchemeModel(
      {this.schemeId,
        this.schemeName,
        this.details,
        this.benefits,
        this.eligibility,
        this.applicationProcess,
        this.documentRequire,
        this.schemeBy,
        this.ministryName,
        this.state,
        this.applicationformLink,
        this.reference,
        this.schemeImage});

  factory  SchemeModel.fromJson(Map<String, dynamic> json) {
    return SchemeModel(
        schemeId : json['id'],
        schemeName : json['scheme_name'],
        details : json['details'],
        benefits : json['benefits'],
        eligibility : json['eligibility'],
        applicationProcess : json['application_process'],
        documentRequire : json['document_require'],
        schemeBy : json['scheme_by'],
        ministryName : json['ministry_name'],
        state : json['state'],
        applicationformLink : json['applicationform_link'],
        reference : json['reference'],
        schemeImage : json['scheme_image'],
    );
  }
}