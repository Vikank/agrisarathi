// video_controller.dart
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/disease_detection_video_model.dart';

class DiseaseDetectionVideoController extends GetxController {
  final Rx<DiseaseDetectionVideoModel?> videoModel = Rx<DiseaseDetectionVideoModel?>(null);
  Rx<VideoPlayerController?> videoPlayerController = Rx<VideoPlayerController?>(null);
  Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVideo();
  }

  Future<void> fetchVideo() async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndPoints.baseUrl}GetDiseaseVideo'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"user_language": 1}),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['message'] == 'success' && jsonData['data'].isNotEmpty) {
          videoModel.value = DiseaseDetectionVideoModel.fromJson(jsonData['data'][0]);
          log("${videoModel.value!.videoUrl}");
          await initializeVideoPlayer();
        } else {
          errorMessage.value = 'No video data available';
        }
      } else {
        errorMessage.value = 'Failed to load video. Status code: ${response.statusCode}';
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
      final videoUrl = Uri.parse('${ApiEndPoints.imageBaseUrl}${videoModel.value!.videoUrl}');
      videoPlayerController.value = VideoPlayerController.networkUrl(videoUrl);
      await videoPlayerController.value!.initialize();

      chewieController.value = ChewieController(
        videoPlayerController: videoPlayerController.value!,
        autoPlay: true,
      );

      update();
    }
  }

  @override
  void onClose() {
    videoPlayerController.value?.dispose();
    chewieController.value?.dispose();
    super.onClose();
  }
}