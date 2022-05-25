import 'package:biscuit1/utilities/constants.dart';
import 'package:biscuit1/views/home/widgets/my_Like_Btn.dart';
import 'package:biscuit1/views/profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';

import '../../home.dart';
import '../comment_screen.dart';

class Like {
  late String videoId;

  Padding customLikeButton(String videoIdRec, bool like) {
    videoId = videoIdRec;
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: LikeButton(
        isLiked: like,
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
            color: like ? Colors.red : Colors.white,
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
      await fire
          .collection('videos')
          .doc(videoId)
          .collection('like')
          .doc(userId)
          .delete();
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

      //
      MyLikeState.updateUsersNotification(videoId);
      return true;
    }
  }
}

buildProfileImage(Map<String, dynamic> videoData) {
  final profilePhotoUrl = videoData['profilePhoto'];
  final userId = videoData['id'].toString().substring(0, 28);
  return SizedBox(
    width: 55,
    height: 70,
    child: Stack(
      children: [
        Positioned(
          child: SizedBox(
            height: 55,
            child: ElevatedButton(
              onPressed: () => userId == auth.currentUser!.uid
                  ? Get.offAll(() => Home(user: auth.currentUser!))
                  : Get.to(() => ProfileScreen(uid: userId)),
              style: ElevatedButton.styleFrom(
                onPrimary: const Color.fromARGB(255, 0, 140, 255),
                primary: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 2.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  profilePhotoUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.add_circle,
              size: 25,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget commentButton(String id, Color? color) {
  return IconButton(
    onPressed: () {
      Get.to(CommentScreen(
        videoId: id,
      ));
    },
    icon: Icon(
      Icons.comment,
      size: 35,
      color: color ?? Colors.white,
    ),
  );
}

Widget shareButton(String url, Color? color) {
  return IconButton(
    focusColor: const Color.fromARGB(255, 0, 140, 255),
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
    icon: Icon(
      Icons.share_rounded,
      size: 35,
      color: color ?? Colors.white,
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
              Colors.white,
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
