class FarmerLands {
  List<Data>? data;

  FarmerLands({this.data});

  FarmerLands.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  double? landArea;
  String? address;
  String? pincode;
  String? state;
  String? district;
  String? village;
  double? lat1;
  double? lat2;
  String? crop;

  Data(
      {this.id,
        this.landArea,
        this.address,
        this.pincode,
        this.state,
        this.district,
        this.village,
        this.lat1,
        this.lat2,
        this.crop});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landArea = json['land_area'];
    address = json['address'];
    pincode = json['pincode'];
    state = json['state'];
    district = json['district'];
    village = json['village'];
    lat1 = json['lat1'];
    lat2 = json['lat2'];
    crop = json['crop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['land_area'] = this.landArea;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['district'] = this.district;
    data['village'] = this.village;
    data['lat1'] = this.lat1;
    data['lat2'] = this.lat2;
    data['crop'] = this.crop;
    return data;
  }
}