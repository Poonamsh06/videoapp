import 'dart:io';

import 'package:biscuit1/Widgets/MyInputField.dart';
import 'package:biscuit1/controllers/Video/upload_video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AddVideoScreen extends StatefulWidget {
  AddVideoScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  File videoFile;
  String videoPath;

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  late VideoPlayerController _videoPlayerController;
  final _videoNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.file(widget.videoFile);
    _videoPlayerController.initialize();
    _videoPlayerController.play();
    _videoPlayerController.setVolume(1);
    _videoPlayerController.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: media.height * 0.7,
              child: VideoPlayer(_videoPlayerController),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  MyInputField(
                    labelText: 'video name',
                    isObscure: false,
                    borderColor: Theme.of(context).primaryColor,
                    icon: Icons.video_collection_rounded,
                    controller: _videoNameController,
                  ),
                  const SizedBox(height: 15),
                  MyInputField(
                    labelText: 'description',
                    isObscure: false,
                    borderColor: Theme.of(context).primaryColor,
                    icon: Icons.notes_rounded,
                    controller: _descriptionController,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      uploadVideoController.uploadVideo(
                        _videoNameController.text,
                        _descriptionController.text,
                        widget.videoPath,
                      );
                    },
                    icon: const Icon(Icons.upload_rounded),
                    label: const Text('upload'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
