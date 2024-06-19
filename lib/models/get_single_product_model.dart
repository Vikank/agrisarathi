class SingleProductModel {
  Product? product;
  List<Suppliers>? suppliers;

  SingleProductModel({this.product, this.suppliers});

  SingleProductModel.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['suppliers'] != null) {
      suppliers = <Suppliers>[];
      json['suppliers'].forEach((v) {
        suppliers!.add(new Suppliers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.suppliers != null) {
      data['suppliers'] = this.suppliers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? category;
  double? weight;
  String? description;
  double? price;
  String? manufacturer;
  String? imageUrl;

  Product(
      {this.id,
        this.name,
        this.category,
        this.weight,
        this.description,
        this.price,
        this.manufacturer,
        this.imageUrl});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    weight = json['weight'];
    description = json['description'];
    price = json['price'];
    manufacturer = json['manufacturer'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['price'] = this.price;
    data['manufacturer'] = this.manufacturer;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Suppliers {
  int? shopId;
  String? shopName;
  String? city;
  String? state;

  Suppliers({this.shopId, this.shopName, this.city, this.state});

  Suppliers.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}
