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
      var url = Uri.parse('https://api.agrisarathi.com/api/Get_Community_Posts_List');
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

  Future<void> likePost(int postId) async {
    // Implement like functionality
    // You'll need to update the API call and handle the response
  }
}