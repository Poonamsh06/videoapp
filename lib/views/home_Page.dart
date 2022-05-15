import 'dart:io';

import 'package:biscuit1/views/profile/Profile_page.dart';
import 'package:biscuit1/views/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/firebase_helper.dart';
import '../utilities/constants.dart';
import '../utilities/myDialogBox.dart';
import 'auth/profile_fill_up_screen.dart';
import 'home/add_video_screen.dart';
import 'home/video_screen.dart';
import 'notifications/mymyHome.dart';

class Home extends StatefulWidget {
  User user;
  Home({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currIndex = 0;
  XFile? _videoFile;

  final myPages = [
    const VideoScreen(),
    const ProfileScreen(),
    const Center(child: Text('add')),
    MyMyHome(),
    ProfilePage(),
  ];

  void pickVideo(ImageSource source) async {
    _videoFile = await ImagePicker().pickVideo(source: source);
    if (_videoFile == null) {
      return;
    }
    Get.to(AddVideoScreen(
      videoFile: File(_videoFile!.path),
      videoPath: _videoFile!.path,
    ));
  }

  void completeProfile() async {
    final fetchedUserModel =
        await FirebaseHelper.fetchUserDetailsByUid(widget.user.uid);
    if (fetchedUserModel == null) return;

    if (!fetchedUserModel.isprofilecomplete) {
      MyDialogBox.showConfirmDialogBox(
        message: 'hey, please complete your profile before adding videos',
        noFun: () => Get.back(),
        noName: 'No thanks',
        yesFun: () => Get.to(() => ProfileFillUpScreen(user: widget.user)),
        yesName: 'Complete',
      );
    } else {
      showVideoOptions();
    }
  }

  void showVideoOptions() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          ListTile(
            onTap: () => pickVideo(ImageSource.gallery),
            title: const Text(
              'add from gallery',
              style: kNormalSizeTextStyle,
            ),
            selectedColor: Theme.of(context).primaryColor,
            leading: const Icon(
              Icons.photo,
              size: 30,
            ),
          ),
          ListTile(
            onTap: () => pickVideo(ImageSource.camera),
            title: const Text(
              'create a new one',
              style: kNormalSizeTextStyle,
            ),
            selectedColor: Theme.of(context).primaryColor,
            leading: const Icon(
              Icons.add_a_photo,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(milliseconds: 500),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        height: 55,
        selectedIndex: _currIndex,
        onDestinationSelected: (newIndex) async {
          if (newIndex == 2) {
            completeProfile();
          } else {
            setState(() => _currIndex = newIndex);
          }
        },
        destinations: [
          navigation_destination(
              Icons.home_filled, Icons.home_outlined, "Home"),
          navigation_destination(
              FontAwesomeIcons.searchengin, Icons.search, "Search"),
          navigation_destination(Icons.photo_camera_back,
              Icons.video_camera_back_outlined, "Video"),
          navigation_destination(
              Icons.message, Icons.forum_outlined, "messages"),
          navigation_destination(Icons.person, Icons.person_outline, "Profile")
        ],
      ),
      body: myPages[_currIndex],
      // body: Scaffold(
      //   body: PageView.builder(
      //     itemCount: 10,
      //     controller: PageController(initialPage: 0, viewportFraction: 1),
      //     scrollDirection: Axis.vertical,
      //     itemBuilder: (context, index) => Stack(
      //       alignment: Alignment.bottomCenter,
      //       children: [
      //         Container(
      //           decoration: const BoxDecoration(
      //             image: DecorationImage(
      //               image: AssetImage("assests/demo-image.jpg"),
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ),
      //         Row(
      //           crossAxisAlignment: CrossAxisAlignment.end,
      //           children: [
      //             Expanded(
      //               flex: 3,
      //               child: Container(
      //                 height: MediaQuery.of(context).size.height / 4,
      //                 color: Colors.transparent,
      //               ),
      //             ),
      //             Expanded(
      //               child: SizedBox(
      //                 height: MediaQuery.of(context).size.height / 1.75,
      //                 child: Padding(
      //                   padding: const EdgeInsets.only(top: 90),
      //                   child: HomeSlideBar(),
      //                 ),
      //               ),
      //             )
      //           ],
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  NavigationDestination navigation_destination(
      IconData Sicon, IconData icon, String text) {
    return NavigationDestination(
      selectedIcon: Icon(Sicon),
      icon: Icon(icon),
      label: text,
    );
  }
}
