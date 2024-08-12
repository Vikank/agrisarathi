import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../controllers/shared/community/community_controller.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? _video;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _video = null; // Reset video if image is selected
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
        _image = null; // Reset image if video is selected
      });
    }
  }

  void _submitPost() async {
    final controller = Get.find<CommunityController>();

    // Get the description from the TextEditingController
    final description = _descriptionController.text.trim();

    // Determine which file (image or video) is selected
    final filePath = _image?.path ?? _video?.path;

    // Replace with actual user ID
    final userId = '1'; // or any valid user ID

    bool success = await controller.addPost(description: description, filePath: filePath, userId: userId

    );
    if (success) {
      Get.back();
      Get.snackbar('Success', 'Post added successfully');
    } else {
      Get.snackbar('Error', 'Failed to add post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Post'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Write your post description...',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.image, size: 30),
                  onPressed: _pickImage,
                ),
                IconButton(
                  icon: Icon(Icons.videocam, size: 30),
                  onPressed: _pickVideo,
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_image != null)
              Image.file(_image!, height: 200, fit: BoxFit.cover)
            else if (_video != null)
              Container(
                height: 200,
                color: Colors.grey[300],
                child: Center(child: Text('Video selected')),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Post'),
              onPressed: _submitPost,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}