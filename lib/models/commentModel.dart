import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String username;
  String cmtId;
  String createdOn;
  int thumbsUps;
  String commentDescription;
  String profilePic;

  CommentModel({
    required this.username,
    required this.cmtId,
    required this.createdOn,
    required this.thumbsUps,
    required this.commentDescription,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'cmtId': cmtId,
      'thumbsUps': thumbsUps,
      'commentDescription': commentDescription,
      'createdOn': createdOn,
      'profilePic': profilePic,
    };
  }

  static CommentModel fromSnapshot(DocumentSnapshot documentSnapshot) {
    final snapData = documentSnapshot.data() as Map<String, dynamic>;
    return CommentModel(
      username: snapData['username'],
      cmtId: snapData['cmtId'],
      thumbsUps: snapData['thumbsUps'],
      commentDescription: snapData['commentDescription'],
      createdOn: snapData['createdOn'],
      profilePic: snapData['profilePic'],
    );
  }
}
