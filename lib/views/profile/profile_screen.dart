import 'package:biscuit1/models/userModel.dart';
import 'package:biscuit1/utilities/myDialogBox.dart';
import 'package:biscuit1/views/home.dart';
import 'package:biscuit1/views/profile/utils/profileComponents.dart';
import 'package:biscuit1/views/profile/utils/videoPopUpScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  UserModel? um;
  bool _done = false;

  List<String> tags = [
    "travel",
    "urban",
    "fashion",
    "LifeStyle",
  ];

  void logOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    await Get.offAll(Signin());
  }

  fetchAndSetData() async {
    if (widget.uid == auth.currentUser!.uid) {
      Get.offAll(() => Home(user: auth.currentUser!));
    } else {
      final usermodel = await FirebaseHelper.fetchUserDetailsByUid(
        uid: widget.uid == '' ? userID : widget.uid,
        no: true,
      );
      if (usermodel == null) return;
      setState(() {
        um = usermodel;
        _done = true;
      });
    }
    updateDataEveryWhere();
  }

  String myName = '',
      myAbout = '',
      myflwrs = '...',
      myfwlng = '...',
      myVidTitle = '',
      othUid = '';

  void updateDataEveryWhere() {
    if (_done) {
      setState(() {
        myName = um!.name ?? '';
        myAbout = um!.aboutme ?? '';
        myflwrs = um!.followers.toString();
        myfwlng = um!.following.toString();
        othUid = um!.uid ?? '';
        myVidTitle = widget.uid == ''
            ? ' My Collections'
            : ' ${um!.name}\'s collections';
      });
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1))
        .then((value) => fetchAndSetData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: _done
            ? CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () => logOut(),
                      ),
                    ],
                    expandedHeight:
                        size.width * 0.7, //heignt of the profile section
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.fadeTitle,
                        StretchMode.blurBackground,
                        StretchMode.zoomBackground,
                      ],
                      background: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 100),
                              //name section =========================================
                              NameSection(done: _done, um: um),
                              //followiing section ===================================
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildFollowTile('followers', othUid),
                                    horDivider(),
                                    buildFollowTile('following', othUid),
                                    if (widget.uid != '') horDivider(),
                                    if (widget.uid != '')
                                      FollowButton(othUid: othUid),
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
                                  isEqualTo:
                                      widget.uid == '' ? userID : widget.uid)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.horizontal_rule_rounded),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        myVidSnap.docs.isEmpty
                                            ? ''
                                            : myVidTitle,
                                        textAlign: TextAlign.start,
                                        style: kNormalSizeBoldTextStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: size.height - 160,
                                      child: myVidSnap.docs.isEmpty
                                          ? const Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 400),
                                                child: Text(
                                                    'no videos uploaded yet'),
                                              ),
                                            )
                                          : GridView.builder(
                                              padding: const EdgeInsets.only(
                                                  left: 2,
                                                  bottom: 350,
                                                  right: 2,
                                                  top: 2),
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
                                                  onTap: () => VideoPopUpScreen
                                                      .showVideo(
                                                          context, myVidData),
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
              )
            : MyDialogBox.loadingScreen(),
      ),
    );
  }
}
