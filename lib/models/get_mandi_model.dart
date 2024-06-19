class GetDukanServiceModel {
  List<Services>? services;
  List<Shops>? shops;
  List<Products>? products;

  GetDukanServiceModel({this.services, this.shops, this.products});

  GetDukanServiceModel.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['shops'] != null) {
      shops = <Shops>[];
      json['shops'].forEach((v) {
        shops!.add(new Shops.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? shopName;
  String? shopContactNo;
  String? supplierName;
  String? suppliarLocation;
  String? state;
  String? village;
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
  int? partnerserviceId;
  int? fpoNameId;

  Services(
      {this.id,
        this.shopName,
        this.shopContactNo,
        this.supplierName,
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
        this.partnerserviceId,
        this.fpoNameId});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shopName'];
    shopContactNo = json['shopContactNo'];
    supplierName = json['supplier_name'];
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
    partnerserviceId = json['partnerservice_id'];
    fpoNameId = json['fpo_name_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shopName'] = this.shopName;
    data['shopContactNo'] = this.shopContactNo;
    data['supplier_name'] = this.supplierName;
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
    data['partnerservice_id'] = this.partnerserviceId;
    data['fpo_name_id'] = this.fpoNameId;
    return data;
  }
}

class Shops {
  int? id;
  String? shopName;
  String? shopContactNo;
  String? supplierName;
  String? suppliarLocation;
  String? state;
  String? village;
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
  int? partnerserviceId;
  int? fpoNameId;

  Shops(
      {this.id,
        this.shopName,
        this.shopContactNo,
        this.supplierName,
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
        this.partnerserviceId,
        this.fpoNameId});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shopName'];
    shopContactNo = json['shopContactNo'];
    supplierName = json['supplier_name'];
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
    partnerserviceId = json['partnerservice_id'];
    fpoNameId = json['fpo_name_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shopName'] = this.shopName;
    data['shopContactNo'] = this.shopContactNo;
    data['supplier_name'] = this.supplierName;
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
    data['partnerservice_id'] = this.partnerserviceId;
    data['fpo_name_id'] = this.fpoNameId;
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
  int? fkServiceproviderId;
  String? measurementType;
  String? sellby;
  int? quantity;
  int? pieces;
  Null? weightMax;
  Null? weightMin;
  int? shelfLife;
  int? storageTemp;
  String? storageUse;
  String? countaryOrigin;
  String? skuId;
  String? category;
  int? fkCropTypeId;

  Products(
      {this.id,
        this.productName,
        this.weight,
        this.productDescription,
        this.price,
        this.manufacturerName,
        this.productImage,
        this.fkServiceproviderId,
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
        this.fkCropTypeId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    weight = json['weight'];
    productDescription = json['productDescription'];
    price = json['price'];
    manufacturerName = json['manufacturerName'];
    productImage = json['product_image'];
    fkServiceproviderId = json['fk_serviceprovider_id'];
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
    fkCropTypeId = json['fk_crop_type_id'];
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
    data['fk_serviceprovider_id'] = this.fkServiceproviderId;
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
    data['fk_crop_type_id'] = this.fkCropTypeId;
    return data;
  }
}
