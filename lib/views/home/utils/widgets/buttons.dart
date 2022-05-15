import 'package:biscuit1/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';

import '../../comment_screen.dart';

class Like {
  late String videoId;

  Padding customLikeButton(String videoIdRec, bool like) {
    videoId = videoIdRec;
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: LikeButton(
        size: 90,
        onTap: onLikeButtonTapped,
        circleColor: const CircleColor(start: Colors.red, end: Colors.red),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Colors.red,
          dotSecondaryColor: Colors.red,
        ),
        likeBuilder: (like) {
          return Icon(
            like ? Icons.favorite : Icons.favorite_border_outlined,
            color: like ? Colors.red : Colors.grey,
            size: 40,
          );
        },
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    final userId = auth.currentUser!.uid;
    final DocumentSnapshot likedSnap = await fire
        .collection('videos')
        .doc(videoId)
        .collection('like')
        .doc(userId)
        .get();

    final videoDocSnap = await fire.collection('videos').doc(videoId).get();
    final videoData = videoDocSnap.data() as Map<String, dynamic>;

    if (likedSnap.exists) {
      await fire.runTransaction((Transaction myTransaction) async {
        myTransaction.delete(fire
            .collection('videos')
            .doc(videoId)
            .collection('like')
            .doc(userId));
      });
      videoData['isLiked'] = false;
      fire.collection('videos').doc(videoId).set(videoData);
      return false;
    } else {
      fire
          .collection('videos')
          .doc(videoId)
          .collection('like')
          .doc(userId)
          .set({'user': auth.currentUser!.uid});
      videoData['isLiked'] = true;
      fire.collection('videos').doc(videoId).set(videoData);
      return true;
    }
  }
}

buildProfileImage(String profilePhotoUrl) {
  return SizedBox(
    width: 60,
    height: 60,
    child: Stack(
      children: [
        Positioned(
          left: 5,
          child: Container(
            padding: const EdgeInsets.all(1),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white, width: 1.6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                profilePhotoUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 4,
          left: 20,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              size: 21,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget commentButton(String id) {
  return IconButton(
    onPressed: () {
      Get.to(CommentScreen(
        videoId: id,
      ));
    },
    icon: const Icon(
      Icons.comment,
      size: 35,
      color: Colors.grey,
    ),
  );
}

Padding shareButton(String url) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: IconButton(
      onPressed: () async {
        final uid = auth.currentUser!.uid;
        final urlpreview = url;
        if (uid.isEmpty) {
          //playstore link
          // log("play store link");
        } else {
          await Share.share(
              "download and enjoy Biscuit app shorts ❤️  \n\n$urlpreview");
        }
      },
      icon: const Icon(
        Icons.share_rounded,
        size: 35,
        color: Colors.grey,
      ),
    ),
  );
}

buildMusicAlbum(String imageUrl) {
  return SizedBox(
    width: 60,
    height: 60,
    child: Column(
      children: [
        Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(colors: [
              Colors.grey,
              Colors.white,
            ]),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}

likeTheCommentButton(String videoId) {
  return IconButton(
    icon: const Icon(Icons.thumb_up_alt),
    onPressed: () async {
      fire
          .collection('videos')
          .doc(videoId)
          .collection('comments')
          .doc(auth.currentUser!.uid)
          .collection('thumbsUps')
          .doc(auth.currentUser!.uid)
          .set({'user': auth.currentUser!.uid});
    },
  );
}
