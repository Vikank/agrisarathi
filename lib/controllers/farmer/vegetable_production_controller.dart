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

class VegetableStagesController extends GetxController {
  final storage = FlutterSecureStorage();
  var vegetableProduction = VegetableProductionModel(stages: [], preferences: []).obs;
  var isLoading = true.obs;
  var currentStageIndex = 0.obs;
  var currentSubStageIndex = 0.obs;
  var isLastSubStage = false.obs;
  var chewieController = Rx<ChewieController?>(null);
  var audioPlayer = Rx<AudioPlayer?>(null);
  var isPlaying = false.obs;

  final int landId;
  final int filterId;

  VegetableStagesController(this.landId, this.filterId);

  @override
  void onInit() {
    super.onInit();
    fetchVegetableStages();
  }

  @override
  void onClose() {
    chewieController.value?.dispose();
    audioPlayer.value?.dispose();
    super.onClose();
  }

  void fetchVegetableStages() async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Authorization': 'Bearer $accessToken'
      };
      isLoading(true);
      var url = Uri.parse('${ApiEndPoints.baseUrlTest}VegetableStagesAPIView');
      var response = await http.post(url, body: {
        'land_id': landId.toString(),
        'filter_type': filterId.toString(),
      }, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        vegetableProduction.value = VegetableProductionModel.fromJson(jsonResponse);
        updateCurrentStageAndSubStage();
      } else {
        Get.snackbar('Error', 'Failed to load data');
      }
    } catch (e) {
      log("error msg $e");
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }

  void updateCurrentStageAndSubStage() {
    if (vegetableProduction.value.stages != null && vegetableProduction.value.stages!.isNotEmpty) {
      loadVideoPlayer();
      loadAudioPlayer();
      updateSubStageProgress();
    }
  }

  void loadVideoPlayer() {
    final videoUrl = currentStage.stageAudio; // Assuming stageAudio is the video URL
    if (videoUrl != null && videoUrl.isNotEmpty) {
      final videoPlayerController = VideoPlayerController.network(videoUrl);
      chewieController.value = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
      );
    } else {
      chewieController.value = null;
    }
  }

  void loadAudioPlayer() {
    final audioUrl = currentStage.stageAudio;
    if (audioUrl != null && audioUrl.isNotEmpty) {
      audioPlayer.value = AudioPlayer();
      audioPlayer.value!.setSourceUrl(audioUrl);
    } else {
      audioPlayer.value = null;
    }
    isPlaying.value = false;
  }

  void updateSubStageProgress() {
    isLastSubStage.value = currentSubStageIndex.value == currentStage.products!.length - 1;
  }

  void onNextPressed() {
    if (!isLastSubStage.value) {
      currentSubStageIndex++;
    } else if (currentStageIndex.value < vegetableProduction.value.stages!.length - 1) {
      currentStageIndex++;
      currentSubStageIndex.value = 0;
    } else {
      // Handle completion of all stages
      Get.snackbar('Completed', 'All stages are completed!');
      return;
    }
    updateCurrentStageAndSubStage();
  }

  Stages get currentStage => vegetableProduction.value.stages![currentStageIndex.value];
  Products get currentSubStage => currentStage.products![currentSubStageIndex.value];

  List<String> get substageNames =>
      currentStage.products?.map((p) => p.productName ?? '').toList() ?? [];
}
