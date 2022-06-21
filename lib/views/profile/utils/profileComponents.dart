import 'package:biscuit1/helpers/firebase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utilities/constants.dart';

// ================================================================ NAME SECTION
class NameSection extends StatelessWidget {
  const NameSection({
    Key? key,
    required this.profilePic,
    required this.name,
    required this.about,
  }) : super(key: key);

  final String profilePic;
  final String name;
  final String about;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: CircleAvatar(
          radius: 45,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: profilePic != ''
                ? Image.network(profilePic)
                : const Icon(
                    Icons.account_circle_rounded,
                    size: 70,
                  ),
          ),
        ),
        title: Text(
          name,
          style: kWNormalSizeBoldTextStyle.copyWith(
            letterSpacing: 1.5,
          ),
        ),
        subtitle: Text(
          about,
          style: kWSmallSizeTextStyle,
        ),
        visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
      ),
    );
  }
}

// ============================================================= FOLLOW ROW TILE
// Column buildFollowTile(String title, String count) {
//   //
//      final folSnap = await fire
//         .collection('users')
//         .doc(widget.othUid)
//         .collection('followers')
//         .doc(auth.currentUser!.uid)
//         .get();

//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text(
//         count.toString(),
//         style: kWNormalSizeBoldTextStyle,
//       ),
//       Text(
//         title,
//         style: kWSmallSizeTextStyle,
//       ),
//     ],
//   );
// }

Column buildFollowTile(String title, String uid) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      StreamBuilder(
          stream:
              fire.collection('users').doc(uid).collection(title).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
//
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Text('...', style: kWNormalSizeBoldTextStyle));
              }
//
              final userSnap = snapshot.data as QuerySnapshot;
              final count = userSnap.docs.length;

              if (count == 0) {
                return const Text('0', style: kWNormalSizeBoldTextStyle);
              } else {
                return Text(
                  count.toString(),
                  style: kWNormalSizeBoldTextStyle,
                );
              }
//
            } else {
              return const Center(
                  child: Text('...', style: kWNormalSizeBoldTextStyle));
            }
          }),
      Text(
        title,
        style: kWSmallSizeTextStyle,
      ),
    ],
  );
}

// =============================================================== FOLLOW BUTTON
class FollowButton extends StatefulWidget {
  const FollowButton({
    Key? key,
    required this.othUid,
  }) : super(key: key);

  final String othUid;

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  //
  bool _isFollowing = false;

  getData() async {
    final folSnap = await fire
        .collection('users')
        .doc(widget.othUid)
        .collection('followers')
        .doc(auth.currentUser!.uid)
        .get();
    folSnap.exists ? setState(() => _isFollowing = true) : null;
  }

  follow() {
    fire //notify follower that someone is following him
        .collection('users')
        .doc(widget.othUid)
        .collection('followers')
        .doc(auth.currentUser!.uid)
        .set({'me': ''});
    setState(() => _isFollowing = true);

    fire //notify me that i am following someone
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('following')
        .doc(widget.othUid)
        .set({'me': ''});

    // send notification that someone is following
    //
    FirebaseHelper.updateDataToNotification(
      othUid: widget.othUid,
      message: 'follow',
      comDes: '',
    );
  }

  unfollow() {
    fire
        .collection('users')
        .doc(widget.othUid)
        .collection('followers')
        .doc(auth.currentUser!.uid)
        .delete();
    setState(() => _isFollowing = false);

    fire
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('following')
        .doc(widget.othUid)
        .delete();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1)).then((value) => getData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        gradient: const LinearGradient(
          colors: [Color(0xff4059f1), Color(0xff6d0eb5)],
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(33),
        onTap: () async {
          _isFollowing ? unfollow() : follow();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Text(
            _isFollowing ? 'Following' : 'Follow',
            style: kWSmallSizeBoldTextStyle,
          ),
        ),
      ),
    );
  }
}

// ================================================================= HOR DIVIDER
Container horDivider() {
  return Container(
    color: Colors.blue,
    width: 1,
    height: 22,
  );
}
// const Color.fromARGB(132, 255, 255, 255),
