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
  double? lat;
  double? long;
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
        this.lat,
        this.long,
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
    lat = json['lat'];
    long = json['long'];
    crop = json['crop'];
    preference = json['preference'];
    isCompleted = json['completed'];
    filterId = json['filter_id'];
    cropId = json['crop_id'];
    cropImages = json['crop_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['land_area'] = landArea;
    data['address'] = address;
    data['pincode'] = pincode;
    data['state'] = state;
    data['district'] = district;
    data['eng_district'] = engDistrict;
    data['village'] = village;
    data['lat'] = lat;
    data['long'] = long;
    data['crop'] = crop;
    data['preference'] = preference;
    data['completed'] = isCompleted;
    data['filter_id'] = filterId;
    data['crop_id'] = cropId;
    data['crop_images'] = cropImages;
    return data;
  }
}