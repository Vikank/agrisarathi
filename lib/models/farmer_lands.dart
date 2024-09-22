class FarmerLands {
  List<Data>? data;

  FarmerLands({this.data});

  FarmerLands.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  String? engDistrict;
  String? village;
  double? lat1;
  double? lat2;
  String? crop;
  bool? preference;
  bool? isCompleted;
  int? filterId;
  int? cropId;
  List<String>? cropImages;

  Data(
      {this.id,
        this.landArea,
        this.address,
        this.pincode,
        this.state,
        this.district,
        this.engDistrict,
        this.village,
        this.lat1,
        this.lat2,
        this.crop,
        this.preference,
        this.isCompleted,
        this.filterId,
        this.cropId,
        this.cropImages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landArea = json['land_area'];
    address = json['address'];
    pincode = json['pincode'];
    state = json['state'];
    district = json['district'];
    engDistrict = json['eng_district'];
    village = json['village'];
    lat1 = json['lat1'];
    lat2 = json['lat2'];
    crop = json['crop'];
    preference = json['preference'];
    isCompleted = json['completed'];
    filterId = json['filter_id'];
    cropId = json['crop_id'];
    cropImages = json['crop_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['land_area'] = this.landArea;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['district'] = this.district;
    data['eng_district'] = this.engDistrict;
    data['village'] = this.village;
    data['lat1'] = this.lat1;
    data['lat2'] = this.lat2;
    data['crop'] = this.crop;
    data['preference'] = this.preference;
    data['completed'] = this.isCompleted;
    data['filter_id'] = this.filterId;
    data['crop_id'] = this.cropId;
    data['crop_images'] = this.cropImages;
    return data;
  }
}