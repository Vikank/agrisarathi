import 'dart:ffi';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/community_post_model.dart';

class CommunityController extends GetxController {
  var posts = <CommunityPost>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading(true);
    try {
      var url =
          Uri.parse('https://api.agrisarathi.com/api/Get_Community_Posts_List');
      var request = http.MultipartRequest('POST', url);
      request.fields['filter_type'] = 'farmer';
      request.fields['user_id'] = '1'; // Replace with actual user ID

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseBody);
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
      var url =
          Uri.parse('https://api.agrisarathi.com/api/Like_Unlike_Post_By_User');
      var response = await http.post(url,
          body: json.encode({
            'fk_post_id': postId,
            'user_id': 1, // Replace with actual user ID
            "user_type": "farmer",
            "action": action
          }));

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        if (decodedResponse['status'] == 0) {
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
      var url = Uri.parse('https://api.agrisarathi.com/api/Add_Community_Post');
      var request = http.MultipartRequest('POST', url);

      // Add text fields
      request.fields['description'] = description;
      request.fields['user_id'] = userId;
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
