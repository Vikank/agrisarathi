// video_controller.dart
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/disease_detection_video_model.dart';
import '../../models/disease_result_model.dart';
import '../../screens/farmer/detect_disease/disease_result_screen.dart';
import '../../utils/helper_functions.dart';

class DiseaseDetectionVideoController extends GetxController {
  final storage = FlutterSecureStorage();
  final Rx<DiseaseDetectionVideoModel?> videoModel =
      Rx<DiseaseDetectionVideoModel?>(null);
  Rx<VideoPlayerController?> videoPlayerController =
      Rx<VideoPlayerController?>(null);
  Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  String? farmerId;
  int? userLanguage;
  Rx<File?> image = Rx<File?>(null);
  DiseaseResultModel diseaseResultModel = DiseaseResultModel();
  RxInt currentCarousel = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVideo();
    getFarmerId();
    getUserLanguage();
  }

  Future<String?> getFarmerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    farmerId = (prefs.getString('farmerId'));
    return farmerId;
  }

  void getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("UserRole $userLanguage");
  }

  Future<void> fetchVideo() async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      final response = await http.get(
        Uri.parse('${ApiEndPoints.baseUrlTest}GetDiseaseVideo?user_language=1'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['message'] == 'success' && jsonData['data'].isNotEmpty) {
          videoModel.value =
              DiseaseDetectionVideoModel.fromJson(jsonData['data']);
          log("${videoModel.value!.videoUrl}");
          await initializeVideoPlayer();
        } else {
          errorMessage.value = 'No video data available';
        }
      } else {
        errorMessage.value =
            'Failed to load video. Status code: ${response.statusCode}';
      }
    } catch (e) {
      print('Error fetching video: $e');
      errorMessage.value = 'Error fetching video: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> initializeVideoPlayer() async {
    if (videoModel.value != null) {
      final videoUrl = Uri.parse(
          '${ApiEndPoints.imageBaseUrl}${videoModel.value!.videoUrl}');
      videoPlayerController.value = VideoPlayerController.networkUrl(videoUrl);
      await videoPlayerController.value!.initialize();

      chewieController.value = ChewieController(
        videoPlayerController: videoPlayerController.value!,
      );

      update();
    }
  }
  Future<void> openGallery(
      {required int serviceProviderId,
        required int cropId,
        required String landId,
        required String filterType}) async {
    try {
      XFile? pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        image.value = File(pickedImage.path);
        uploadImage(File(image.value?.path ?? ""), serviceProviderId, cropId,
            landId, filterType);
      } else {
        print("No image picked.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> openCamera(
      {required int serviceProviderId,
      required int cropId,
      required String landId,
      required String filterType}) async {
    try {
      XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        image.value = File(pickedImage.path);
        uploadImage(File(image.value?.path ?? ""), serviceProviderId, cropId,
            landId, filterType);
      } else {
        print("No image picked.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> uploadImage(File imageFile, int serviceProviderId, int cropId,
      String landId, String filterType) async {
    String? accessToken = await storage.read(key: 'access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }
    Get.dialog(
        barrierColor: Colors.white,
        useSafeArea: false,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 100,
                child: Image.asset(
                  "assets/gif/detect_disease_loader.gif",
                  fit: BoxFit.contain,
                )),
          ],
        ));
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiEndPoints.baseUrlTest + ApiEndPoints.detectDisease),
    );

    var image = await http.MultipartFile.fromPath('image', imageFile.path);
    request.headers["Authorization"]= accessToken;
    request.files.add(image);
    request.fields['service_provider_id'] = serviceProviderId.toString();
    request.fields['crop_id'] = cropId.toString();
    request.fields['filter_type'] = filterType;
    request.fields['user_language'] = userLanguage.toString();
    request.fields['farmer_land_id'] = landId.toString();
    print('request is: ${request.fields}');
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      log("${response.statusCode} ${response.body}");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('Response: ${data}');
        diseaseResultModel = DiseaseResultModel.fromJson(data);
        Get.back();
        Get.to(DiseaseResultScreen());
      } else {
        Get.back();
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void onClose() {
    videoPlayerController.value?.dispose();
    chewieController.value?.dispose();
    super.onClose();
  }
}
