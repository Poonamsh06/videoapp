import 'package:flutter/material.dart';
import 'package:biscuit1/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../helpers/firebase_helper.dart';

class MyLike extends StatefulWidget {
  MyLike({Key? key, required this.isLike, required this.videoId})
      : super(key: key);

  bool isLike;
  late String videoId;

  @override
  State<MyLike> createState() => MyLikeState();
}

class MyLikeState extends State<MyLike> {
//

  onLikeButtonTapped() async {
    final userId = auth.currentUser!.uid;
    final DocumentSnapshot likedSnap = await fire
        .collection('videos')
        .doc(widget.videoId)
        .collection('like')
        .doc(userId)
        .get();

    final videoDocSnap =
        await fire.collection('videos').doc(widget.videoId).get();
    final videoData = videoDocSnap.data() as Map<String, dynamic>;

    if (likedSnap.exists) {
      setState(() => widget.isLike = false);
      await fire
          .collection('videos')
          .doc(widget.videoId)
          .collection('like')
          .doc(userId)
          .delete();

      videoData['isLiked'] = false;
      fire.collection('videos').doc(widget.videoId).set(videoData);
    } else {
      setState(() => widget.isLike = true);
      fire
          .collection('videos')
          .doc(widget.videoId)
          .collection('like')
          .doc(userId)
          .set({'user': auth.currentUser!.uid});
      videoData['isLiked'] = true;
      fire.collection('videos').doc(widget.videoId).set(videoData);

      updateUsersNotification(widget.videoId.substring(0, 27));
    }
  }

  static updateUsersNotification(String otherId) {
    //
    FirebaseHelper.updateDataToNotification(
      othUid: otherId,
      message: 'like',
      comDes: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isLike ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
        size: 30,
      ),
      onPressed: onLikeButtonTapped,
    );
  }
}
