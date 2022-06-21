import 'dart:developer';

import 'package:biscuit1/models/userModel.dart';
import 'package:biscuit1/utilities/myDialogBox.dart';
import 'package:biscuit1/views/auth/profile_fill_up_screen.dart';
import 'package:biscuit1/views/profile/utils/profileComponents.dart';
import 'package:biscuit1/views/profile/utils/videoPopUpScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/firebase_helper.dart';
import '../../utilities/constants.dart';
import '../auth_page.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.uid}) : super(key: key);
  String uid;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //
  String userID = auth.currentUser!.uid;
  String shdPassUid = '';
  bool _done = false;
  bool isMe = true;

  List<String> tags = [
    "travel",
    "urban",
    "fashion",
    "LifeStyle",
  ];

  void setDataOfUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userModelList = prefs.getStringList('listOfMyModel');

    if (userModelList == null) {
      Get.off(Signin());
      return;
    }
    if (widget.uid == userModelList[0]) {
      //
      UserModel myModel = UserModel(
        uid: userModelList[0],
        name: userModelList[1],
        email: userModelList[2],
        phone: userModelList[3],
        aboutme: userModelList[4],
        profilepic: userModelList[5],
        followers: int.parse(userModelList[6]),
        following: int.parse(userModelList[7]),
        success: userModelList[8].toLowerCase() == 'true',
        isprofilecomplete: userModelList[9].toLowerCase() == 'true',
      );

      if (myModel.isprofilecomplete) {
        setState(() {
          shdPassUid = myModel.uid!;
          myName = myModel.name!;
          myAbout = myModel.aboutme!;
          myProfile = myModel.profilepic!;
          myflwrs = myModel.followers.toString();
          myfwlng = myModel.following.toString();
          myVidTitle = ' My Collections';
          _done = true;
          isMe = true;
        });
      } else {
        //if profile not complete =====================
        setState(() {
          shdPassUid = myModel.uid!;
          myName = '';
          myAbout = '';
          myProfile = '';
          myflwrs = '0';
          myfwlng = '0';
          myVidTitle = ' My Collections';
          _done = true;
          isMe = true;
        });
        MyDialogBox.showConfirmDialogBox(
          message: 'hey, please complete your profile before adding videos',
          noFun: () => Get.back(),
          noName: 'No thanks',
          yesFun: () => Get.to(
            () => ProfileFillUpScreen(user: auth.currentUser!),
          ),
          yesName: 'Complete',
        );
      }
    } else {
      final othUserModel = await FirebaseHelper.fetchUserDetailsByUid(
        uid: widget.uid == '' ? userID : widget.uid,
        no: true,
      );
      if (othUserModel == null) return;
      setState(() {
        shdPassUid = othUserModel.uid!;
        myName = othUserModel.name!;
        myAbout = othUserModel.aboutme!;
        myProfile = othUserModel.profilepic!;
        myflwrs = othUserModel.followers.toString();
        myfwlng = othUserModel.following.toString();
        log(myflwrs = othUserModel.followers.toString());
        log(myfwlng = othUserModel.following.toString());
        myVidTitle = ' ${othUserModel.name}\'s collections';
        _done = true;
        isMe = false;
        othUid = widget.uid;
      });
    }
  }

  String myName = '',
      myAbout = '',
      myProfile = '',
      myflwrs = '...',
      myfwlng = '...',
      myVidTitle = '',
      othUid = '';

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1)).then(
      (value) => setDataOfUser(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: !_done,
        child: Container(
          color: Colors.black,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                actions: [
                  if (isMe)
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () => FirebaseHelper.logOut(),
                    ),
                ],
                expandedHeight: size * 0.45, //heignt of the profile section
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.fadeTitle,
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground,
                  ],
                  background: SizedBox(
                    width: double.infinity,
                    // height: size,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // const SizedBox(height: 70),
                          const Spacer(),
                          //name section =========================================
                          NameSection(
                            name: myName,
                            about: myAbout,
                            profilePic: myProfile,
                          ),
                          //followiing section ===================================
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (_done)
                                  buildFollowTile('followers', shdPassUid),
                                if (!_done) const Text('...'),
                                horDivider(),
                                if (!_done) const Text('...'),
                                if (_done)
                                  buildFollowTile('following', shdPassUid),
                                if (!isMe) horDivider(),
                                if (!isMe) FollowButton(othUid: othUid),
                              ],
                            ),
                          ),
                          //tags Section =========================================
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 45,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: tags.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Chip(
                                      label: Text(
                                        tags[index],
                                        style: kWSmallSizeTextStyle,
                                      ),
                                      backgroundColor: Colors.grey.shade900,
                                      padding: const EdgeInsets.all(13),
                                      side: const BorderSide(
                                        width: 0.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    StreamBuilder(
                      stream: fire
                          .collection('videos')
                          .where('uid',
                              isEqualTo: widget.uid == '' ? userID : widget.uid)
                          .snapshots(),
                      //
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          final myVidSnap = snapshot.data as QuerySnapshot;

                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.horizontal_rule_rounded),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    myVidSnap.docs.isEmpty ? '' : myVidTitle,
                                    textAlign: TextAlign.start,
                                    style: kNormalSizeBoldTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: size - 160,
                                  child: myVidSnap.docs.isEmpty
                                      ? const Center(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 400),
                                            child:
                                                Text('no videos uploaded yet'),
                                          ),
                                        )
                                      : GridView.builder(
                                          padding: const EdgeInsets.only(
                                            left: 2,
                                            bottom: 350,
                                            right: 2,
                                            top: 2,
                                          ),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1,
                                            crossAxisSpacing: 2,
                                            mainAxisSpacing: 2,
                                          ),
                                          itemCount: myVidSnap.docs.length,
                                          itemBuilder: (context, index) {
                                            final myVidData =
                                                myVidSnap.docs[index].data()
                                                    as Map<String, dynamic>;

                                            return GestureDetector(
                                              onTap: () =>
                                                  VideoPopUpScreen.showVideo(
                                                context,
                                                myVidData,
                                              ),
                                              child: SizedBox(
                                                child: Image.network(
                                                  myVidData['thumbnailUrl'],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('error occured'));
                        } else {
                          return const Center(
                            child: Text('no videos uploaded yet'),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
