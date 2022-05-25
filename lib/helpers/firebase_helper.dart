import 'package:biscuit1/models/videoModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

import '../models/notifyModel.dart';
import '../models/userModel.dart';
import '../utilities/constants.dart';
import '../utilities/myDialogBox.dart';
import '../views/auth_page.dart';

class FirebaseHelper {
  //

  static void logOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    await Get.offAll(Signin());
  }

  static Future<UserModel?> fetchUserDetailsByUid({
    required String uid,
    bool? no,
  }) async {
    //
    if (no == null) MyDialogBox.loading();
    final DocumentSnapshot userDocumentSnapshot =
        await fire.collection('users').doc(uid).get();

    if (!userDocumentSnapshot.exists) return null;

    final userData = userDocumentSnapshot.data() as Map<String, dynamic>;

    final fetchedUserModel = UserModel(
      uid: uid,
      name: userData['name'],
      profilepic: userData['profilepic'],
      email: userData['email'],
      phone: userData['phone'],
      aboutme: userData['aboutme'],
      success: userData['success'],
      followers: userData['followers'],
      following: userData['following'],
      isprofilecomplete: userData['isprofilecomplete'],
    );
    if (no == null) Get.back();
    return fetchedUserModel;
  }

  static Future<VideoModel?> fetchVideoDetailsByVideoId({
    required String videoID,
    bool? no,
  }) async {
    //
    final DocumentSnapshot videoDocSnap =
        await fire.collection('videos').doc(videoID).get();

    if (!videoDocSnap.exists) return null;

    final fetchedVideoModel = VideoModel.fromSnapshot(videoDocSnap);
    return fetchedVideoModel;
  }

  static Future<bool?> fetchDataAboutUserStatus(String uid) async {
    MyDialogBox.loading();
    final UserModel? fetchedUserModel =
        await FirebaseHelper.fetchUserDetailsByUid(uid: uid);
    Get.back();
    if (fetchedUserModel == null) return null;

    final bool isUserVerified = fetchedUserModel.success;
    if (isUserVerified) {
      return true;
    } else {
      return false;
    }
  }

  static updateDataToNotification({
    required String othUid,
    required String message,
    required String comDes,
  }) async {
    String finalId = othUid;
    if (message == 'comment' || message == 'like') {
      finalId = othUid.trim().substring(0, 28);
    }

    final myModel = await fetchUserDetailsByUid(uid: auth.currentUser!.uid);
    if (myModel == null) return;

    final uuid = const Uuid().v1();
    // ================= notification ==========
    final timestamp = DateTime.now();
    final otherUserData = await fetchUserDetailsByUid(uid: finalId, no: true);
    if (otherUserData == null) return;

    final otherNoti = NotifyModel(
      username: myModel.name!,
      notId: myModel.uid!,
      createdOn: timestamp.toIso8601String(),
      commentDescription: comDes,
      message: message,
      profilePic: myModel.profilepic!,
      videoId: message == 'follow' ? '' : othUid,
    );

    fire
        .collection('users')
        .doc(finalId)
        .collection('notifications')
        .doc('${auth.currentUser!.uid}$uuid')
        .set(otherNoti.toMap());
  }
}
