import 'dart:io';

import 'package:VMedia/utilities/constants.dart';
import 'package:VMedia/utilities/customButton.dart';
import 'package:VMedia/utilities/myDialogBox.dart';
import 'package:VMedia/views/home/widgets/compressProgressTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../../controllers/Video/upload_video_controller.dart';

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

enum Mode { compress, upload }

class _AddVideoScreenState extends State<AddVideoScreen> {
  //
  Mode _mode = Mode.compress;
  double? vidSize;
  File? vidThumb;
  double? compressedVidSize;
  File? compressedVid;

  late VideoPlayerController _videoPlayerController;
  final _videoNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final uploadVideoController = Get.put(UploadVideoController());

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10)).then(
      (value) => getVidSizeAndThumbnail(),
    );
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
    VideoCompress.cancelCompression();
    super.dispose();
  }

  void compressVideo() async {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        titlePadding: const EdgeInsets.all(15),
        title: 'Compressing...',
        barrierDismissible: false,
        content: const CompressProgressTile(),
        actions: [
          TextButton(
            child: const Text('Cancel', style: kNormalSizeTextStyle),
            onPressed: () {
              VideoCompress.cancelCompression();
              Get.back();
            },
          )
        ]);
    MediaInfo info =
        await uploadVideoController.compressVideo(widget.videoPath);
    final size = await info.file!.length();
    compressedVid = info.file;
    compressedVidSize = size / (1024 * 1024);
    setState(() {});
    Get.back();
  }

  void getVidSizeAndThumbnail() async {
    vidSize = await widget.videoFile.length() / (1024 * 1024);
    vidThumb = await UploadVideoController.getThumbnail(widget.videoPath);
    setState(() {});
  }

  _uploadVideo() async {
    if (_videoNameController.text == '' || _descriptionController.text == '') {
      MyDialogBox.showDefaultDialog(
        'Note',
        'please fill out the fields to upload video.',
      );
      return;
    }
    uploadVideoController.uploadVideo(
      _videoNameController.text,
      _descriptionController.text,
      compressedVid!,
      vidThumb!,
    );
    setState(() => compressedVid = null);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _mode == Mode.compress
                ? [
                    vidThumb == null
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            height: size.width, child: Image.file(vidThumb!)),
                    const SizedBox(height: 10),
                    const Text(
                      'original video size:',
                      style: kSmallSizeTextStyle,
                    ),
                    Text(
                      vidSize == null
                          ? ''
                          : '${vidSize!.toStringAsFixed(2)}  mb',
                      style: kNormalSizeBoldTextStyle,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 250,
                      child: CustomButton(
                        onPressed:
                            compressedVidSize == null ? compressVideo : null,
                        title: 'Compress video',
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (compressedVidSize != null)
                      const Text(
                        'Compressed video size:',
                        style: kSmallSizeTextStyle,
                      ),
                    if (compressedVidSize != null)
                      Text(
                        '${compressedVidSize!.toStringAsFixed(2)}  mb',
                        style: kNormalSizeBoldTextStyle,
                      ),
                    const SizedBox(height: 10),
                    if (compressedVidSize != null)
                      SizedBox(
                        width: 150,
                        child: CustomButton(
                          onPressed: () => setState(() => _mode = Mode.upload),
                          title: 'Next',
                        ),
                      ),
                  ]
                : [
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.6,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextField(
                            controller: _videoNameController,
                            decoration: const InputDecoration(
                              labelText: 'video name',
                              prefixIcon: Icon(Icons.video_collection_rounded),
                            ),
                            maxLength: 25,
                          ),
                          TextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'description',
                              prefixIcon: Icon(Icons.notes_rounded),
                            ),
                            maxLength: 50,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            onPressed: _uploadVideo,
                            title: 'Upload',
                          ),
                        ],
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
