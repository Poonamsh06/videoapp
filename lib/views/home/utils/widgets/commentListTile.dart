import 'package:biscuit1/views/home/utils/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../utilities/constants.dart';
import '../builders/commentLikesCountBuilder.dart';

class CommentListTile extends StatelessWidget {
  const CommentListTile({
    Key? key,
    required this.commentDocData,
    required this.videoId,
  }) : super(key: key);

  final Map<String, dynamic> commentDocData;
  final String videoId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withAlpha(100),
        backgroundImage: NetworkImage(commentDocData['profilePic']),
      ),
      title: Row(
        children: [
          Text(
            commentDocData['username'],
            style: kSmallSizeBoldTextStyle,
          ),
          const Spacer(),
          Text(
            DateFormat.yM().format(DateTime.parse(commentDocData['createdOn'])),
            style: kVerySmallSizeTextStyle,
          ),
          likeTheCommentButton(videoId),
          CommentBuilder(videoId: videoId),
        ],
      ),
      subtitle: Text(
        commentDocData['commentDescription'],
      ),
    );
  }
}
