// import 'dart:io';
// import 'package:fpo_assist/utils/api_constants.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
//
// class DetectDisease extends GetxController{
//
//   XFile? img;
//
//
//   Future<void> openCamera() async {
//     try {
//       XFile? pickedImage =
//       await ImagePicker().pickImage(source: ImageSource.camera);
//       if (pickedImage != null) {
//         img = pickedImage;
//         print("Image picked: $img");
//         uploadImage(File(img?.path.toString() ?? ""));
//         // Get.to(() => DiseaseScreen(
//         //       img: img?.path.toString() ?? "",
//         //   seId: widget.seId,
//         //   cropname: widget.cropname,
//         //   cropId:widget.cropId,
//         //   filterType: widget.filterType,
//         //     ));
//       } else {
//         print("No image picked.");
//       }
//     } catch (e) {
//       print("Error picking image: $e");
//     }
//   }
//
//   Future<void> uploadImage(File imageFile) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Center(
//           child: SpinKitFadingCube(
//             color: Colors.green,
//             size: 3,
//           ),
//         );
//       },
//     );
//
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse(ApiEndPoints.imageBaseUrl + ApiEndPoints.detectDisease),
//     );
//
//     print("what image am sending $imageFile");
//
//     var image = await http.MultipartFile.fromPath('image', imageFile.path);
//     request.files.add(image);
//     request.fields['service_provider_id'] = widget.seId.toString();
//     request.fields['crop_id'] = widget.cropId.toString();
//     request.fields['fk_userid'] = userId;
//     // request.fields['crop_name'] = widget.cropname.toString();
//     request.fields['filter_type'] = widget.filterType;
//
//     print('Request data: ${request.fields} ${request.files.first.filename}');
//
//     try {
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);
//       log("fgdfdfd ${response.statusCode} ${response.body}");
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         print('Response aaya final: ${response.body}');
//         diseaseResultModel = DiseaseResultModel.fromJson(data);
//         Navigator.pop(context);
//         Get.to(() => DiseaseResultScreen(
//           img:
//           diseaseResultModel.images?.first.diseaseFile.toString() ?? "",
//           disease: diseaseResultModel.disease.toString(),
//           symptom: diseaseResultModel.symptom.toString(),
//           reason: diseaseResultModel.reason.toString(),
//           treatment: diseaseResultModel.treatment.toString(),
//         ));
//       } else {
//         Navigator.pop(context);
//         Fluttertoast.showToast(
//             msg: "Something went wrong",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0);
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
// }