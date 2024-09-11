import 'package:get/get.dart';

class CropCategoryController extends GetxController{
  // Observable for the selected category
  var selectedCategory = ''.obs;


  // Method to update selected category
  Future<void> selectCategory(String category) async {
    selectedCategory.value = category;
  }
}