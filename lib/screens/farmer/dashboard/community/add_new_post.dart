import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../../../controllers/shared/community/community_controller.dart';
import '../../../../widgets/custom_elevated_button.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? _video;
  File? _thumbnail;

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
        _video = File(pickedFile.path);
        _image = null; // Reset image if video is selected
        try {
          // Generate thumbnail
          final thumbnailFile = await VideoCompress.getFileThumbnail(_video!.path);

          setState(() {
            _thumbnail = thumbnailFile;
          });
        } catch (e) {
          print('Error generating thumbnail: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to generate thumbnail')),
          );
        }
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
            SizedBox(
              width: double.infinity,
              child: TextFormField(
                maxLines: 2,
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Write your post description...',
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffCBD5E1), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8),),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image_outlined, size: 22, color: Colors.black,),
                    onPressed: _pickImage,
                  ),
                  Spacer(),
                  Text("Add Image", style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.w400, fontSize: 12, fontFamily: "NotoSans"
                  ),),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffCBD5E1), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8),),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.ondemand_video_outlined, size: 22, color: Colors.black,),
                    onPressed: _pickVideo,
                  ),
                  Spacer(),
                  Text("Add Video", style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w400, fontSize: 12, fontFamily: "NotoSans"
                  ),),
                ],
              ),
            ),
            SizedBox(height: 30),
            if (_image != null)
              Image.file(_image!, height: 200, fit: BoxFit.cover)
            else if (_thumbnail  != null)
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.file(_thumbnail!, height: 200, fit: BoxFit.cover),
                  Text("Video Selected", style: TextStyle(color: Colors.white, fontFamily: "Bitter", fontSize: 15, fontWeight: FontWeight.bold),),
                ],
              )
            // SizedBox(height: 16),
            // ElevatedButton(
            //   child: Text('Post'),
            //   onPressed: _submitPost,
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(vertical: 16),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
            child: CustomElevatedButton(
              buttonColor: Colors.green,
              onPress: _submitPost,
              widget: Text(
                "POST".tr,
                style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
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