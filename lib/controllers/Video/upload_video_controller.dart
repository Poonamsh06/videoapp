import 'dart:io';

import 'package:uuid/uuid.dart';
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

  compressVideo(String videoPath) async {
    VideoCompress.setLogLevel(0);
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

    return mediaInfo;
  }

  static Future<File> getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToFirebaseStorage(
    String id,
    File thumb,
  ) async {
    UploadTask uploadTask =
        store.ref().child('thumbnails').child(id).putFile(thumb);
    TaskSnapshot taskSnapshot = await uploadTask;
    final String imageThumbnailUrl = await taskSnapshot.ref.getDownloadURL();
    return imageThumbnailUrl;
  }

  Future<String> _uploadVideoToFirebaseStorage(
    String id,
    File compVid,
  ) async {
    UploadTask uploadTask =
        store.ref().child('videos').child(id).putFile(compVid);
    TaskSnapshot taskSnapshot = await uploadTask;

    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  void uploadVideo(
    String videoTitle,
    String description,
    File compressedVid,
    File thumbnail,
  ) async {
    try {
      MyDialogBox.loading(message: 'uploading...');
      String uid = _auth.currentUser!.uid;

      DocumentSnapshot userDocSnapshot =
          await fire.collection('users').doc(uid).get();
      final userData = (userDocSnapshot.data() as Map<String, dynamic>);

      final timestamp = DateTime.now();
      final videoId = const Uuid().v1();

      String videoUrl = await _uploadVideoToFirebaseStorage(
          '${uid}video$videoId', compressedVid);
      String thumbnailUrl =
          await _uploadImageToFirebaseStorage('${uid}video$videoId', thumbnail);

      VideoModel newVideo = VideoModel(
        username: userData['name'],
        uid: uid,
        id: '${uid}video$videoId',
        isLiked: false,
        createdOn: timestamp,
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
          .doc('${uid}video$videoId')
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
