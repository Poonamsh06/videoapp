import 'dart:developer';

import 'package:VMedia/controllers/Auth/email_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/firebase_helper.dart';
import '../../models/userModel.dart';
import '../../utilities/constants.dart';
import '../../views/home.dart';

class GoogleAuthController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  UserModel? userModel;

  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      if (userCredential.user == null) return;

      final user = userCredential.user;
      final beforeUserModel = await checkWhetherUserIsPresent(user!);

      if (beforeUserModel == null) {
        userModel = UserModel(
          uid: user.uid,
          name: '',
          profilepic: '',
          email: user.email,
          phone: '',
          aboutme: '',
          followers: 0,
          following: 0,
          success: true,
          isprofilecomplete: false,
        );

        await EmailController.uploadUserDataToFirestore(user, userModel!);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setStringList('listOfMyModel', userModel!.toList());
      } else {
        await EmailController.uploadUserDataToFirestore(user, beforeUserModel);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setStringList('listOfMyModel', beforeUserModel.toList());
      }

      Get.offAll(() => Home(user: user));
    } catch (e) {
      log('=================error====================$e');
    }
  }

  static Future<UserModel?> checkWhetherUserIsPresent(User user) async {
    final fetchedUserModel =
        await FirebaseHelper.fetchUserDetailsByUid(uid: user.uid);
    if (fetchedUserModel == null) return null;

    final fetId = user.uid;
    final fetName = fetchedUserModel.name;
    final fetEmail = fetchedUserModel.email;
    final fetPhone = fetchedUserModel.phone;
    final fetAboutMe = fetchedUserModel.aboutme;
    final fetProfilePic = fetchedUserModel.profilepic;
    final fetSuccess = fetchedUserModel.success;
    final fetIsProfileComplete = fetchedUserModel.isprofilecomplete;

    final newUserModel = UserModel(
      uid: fetId,
      name: fetName,
      profilepic: fetProfilePic,
      email: fetEmail,
      phone: fetPhone,
      aboutme: fetAboutMe,
      followers: 0,
      following: 0,
      success: fetSuccess,
      isprofilecomplete: fetIsProfileComplete,
    );

    return newUserModel;
  }
}
