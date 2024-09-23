// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fpo_assist/screens/farmer/production/vegetable_production/select_sowing.dart';
// import 'package:get/get.dart';
//
// import '../../../controllers/farmer/crop_category_controller.dart';
//
// class ChooseCropCategory extends StatelessWidget {
//   int landId;
//   int cropId;
//   ChooseCropCategory({required this.landId, required this.cropId});
//   final CropCategoryController controller = Get.put(CropCategoryController());
//
//   @override
//   Widget build(BuildContext context) {
//     log("land id is $landId");
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           "Choose_category".tr,
//           style: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             CategoryCard(
//               label: 'Vegetable',
//               imagePath: 'assets/images/vegetable_cat.png',
//               isSelected: controller.selectedCategory == 'Vegetable',
//               onTap: () {
//                 controller.selectCategory('Vegetable');
//                 Get.to(()=> SelectSowing(landId: landId, filterId: cropId,));
//               },
//             ),
//             SizedBox(height: 10,),
//             CategoryCard(
//               label: 'Fruit',
//               imagePath: 'assets/images/fruit_cat.png',
//               isSelected: controller.selectedCategory == 'Fruit',
//               onTap: () {
//                 controller.selectCategory('Fruit');
//                 Fluttertoast.showToast(
//                   msg: "Coming Soon",
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                   backgroundColor: Colors.green,
//                   textColor: Colors.white,
//                   fontSize: 16.0,
//                 );
//               },
//             ),
//             SizedBox(height: 10,),
//             CategoryCard(
//               label: 'Oilseed',
//               imagePath: 'assets/images/oilseed_cat.png',
//               isSelected: controller.selectedCategory == 'Oilseed',
//               onTap: () {
//                 controller.selectCategory('Oilseed');
//                 Fluttertoast.showToast(
//                   msg: "Coming Soon",
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                   backgroundColor: Colors.green,
//                   textColor: Colors.white,
//                   fontSize: 16.0,
//                 );
//               },
//             ),
//             SizedBox(height: 10,),
//             CategoryCard(
//               label: 'Cereal',
//               imagePath: 'assets/images/cereals_cat.png',
//               isSelected: controller.selectedCategory == 'Cereal',
//               onTap: () {
//                 controller.selectCategory('Cereal');
//                 Fluttertoast.showToast(
//                   msg: "Coming Soon",
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                   backgroundColor: Colors.green,
//                   textColor: Colors.white,
//                   fontSize: 16.0,
//                 );
//               },
//             ),
//             SizedBox(height: 10,),
//             CategoryCard(
//               label: 'Pulses',
//               imagePath: 'assets/images/pulses_cat.png',
//               isSelected: controller.selectedCategory == 'Pulses',
//               onTap: () {
//                 controller.selectCategory('Pulses');
//                 Fluttertoast.showToast(
//                   msg: "Coming Soon",
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.BOTTOM,
//                   backgroundColor: Colors.green,
//                   textColor: Colors.white,
//                   fontSize: 16.0,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Custom CategoryCard widget
// class CategoryCard extends StatelessWidget {
//   final String label;
//   final String imagePath;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const CategoryCard({
//     Key? key,
//     required this.label,
//     required this.imagePath,
//     required this.isSelected,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(8.0),
//         decoration: BoxDecoration(
//           border: Border.all(width: 1, color: Colors.grey),
//           borderRadius: BorderRadius.all(
//             Radius.circular(10),
//           ),
//         ),
//         child: Row(
//           children: [
//             Image.asset(
//               imagePath,
//               width: 50,
//               height: 50,
//             ),
//             SizedBox(width: 20),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12.0,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: "NotoSans",
//                 color: Colors.black
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
