import 'package:biscuit1/views/home/widgets/commentListTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../helpers/firebase_helper.dart';
import '../../models/commentModel.dart';
import '../../utilities/constants.dart';
import '../../utilities/myDialogBox.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  String videoId;
  final _commentController = TextEditingController();

  void addComment(String videoId) async {
    if (_commentController.text == '') {
      MyDialogBox.showDefaultDialog(
        'OOPS',
        'please leave a comment before posting it.',
      );
      return;
    }
    final userModel =
        await FirebaseHelper.fetchUserDetailsByUid(uid: auth.currentUser!.uid);
    if (userModel == null) return;

    final videoDocSnap = await fire.collection('videos').doc(videoId).get();

    final username = userModel.name;
    final timestamp = DateTime.now().toIso8601String();
    final profilePhoto =
        (videoDocSnap.data() as Map<String, dynamic>)['profilePhoto'];
    final commentId = auth.currentUser!.uid;

    final newComment = CommentModel(
      username: username ?? '',
      cmtId: commentId,
      createdOn: timestamp,
      thumbsUps: 0,
      commentDescription: _commentController.text,
      profilePic: profilePhoto,
    );
    await fire
        .collection('videos')
        .doc(videoId)
        .collection('comments')
        .doc(commentId)
        .set(newComment.toMap());

    //
    FirebaseHelper.updateDataToNotification(
      othUid: videoId.substring(0, 27),
      message: 'comment',
      comDes: _commentController.text,
    );
    _commentController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(children: [
            Expanded(
              child: StreamBuilder(
                stream: fire
                    .collection('videos')
                    .doc(videoId)
                    .collection('comments')
                    .orderBy('createdOn', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData) {
                      final commentQuerySnap = snapshot.data as QuerySnapshot;
                      if (commentQuerySnap.docs.isEmpty) {
                        return const Center(
                          child: Text(
                              'no comments to show be the first to comment...'),
                        );
                      }
                      return ListView.builder(
                        itemCount: commentQuerySnap.docs.length,
                        itemBuilder: (context, index) {
                          final commentDocData = commentQuerySnap.docs[index]
                              .data() as Map<String, dynamic>;
                          if (commentQuerySnap.docs.isEmpty) {
                            return const Center(
                              child:
                                  Text('no comments, be the first to comment.'),
                            );
                          }
                          return CommentListTile(
                            commentDocData: commentDocData,
                            videoId: videoId,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Text('error');
                    } else {
                      return const Text('no comments to show');
                    }
                  }
                },
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor.withAlpha(50),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'looking good !',
                  labelText: 'comment',
                  suffixIcon: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      addComment(videoId);
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
