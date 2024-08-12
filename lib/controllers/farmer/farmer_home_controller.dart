import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/farmer_details_model.dart';
import '../../utils/api_constants.dart';


class FarmerHomeController extends GetxController{
  var selectedIndex = 0.obs;
  String userRole = '';
  RxInt currentCarousel = 0.obs;
  var farmerDetails = FarmerDetailsModel(data: []).obs;
  RxBool farmerDetailsLoader = true.obs;
  String? farmerId;

  @override
  void onInit() {
    super.onInit();
    getFarmerId().then((value){
      fetchFarmerDetails();
    });
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<String?>getFarmerId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    farmerId = (prefs.getString('farmerId'));
    log("farmer id ${farmerId}");
    return farmerId;
  }

  void fetchFarmerDetails() async {
    farmerDetailsLoader.value = true;
    final url = Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getFarmerDetails}?user_id=$farmerId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        farmerDetails.value = FarmerDetailsModel.fromJson(jsonData);
        farmerDetailsLoader.value = false;
      } else {
        farmerDetailsLoader.value = false;
        throw Exception('Failed to load farmer details');
      }
    } catch (e) {
      farmerDetailsLoader.value = false;
      print('Error fetching farmer details: $e');
    }
  }
}