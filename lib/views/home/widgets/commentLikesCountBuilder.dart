import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../utilities/constants.dart';

class CommentLikeCountBuilder extends StatelessWidget {
  const CommentLikeCountBuilder({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  final String videoId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: fire
          .collection('videos')
          .doc(videoId)
          .collection('comments')
          .doc(auth.currentUser!.uid)
          .collection('thumbsUps')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final likeDocData = snapshot.data as QuerySnapshot;
          return Text(
            likeDocData.docs.length.toString(),
          );
        } else {
          return const Text('0');
        }
      },
    );
  }
}
