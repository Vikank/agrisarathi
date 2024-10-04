import 'dart:developer';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'dart:convert';
import '../../../models/community_post_model.dart';

class CommunityController extends GetxController {
  final storage = FlutterSecureStorage();
  var posts = <CommunityPost>[].obs;
  var isLoading = true.obs;

  Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);


  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> initializeVideoPlayer(String videoUrl) async {
    try {
      final videoPlayerController = VideoPlayerController.network(videoUrl);
      await videoPlayerController.initialize();

      chewieController.value = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: videoPlayerController.value.aspectRatio,
        autoPlay: false,
        looping: false,
      );

      update();
    } catch (e) {
      print('Error initializing video player: $e');
      chewieController.value = null; // Ensure this is set to null on error
    }
  }

  void updateCommentCount(int postId, int change, Comment newComment) {
    final postIndex = posts.indexWhere((post) => post.postId == postId);
    if (postIndex != -1) {
      posts[postIndex].commentCount = (posts[postIndex].commentCount ?? 0) + change; // Update count
      posts[postIndex].comments.add(newComment);
      posts.refresh(); // Refresh to notify listeners
    }
  }

  Future<void> fetchPosts() async {
    isLoading(true);
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      var url = Uri.parse('${ApiEndPoints.baseUrlTest}CommunityPostsList?filter_type=farmer');
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (decodedResponse['status'] == 'success') {
          posts.value = (decodedResponse['data'] as List)
              .map((post) => CommunityPost.fromJson(post))
              .toList();
        }
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading(false);
    }
  }
  Future<bool> likePost({required int postId, required String action}) async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'  // Add the access token to the headers
      };
      var url =
          Uri.parse('${ApiEndPoints.baseUrlTest}LikeUnlikePost');
      var response = await http.post(url,
          body: json.encode({
            'fk_post_id': postId,
            "user_type": "farmer",
            "action": action
          }), headers : headers);
      log("reponse of like${response.statusCode} ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (decodedResponse['status'] == "success") {
          // Find the post and update its like count and isLikedByUser
          final postIndex = posts.indexWhere((post) => post.postId == postId);
          if (postIndex != -1) {
            posts[postIndex].likeCount = action == 'like' ? (posts[postIndex].likeCount ?? 0) + 1 : (posts[postIndex].likeCount ?? 0) - 1;
            posts[postIndex].isLikedByUser = action == 'like';
            posts.refresh(); // Notify listeners about the change
          }
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Error liking post: $e');
      return false;
    }
  }

  Future<bool> addPost({
    required String description,
    required String? filePath, // Optional image or video file path
    required String userId,
  }) async {
    try {
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      var url = Uri.parse('${ApiEndPoints.baseUrlTest}AddCommunityPost');
      var request = http.MultipartRequest('POST', url);
      request.headers["Authorization"]= "Bearer $accessToken";
      // Add text fields
      request.fields['description'] = description;
      request.fields['user_type'] = 'farmer'; // Replace with actual user type if needed

      if (filePath != null) {
        File file = File(filePath);
        var fileName = file.path.split('/').last;
        String fileExtension = fileName.split('.').last.toLowerCase();

        // Check if the file is an image or a video based on the extension
        if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
          // Add the image file to the request
          var imageFile = await http.MultipartFile.fromPath('image_file', file.path);
          request.files.add(imageFile);
        } else if (['mp4', 'avi', 'mov', 'wmv'].contains(fileExtension)) {
          // Add the video file to the request
          var videoFile = await http.MultipartFile.fromPath('video_file', file.path);
          request.files.add(videoFile);
        } else {
          throw Exception('Unsupported file type');
        }
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseBody);
        if (decodedResponse['status'] == 'success') {
          // Optionally, you can update the local posts list
          await fetchPosts(); // Fetch updated posts list after adding a new post
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Error adding post: $e');
      return false;
    }
  }
}
