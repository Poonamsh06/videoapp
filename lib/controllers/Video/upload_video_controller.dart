import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

import '../../models/videoModel.dart';
import '../../utilities/constants.dart';
import '../../utilities/myDialogBox.dart';

class UploadVideoController extends GetxController {
  final _auth = FirebaseAuth.instance;

  _compressVideo(String videoPath) async {
    final MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );

    if (mediaInfo == null) {
      MyDialogBox.showDefaultDialog(
        'OOPS',
        'sorry something went wrong, please try again after some time',
      );
      return;
    }

    return mediaInfo.file;
  }

  Future<File> _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToFirebaseStorage(
    String id,
    String videoPath,
  ) async {
    final imageThumbnail = await _getThumbnail(videoPath);
    UploadTask uploadTask =
        store.ref().child('thumbnails').child(id).putFile(imageThumbnail);
    TaskSnapshot taskSnapshot = await uploadTask;
    final String imageThumbnailUrl = await taskSnapshot.ref.getDownloadURL();
    return imageThumbnailUrl;
  }

  Future<String> _uploadVideoToFirebaseStorage(
    String id,
    String videoPath,
  ) async {
    final compressedFile = await _compressVideo(videoPath);

    UploadTask uploadTask =
        store.ref().child('videos').child(id).putFile(compressedFile);
    TaskSnapshot taskSnapshot = await uploadTask;

    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  void uploadVideo(
      String videoTitle, String description, String videoPath) async {
    try {
      MyDialogBox.loading(message: 'uploading...');
      String uid = _auth.currentUser!.uid;

      DocumentSnapshot userDocSnapshot =
          await fire.collection('users').doc(uid).get();

      final userData = (userDocSnapshot.data() as Map<String, dynamic>);
      final videoDocSnapshot = await fire.collection('videos').get();
      int videoLen = videoDocSnapshot.docs.length;

      String videoUrl = await _uploadVideoToFirebaseStorage(
          '${uid}video$videoLen', videoPath);
      String thumbnailUrl = await _uploadImageToFirebaseStorage(
          '${uid}video$videoLen', videoPath);
      VideoModel newVideo = VideoModel(
        username: userData['name'],
        uid: uid,
        id: '${uid}video$videoLen',
        likes: 0,
        commentCount: 0,
        shareCount: 0,
        videoName: videoTitle,
        description: description,
        videoUrl: videoUrl,
        thumbnailUrl: thumbnailUrl,
        profilePhoto: userData['profilepic'],
      );
      await fire
          .collection('videos')
          .doc('${uid}video$videoLen')
          .set(newVideo.toMap());

      Get.back();
      Get.back();
      Get.back();
      MyDialogBox.showDefaultDialog(
        'Hurray!',
        'your video has been successfully uploaded',
      );
    } catch (e) {
      Get.back();
      Get.back();
      MyDialogBox.showDefaultDialog('Error uploading', e.toString());
    }
  }
}
