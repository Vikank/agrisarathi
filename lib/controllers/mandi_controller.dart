import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/get_city_model.dart';
import '../models/get_dukan_model.dart';
import '../models/get_mandi_model.dart';
import '../models/get_product_model.dart';
import '../models/get_single_dukan_model.dart';
import '../models/get_single_product_model.dart';
import '../models/get_state_model.dart';

class MandiController extends GetxController{
  GetDukanServiceModel getDukanServiceModel = GetDukanServiceModel();

  GetDukanModel getDukanModel = GetDukanModel();

  SingleDukanModel singleDukanModel = SingleDukanModel();
  ProductModel productModel = ProductModel();
  CityModel cityModel = CityModel();
  StateModel stateModel = StateModel();
  SingleProductModel singleProductModel = SingleProductModel();

  double currentLat = 0.0;
  double currentLon = 0.0;

  Future<void> getDukanAll() async {
    log("dukan data");
    var response =
    await http.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.dukanAll));
    print("dukan data ${response.body}");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      getDukanServiceModel = GetDukanServiceModel.fromJson(data);
      print('dukan values: $getDukanServiceModel');
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> getShopAll() async {
    var response = await http.get(
      Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.getOnlyShop),
    );
    print("dukan shop data ${response.body}");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      getDukanModel = GetDukanModel.fromJson(data);
      print('dukan values: $getDukanModel');
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> getSingleShop(String shopId) async {

    var request = {
      "shop_id":shopId,
    };

    String encodeData = jsonEncode(request);
    var response = await http.post(
        Uri.parse(
            '${ApiEndPoints.baseUrl}${ApiEndPoints.getSingleShop}'),
        body: encodeData
    );
    log("Single shop data ${response.body}");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      singleDukanModel = SingleDukanModel.fromJson(data);
      // Get.to(
      //   () => const ShopDetailScreen(),
      // );
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> getSingleProduct(String productId) async {

    var request = {
      "product_id":productId,
    };

    String encodeData = jsonEncode(request);
    var response = await http.post(
        Uri.parse(
            '${ApiEndPoints.baseUrl}${ApiEndPoints.getSingleProduct}'),
        body: encodeData
    );
    log("Single product data ${response.body}");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      singleProductModel = SingleProductModel.fromJson(data);
      // Get.to(
      //   () => const ShopDetailScreen(),
      // );
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  // Position? currentPosition;
  // Future<void> getCurrentPosition() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     currentPosition = position;
  //     currentLat = position.latitude;
  //     currentLon = position.longitude;
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> getDukanFilterProduct() async {
    var response = await http
        .get(Uri.parse('http://64.227.166.238:8000/getproduct_category'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      productModel = ProductModel.fromJson(data);
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> getCityFilter() async {
    var response = await http
        .get(Uri.parse('http://64.227.166.238:8000/getallcity'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      cityModel = CityModel.fromJson(data);
      print("city filter ${response.body}");
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> getStateFilter() async {
    var response = await http
        .get(Uri.parse('http://64.227.166.238:8000/getshops_states'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      stateModel = StateModel.fromJson(data);
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  Future<void> getSubDistrictFilter() async {
    var response = await http
        .get(Uri.parse('http://64.227.166.238:8000/getshops_states'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var stateModel = StateModel.fromJson(data);
    } else {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}