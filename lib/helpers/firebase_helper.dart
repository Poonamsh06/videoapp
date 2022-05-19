import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/userModel.dart';
import '../utilities/constants.dart';
import '../utilities/myDialogBox.dart';

class FirebaseHelper {
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
}
