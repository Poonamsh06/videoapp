import 'package:biscuit1/views/profile/profile_screen.dart';
import 'package:biscuit1/views/profile/utils/profileComponents.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utilities/constants.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
    required this.notiDocData,
  }) : super(key: key);

  final Map<String, dynamic> notiDocData;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withAlpha(100),
        backgroundImage: NetworkImage(notiDocData['profilePic']),
      ),
      title: RichText(
          text: TextSpan(
        text: '',
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: notiDocData['username'],
            style: kPSmallSizeBoldTextStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.to(() => ProfileScreen(uid: notiDocData['notId']));
              },
          ),
        ],
      )),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              '${DateFormat.yMd().format(DateTime.parse(notiDocData['createdOn']))}  ',
              style: kVerySmallSizeTextStyle,
            ),
          ),
          const FollowButton(othUid: 'othUid'),
        ],
      ),
      children: [
        if (notiDocData['commentDescription'] != '')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              notiDocData['commentDescription'],
              style: kSmallSizeTextStyle,
            ),
          ),
      ],
    );
  }
}
