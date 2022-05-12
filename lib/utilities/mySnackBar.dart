// import 'package:biscuit/utilities/constants.dart';
// import 'package:flutter/material.dart';

// class MySnackBar {
//   static void showBottomSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         padding: const EdgeInsets.all(0),
//         content: Container(
//           height: 100,
//           padding: const EdgeInsets.all(10),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromRGBO(143, 148, 251, 1),
//                 Color.fromRGBO(143, 148, 251, 0.6),
//               ],
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(50.0)),
//           ),
//           child: Text(
//             message,
//             style: kSmallSizeTextStyle.copyWith(color: Colors.black
//                 // color: Theme.of(context).primaryColor,
//                 ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         duration: const Duration(seconds: 71),
//       ),
//     );
//   }
// }
