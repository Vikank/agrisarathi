import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

import '../../models/single_crop_suggestion_model.dart';
import '../../utils/helper_functions.dart';

class SingleCropSuggestionController extends GetxController {
  final storage = FlutterSecureStorage();
  var isLoading = true.obs;
  var cropDetails = Rx<CropDetails?>(null);
  var errorMessage = ''.obs;
  final audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  int? userLanguage;

  @override
  void onInit() {
    super.onInit();
    getUserLanguage();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      isPlaying.value = state == PlayerState.playing;
    });
  }

  void getUserLanguage() async {
    userLanguage = await HelperFunctions.getUserLanguage();
    log("userLanguage $userLanguage");
  }


  void fetchSingleCropSuggestion(int cropId) async {
    try {
      isLoading(true);
      errorMessage('');
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      var response = await http.get(
        Uri.parse('${ApiEndPoints.baseUrlTest}${ApiEndPoints.authEndpoints.getSingleCropSuggestion}?crop_id=$cropId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        SingleCropSuggestionModel model = SingleCropSuggestionModel.fromJson(jsonData);
        if (model.cropDetails != null) {
          cropDetails.value = model.cropDetails;
        } else {
          errorMessage('No crop details found.');
        }
      } else {
        errorMessage('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }


  void toggleAudio() async {
    if (cropDetails.value?.cropName != null) {
      String audioUrl = "${ApiEndPoints.baseUrl}/media/cropsuggest_audio/%E0%A4%AA%E0%A4%AF%E0%A4%9C.mp3";
      if (isPlaying.value) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.play(UrlSource(audioUrl));
      }
    }
  }


  // void playAudio() async {
  //   if (cropDetails.value?.cropName != null) {
  //     // String audioUrl = "${ApiEndPoints.baseUrl}${cropDetails.value!.cropAudio}";
  //     String audioUrl = "${ApiEndPoints.baseUrl}/media/cropsuggest_audio/%E0%A4%AA%E0%A4%AF%E0%A4%9C.mp3";
  //     await audioPlayer.play(UrlSource(audioUrl));
  //   }
  // }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}