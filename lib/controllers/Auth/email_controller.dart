
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/userModel.dart';
import '../../utilities/constants.dart';
import '../../utilities/myDialogBox.dart';

class EmailController {
  static Future<void> uploadUserDataToFirestore(
    User? user,
    UserModel recUserModel,
  ) async {
    if (user == null) return;

    MyDialogBox.loading(message: 'processing...');
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(recUserModel.toMap());
    } on FirebaseException catch (e) {
      Get.back();
      MyDialogBox.showDefaultDialog(e.code, e.message.toString());
    } catch (e) {
      Get.back();
      MyDialogBox.showDefaultDialog('OOPS', e.toString());
    }
    Get.back();
  }

  static Future<void> sendVerificationLink() async {
    Get.snackbar(
      "Thanks for logging in",
      "now please check your email, we sent you a link, tap that and verify yourself",
      icon: const Icon(Icons.person, color: Colors.black),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(76, 78, 104, 163),
      duration: const Duration(seconds: 5),
    );
    try {
      final user = auth.currentUser;
      await user!.sendEmailVerification();
      // hideBtn();
    } on FirebaseAuthException catch (e) {
      MyDialogBox.showDefaultDialog(
        e.code,
        e.message.toString(),
      );
    } catch (_) {
      MyDialogBox.normalDialog();
    }
  }
}
