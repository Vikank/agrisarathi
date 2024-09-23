import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'dart:convert';
import '../../models/vegetable_production_model.dart';
import '../../screens/farmer/production/vegetable_production/SubmitTaskController.dart';

class VegetableStagesController extends GetxController {
  final storage = FlutterSecureStorage();
  var vegetableProduction =
      VegetableProductionModel(stages: [], preferences: []).obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs; // For handling error messages
  final RxInt currentPreferenceIndex = 0.obs;
  final RxInt currentStageIndex = 0.obs;
  List<Stage> filteredStages =
      []; // Initialize it as an empty list to avoid null issues
  Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);
  AudioPlayer? audioPlayer;
  var isPlaying = false.obs;
  final int landId;
  final int filterId;

  VegetableStagesController(this.landId, this.filterId);

  void initAudioPlayer() {
    if (filteredStages.isNotEmpty) {
      audioPlayer = AudioPlayer();
      audioPlayer?.setSourceUrl(filteredStages[currentStageIndex.value].stageAudio);
    } else {
      print("No audio URL available for initialization.");
    }
  }

  void initVideoPlayer() {
    if (filteredStages.isNotEmpty) {
      final videoUrl = filteredStages[currentStageIndex.value].stageVideo;
      final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(ApiEndPoints.imageBaseUrl+videoUrl));

      chewieController.value = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
      );

      update();

      // videoPlayerController.initialize().then((_) {
      //    // Refresh UI when video is ready
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     update();
      //   });
      // });

    }
  }

  void toggleAudio(String stageAudio) async {
    if (stageAudio != null) {
      String audioUrl = "${ApiEndPoints.imageBaseUrl}$stageAudio";
      if (isPlaying.value) {
        await audioPlayer?.pause();
      } else {
        await audioPlayer?.play(UrlSource(audioUrl));
      }
      isPlaying.value = !isPlaying.value;
    } else {
      print("No audio available to play.");
    }
  }

  void nextStage() {
    if (currentStageIndex.value < filteredStages.length - 1) {
      currentStageIndex.value++;
      updateMediaPlayers();
    }
      else if(currentStageIndex.value == filteredStages.length-1){
      Get.dialog(SubmitTaskPopup(
        landId: landId,
        filterId: filterId,
        preferenceNumber: filteredStages.first.preference.toString(),
        isLast: (vegetableProduction.value.preferences.last.preferenceNumber ==
            filteredStages.last.preference
            // && currentStageIndex.value == filteredStages.length - 1
        )
      ));
    }

      /*else if (currentPreferenceIndex.value <
        vegetableProduction.value.preferences.length - 1) {
      currentPreferenceIndex.value++;
      currentStageIndex.value = 0;
      filteredStages = filterStagesByPreference(vegetableProduction.value,
          vegetableProduction.value.preferences[currentPreferenceIndex.value]
              .preferenceNumber);
      updateMediaPlayers();
    }*/
      update();
  }

  void updateMediaPlayers() {
    if (filteredStages.isNotEmpty) {
      chewieController.value?.dispose();
      audioPlayer?.dispose();

      // Initialize new video and audio players
      initVideoPlayer();
      initAudioPlayer();
    }
  }

  @override
  void onClose() {
    chewieController.value?.dispose();
    audioPlayer?.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchVegetableStages();
  }

  void fetchVegetableStages() async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {'Authorization': 'Bearer $accessToken'};
      isLoading(true);
      errorMessage(''); // Reset error message
      var url = Uri.parse('${ApiEndPoints.baseUrlTest}VegetableStagesAPIView');
      var response = await http.post(url,
          body: {
            'land_id': landId.toString(),
            'filter_type': filterId.toString(),
          },
          headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        vegetableProduction.value =
            VegetableProductionModel.fromJson(jsonResponse);

        // Initialize filteredStages here after fetching data
        if (vegetableProduction.value.preferences.isNotEmpty) {
          //-------

          for (int i = 0;
              i < vegetableProduction.value.preferences.length;
              i++) {
            if (!vegetableProduction.value.preferences[i].isCompleted) {
              // currentPreferenceIndex.value = vegetableProduction.value.preferences[i].preferenceNumber;
              currentPreferenceIndex.value = i;
              break;
            }
          }
          //-------
          filteredStages = filterStagesByPreference(
              vegetableProduction.value,
              vegetableProduction.value
                  .preferences[currentPreferenceIndex.value].preferenceNumber);
          initVideoPlayer();
          initAudioPlayer();
        } else {
          errorMessage('No stages or preferences available');
        }
      } else {
        errorMessage('Failed to load data');
      }
    } catch (e) {
      log("error msg $e");
      errorMessage('Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }
}
