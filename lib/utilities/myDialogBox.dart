import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class MyDialogBox {
  static void normalDialog() {
    showDefaultDialog(
      'OOPS',
      'sorry, something went wrong please try again after some time while we resolve your issue.',
    );
  }

  static void showDefaultDialog(String title, String midText) {
    Get.defaultDialog(
      title: title,
      titleStyle: kBigSizeBoldTextStyle.copyWith(
        color: Colors.blue,
      ),
      middleText: midText,
      titlePadding: const EdgeInsets.only(top: 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      confirm: ElevatedButton.icon(
        icon: const Icon(Icons.check),
        onPressed: () => Get.back(),
        label: const Text(
          'OK',
          style: kNormalSizeTextStyle,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 7,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  static void loading({String message = 'loading...'}) {
    Get.dialog(Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          width: 200,
          height: 105,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: kNormalSizeTextStyle.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  static void showConfirmDialogBox({
    required String message,
    required noFun,
    required String noName,
    required yesFun,
    required String yesName,
  }) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(10),
      middleText: message,
      middleTextStyle: kSmallSizeBoldTextStyle,
      title: 'OOPS',
      titleStyle: kBigSizeBoldTextStyle.copyWith(
        color: Colors.blue,
      ),
      titlePadding: const EdgeInsets.only(top: 10),
      confirm: ElevatedButton.icon(
        icon: const Icon(Icons.check),
        onPressed: yesFun,
        label: Text(
          yesName,
          style: kNormalSizeTextStyle,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 7,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      cancel: ElevatedButton.icon(
        icon: const Icon(Icons.close),
        onPressed: noFun,
        label: Text(
          noName,
          style: kNormalSizeTextStyle,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 7,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  static void showConfirmDialog({
    required BuildContext context,
    required String heading,
    required leftFun,
    required String liName,
    required rightFun,
    required String riName,
    String? content,
  }) {
    showDialog(
      barrierColor: Theme.of(context).colorScheme.secondary.withAlpha(100),
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          heading,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        content: content != null ? Text(content) : null,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: leftFun,
                child: Text(liName),
              ),
              TextButton(
                onPressed: rightFun,
                child: Text(riName),
              ),
            ],
          )
        ],
      ),
    );
  }
}



// Get.defaultDialog(
//   title: title,
//   titleStyle: kBigSizeBoldTextStyle.copyWith(
//     color: Colors.blue,
//   ),
//   content: const CircularProgressIndicator(),
//   barrierDismissible: true,
// );