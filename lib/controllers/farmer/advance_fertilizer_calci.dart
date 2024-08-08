import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdvancedFertilizerCalculatorController extends GetxController {
  var daep = ''.obs;
  var complexes = ''.obs;
  var urea = ''.obs;
  var ssp = ''.obs;
  var mop = ''.obs;

  var apiResponse = Rxn<Map<String, dynamic>>();
  var isLoading = false.obs;

  Future<void> calculateFertilizer() async {
    isLoading.value = true;
    final url = Uri.parse('https://api.agrisarathi.com/api/AdvanceFertilizercalculator');
    int parseInt(String value) {
      try {
        return int.parse(value);
      } catch (e) {
        return 0; // Default value for invalid input
      }
    }
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": 1,
          "user_language": 1,
          "crop_id": 4,
          "daep": parseInt(daep.value),
          "complexes": parseInt(complexes.value),
          "urea": parseInt(urea.value),
          "ssp": parseInt(ssp.value),
          "mop": parseInt(mop.value),
        }),
      );

      if (response.statusCode == 200) {
        apiResponse.value = jsonDecode(response.body);
      } else {
        Get.snackbar('Error', 'Failed to calculate. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}