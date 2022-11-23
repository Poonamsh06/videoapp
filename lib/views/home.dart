import 'dart:io';

import 'package:VMedia/models/userModel.dart';
import 'package:VMedia/views/notifications/notifiction_screen.dart';
import 'package:VMedia/views/search/search_screen.dart';
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
import 'profile/profile_screen.dart';

class Home extends StatefulWidget {
  User user;
  Home({
    Key? key,
    required this.user,
    this.recIndex,
  }) : super(key: key);
  int? recIndex = 0;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currIndex = 0;
  XFile? _videoFile;

  final myPages = [
    const VideoScreen(),
    const SearchScreen(),
    const Center(child: Text('add')),
    const NotificationScreen(),
    ProfileScreen(uid: auth.currentUser!.uid),
  ];

  UserModel? um;

  void pickVideo(ImageSource source) async {
    _videoFile = await ImagePicker().pickVideo(source: source);
    if (_videoFile == null) return;

    Get.to(AddVideoScreen(
      videoFile: File(_videoFile!.path),
      videoPath: _videoFile!.path,
    ));
  }

  void completeProfile() async {
    final fetchedUserModel =
        await FirebaseHelper.fetchUserDetailsByUid(uid: widget.user.uid);
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
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 10),
      title: 'Wanna add ?',
      titleStyle: kPNormalSizeBoldTextStyle,
      barrierDismissible: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      radius: 10,
      content: Column(
        children: [
          ListTile(
            onTap: () => pickVideo(ImageSource.gallery),
            title: const Text(
              'add from gallery',
              style: kNormalSizeTextStyle,
            ),
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
  void initState() {
    if (widget.recIndex != null) setState(() => _currIndex = widget.recIndex!);
    super.initState();
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
          navigationDestination(
            Icons.home,
            Icons.home_outlined,
            "Home",
          ),
          navigationDestination(
            FontAwesomeIcons.searchengin,
            Icons.search,
            "Search",
          ),
          navigationDestination(
            Icons.photo_camera_back,
            Icons.video_camera_back_outlined,
            "Video",
          ),
          navigationDestination(
            Icons.message,
            Icons.forum_outlined,
            "messages",
          ),
          navigationDestination(
            Icons.person,
            Icons.person_outline,
            "Profile",
          ),
        ],
      ),
      body: myPages[_currIndex],
    );
  }

  NavigationDestination navigationDestination(
      IconData sicon, IconData icon, String text) {
    return NavigationDestination(
      selectedIcon: Icon(sicon),
      icon: Icon(icon),
      label: text,
    );
  }
}
