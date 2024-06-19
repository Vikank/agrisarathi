class SingleDukanModel {
  String? status;
  Shop? shop;
  List<Products>? products;

  SingleDukanModel({this.status, this.shop, this.products});

  SingleDukanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shop {
  int? id;
  String? shopName;
  String? shopContactNo;
  String? suppliarLocation;
  String? state;
  Null? village;
  String? city;
  String? shopLatitude;
  String? shopLongitude;
  String? productDealsIn;
  String? tehsil;
  String? shopOpentime;
  String? shopClosetime;
  String? shopOpendays;
  String? shopClosedon;
  String? shopimage;
  int? noOfRatings;
  String? providedBy;
  int? partnerservice;
  Null? fpoName;

  Shop(
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
        this.shopOpentime,
        this.shopClosetime,
        this.shopOpendays,
        this.shopClosedon,
        this.shopimage,
        this.noOfRatings,
        this.providedBy,
        this.partnerservice,
        this.fpoName});

  Shop.fromJson(Map<String, dynamic> json) {
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
    shopOpentime = json['shop_opentime'];
    shopClosetime = json['shop_closetime'];
    shopOpendays = json['shop_opendays'];
    shopClosedon = json['shop_closedon'];
    shopimage = json['shopimage'];
    noOfRatings = json['no_of_ratings'];
    providedBy = json['provided_by'];
    partnerservice = json['partnerservice'];
    fpoName = json['fpo_name'];
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
    data['shop_opentime'] = this.shopOpentime;
    data['shop_closetime'] = this.shopClosetime;
    data['shop_opendays'] = this.shopOpendays;
    data['shop_closedon'] = this.shopClosedon;
    data['shopimage'] = this.shopimage;
    data['no_of_ratings'] = this.noOfRatings;
    data['provided_by'] = this.providedBy;
    data['partnerservice'] = this.partnerservice;
    data['fpo_name'] = this.fpoName;
    return data;
  }
}

class Products {
  int? id;
  String? productName;
  String? weight;
  String? productDescription;
  String? price;
  String? manufacturerName;
  String? productImage;
  String? measurementType;
  String? sellby;
  int? quantity;
  Null? pieces;
  Null? weightMax;
  Null? weightMin;
  Null? shelfLife;
  Null? storageTemp;
  Null? storageUse;
  Null? countaryOrigin;
  String? skuId;
  String? category;
  int? fkCropType;

  Products(
      {this.id,
        this.productName,
        this.weight,
        this.productDescription,
        this.price,
        this.manufacturerName,
        this.productImage,
        this.measurementType,
        this.sellby,
        this.quantity,
        this.pieces,
        this.weightMax,
        this.weightMin,
        this.shelfLife,
        this.storageTemp,
        this.storageUse,
        this.countaryOrigin,
        this.skuId,
        this.category,
        this.fkCropType});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    weight = json['weight'];
    productDescription = json['productDescription'];
    price = json['price'];
    manufacturerName = json['manufacturerName'];
    productImage = json['product_image'];
    measurementType = json['measurement_type'];
    sellby = json['sellby'];
    quantity = json['quantity'];
    pieces = json['pieces'];
    weightMax = json['weight_max'];
    weightMin = json['weight_min'];
    shelfLife = json['shelf_life'];
    storageTemp = json['storage_temp'];
    storageUse = json['storage_use'];
    countaryOrigin = json['countary_origin'];
    skuId = json['sku_id'];
    category = json['Category'];
    fkCropType = json['fk_crop_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['weight'] = this.weight;
    data['productDescription'] = this.productDescription;
    data['price'] = this.price;
    data['manufacturerName'] = this.manufacturerName;
    data['product_image'] = this.productImage;
    data['measurement_type'] = this.measurementType;
    data['sellby'] = this.sellby;
    data['quantity'] = this.quantity;
    data['pieces'] = this.pieces;
    data['weight_max'] = this.weightMax;
    data['weight_min'] = this.weightMin;
    data['shelf_life'] = this.shelfLife;
    data['storage_temp'] = this.storageTemp;
    data['storage_use'] = this.storageUse;
    data['countary_origin'] = this.countaryOrigin;
    data['sku_id'] = this.skuId;
    data['Category'] = this.category;
    data['fk_crop_type'] = this.fkCropType;
    return data;
  }
}
