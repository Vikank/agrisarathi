class GetDukanModel {
  String? message;
  List<Shops>? shops;

  GetDukanModel({this.message, this.shops});

  GetDukanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['shops'] != null) {
      shops = <Shops>[];
      json['shops'].forEach((v) {
        shops!.add(new Shops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shops {
  int? id;
  String? shopName;
  String? shopContactNo;
  String? suppliarLocation;
  String? state;
  String? village;
  String? city;
  String? shopLatitude;
  String? shopLongitude;
  String? productDealsIn;
  String? tehsil;
  String? shopTimings;
  String? shopimage;
  int? noOfRatings;
  String? providedBy;
  int? partnerserviceId;
  int? fpoNameId;

  Shops(
      {this.id,
        this.shopName,
        this.shopContactNo,
        this.suppliarLocation,
        this.state,
        this.village,
        this.city,
        this.shopLatitude,
        this.shopLongitude,
        this.productDealsIn,
        this.tehsil,
        this.shopTimings,
        this.shopimage,
        this.noOfRatings,
        this.providedBy,
        this.partnerserviceId,
        this.fpoNameId});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shopName'];
    shopContactNo = json['shopContactNo'];
    suppliarLocation = json['suppliarLocation'];
    state = json['state'];
    village = json['village'];
    city = json['city'];
    shopLatitude = json['shopLatitude'];
    shopLongitude = json['shopLongitude'];
    productDealsIn = json['productDealsIn'];
    tehsil = json['Tehsil'];
    shopTimings = json['shopTimings'];
    shopimage = json['shopimage'];
    noOfRatings = json['no_of_ratings'];
    providedBy = json['provided_by'];
    partnerserviceId = json['partnerservice_id'];
    fpoNameId = json['fpo_name_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shopName'] = this.shopName;
    data['shopContactNo'] = this.shopContactNo;
    data['suppliarLocation'] = this.suppliarLocation;
    data['state'] = this.state;
    data['village'] = this.village;
    data['city'] = this.city;
    data['shopLatitude'] = this.shopLatitude;
    data['shopLongitude'] = this.shopLongitude;
    data['productDealsIn'] = this.productDealsIn;
    data['Tehsil'] = this.tehsil;
    data['shopTimings'] = this.shopTimings;
    data['shopimage'] = this.shopimage;
    data['no_of_ratings'] = this.noOfRatings;
    data['provided_by'] = this.providedBy;
    data['partnerservice_id'] = this.partnerserviceId;
    data['fpo_name_id'] = this.fpoNameId;
    return data;
  }
}
