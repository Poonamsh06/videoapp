import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/Auth/email_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/customButton.dart';
import '../../utilities/myDialogBox.dart';

class EmailVerificationScreen extends StatefulWidget {
  EmailVerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  String email;
  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool showBtn = true;
  int time = 0;
  bool isEmailVerified = false;
  Timer? _timer;
  Timer? timer10secs;

  final TextEditingController _emailController = TextEditingController();

  void _verifyFields() async {
    if (auth.currentUser != null) {
      await EmailController.sendVerificationLink();
      hideBtn();
      _timer = Timer.periodic(
        const Duration(seconds: 3),
        (timer) {
          checkEmailVerifiedOrNot();
        },
      );
    }
  }

  void checkEmailVerifiedOrNot() async {
    await auth.currentUser!.reload();
    setState(() => isEmailVerified = auth.currentUser!.emailVerified);
    if (isEmailVerified) {
      Get.back(result: true);
      MyDialogBox.showDefaultDialog(
        'Hurray !',
        'your email has been verified successfully, thankyou.',
      );
      _timer?.cancel();
    }
  }

  void hideBtn() async {
    setState(() => showBtn = false);
    for (int i = 0; i < 20; i++) {
      setState(() {
        time = 20 - i;
      });
      await Future.delayed(const Duration(seconds: 1));
    }
    setState(() => showBtn = true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'please verify your email',
                style: kBigSizeBoldTextStyle,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'email address',
                ),
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: showBtn
                    ? () {
                        FocusScope.of(context).unfocus();
                        _verifyFields();
                      }
                    : null,
                title: showBtn
                    ? 'send verification link'
                    : 'wait ${time.toString()} sec',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
