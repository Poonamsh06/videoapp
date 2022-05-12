// import 'package:biscuit/controllers/Auth/phone_auth_controller.dart';
// import 'package:biscuit/utilities/constants.dart';
// import 'package:biscuit/utilities/reusable.dart';
// import 'package:biscuit/utilities/myDialogBox.dart';
// import 'package:flutter/material.dart';

// class PhoneVerificationScreen extends StatefulWidget {
//   PhoneVerificationScreen({
//     Key? key,
//     required this.phone,
//   }) : super(key: key);

//   String phone;
//   @override
//   State<PhoneVerificationScreen> createState() =>
//       _PhoneVerificationScreenState();
// }

// class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
//   final _otpController = TextEditingController();
//   final _phoneAuthController = PhoneController();

//   bool showBtn = true;
//   int ticktime = 20;

//   void hideBtn() async {
//     setState(() => showBtn = false);
//     for (int i = 20; i >= 0; i--) {
//       setState(() => ticktime = i);
//       await Future.delayed(const Duration(seconds: 1));
//     }
//     setState(() => showBtn = true);
//   }

//   void verifyPhoneNumber() async {
//     if (_otpController.text.length != 6) {
//       MyDialogBox.showDefaultDialog(
//         'NOTE',
//         'please enter the valid otp and verify yourself',
//       );
//       return;
//     }

//     _phoneAuthController.verifyPhoneNumberWithOtp(
//       otp: _otpController.text,
//       isForVerify: true,
//     );
//   }

//   void resendOtp() {
//     _phoneAuthController.verifyWithPhoneCredentials(widget.phone);
//     hideBtn();
//   }

//   @override
//   void dispose() {
//     _otpController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     _phoneAuthController.verifyWithPhoneCredentials(widget.phone);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(40),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'we have sent an otp to ${widget.phone}   please enter the otp you received and verify.',
//                 style: kBigSizeBoldTextStyle,
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'otp received',
//                 ),
//                 textInputAction: TextInputAction.done,
//                 keyboardType: TextInputType.number,
//                 controller: _otpController,
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                 title: 'verify number',
//                 onPressed: () => verifyPhoneNumber(),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text('didn\'t receive your email ? '),
//                   const SizedBox(width: 5),
//                   TextButton(
//                     onPressed: showBtn ? resendOtp : null,
//                     child: Text(showBtn ? 'resend' : ticktime.toString()),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
