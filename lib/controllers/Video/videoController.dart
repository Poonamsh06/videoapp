
import 'package:biscuit1/models/videoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../utilities/constants.dart';

class VideoController extends GetxController {
  final Rx<List<VideoModel>> _videos = Rx<List<VideoModel>>([]);

  List<VideoModel> get videos => _videos.value;

  @override
  void onInit() {
    _videos.bindStream(fire.collection('videos').snapshots().map(
      (QuerySnapshot singleVideoSnapshot) {
        List<VideoModel> gotVideos = [];
        for (var singleVideoDocumentSnapshot in singleVideoSnapshot.docs) {
          gotVideos.add(VideoModel.fromSnapshot(singleVideoDocumentSnapshot));
        }
        return gotVideos;
      },
    ));
    super.onInit();
  }
}
