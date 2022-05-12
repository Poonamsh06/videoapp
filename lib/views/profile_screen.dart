import 'package:biscuit1/utilities/constants.dart';
import 'package:biscuit1/views/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('logout'),
          onPressed: () async {
            await auth.signOut();
            await GoogleSignIn().signOut();
            Get.offAll(Signin());
          },
        ),
      ),
      // body: CustomScrollView(
      //   slivers: [
      //     const SliverAppBar(
      //       pinned: true,
      //       floating: true,
      //       snap: true,
      //       // title: Text('Appbar'),
      //       expandedHeight: 200,
      //       flexibleSpace: FlexibleSpaceBar(title: Text('hello there')),
      //     ),
      //     SliverList(
      //       delegate: SliverChildListDelegate(
      //         [const Text('HEY SAN', style: TextStyle(fontSize: 550))],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

// 


// Center(
//         child: ElevatedButton(
//           child: const Text('logout'),
//           onPressed: () async {
//             await auth.signOut();
//             await GoogleSignIn().signOut();
//             Get.offAll(Signin());
//           },
//         ),
//       )