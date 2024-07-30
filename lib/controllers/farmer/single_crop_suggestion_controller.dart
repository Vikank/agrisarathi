import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

import '../../models/single_crop_suggestion_model.dart';

class SingleCropSuggestionController extends GetxController {
  var isLoading = true.obs;
  var cropDetails = Rx<CropDetails?>(null);
  var errorMessage = ''.obs;
  final audioPlayer = AudioPlayer();


  void fetchSingleCropSuggestion(int cropId) async {
    try {
      isLoading(true);
      errorMessage('');

      var response = await http.post(
        Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.getSingleCropSuggestion}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "user_id": 1,
          "user_language": 1,
          "crop_id": cropId
        }),
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

  void playAudio() async {
    if (cropDetails.value?.cropName != null) {
      String audioUrl = "${ApiEndPoints.baseUrl}${cropDetails.value!.cropAudio}";
      await audioPlayer.play(UrlSource(audioUrl));
    }
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}