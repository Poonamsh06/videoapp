import 'package:cloud_firestore/cloud_firestore.dart';

class NotifyModel {
  String username;
  String notId;
  String createdOn;
  String message;
  String commentDescription;
  String profilePic;

  NotifyModel({
    required this.username,
    required this.notId,
    required this.message,
    required this.createdOn,
    required this.commentDescription,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'notId': notId,
      'message': message,
      'commentDescription': commentDescription,
      'createdOn': createdOn,
      'profilePic': profilePic,
    };
  }

  static NotifyModel fromSnapshot(DocumentSnapshot documentSnapshot) {
    final snapData = documentSnapshot.data() as Map<String, dynamic>;
    return NotifyModel(
      username: snapData['username'],
      notId: snapData['notId'],
      message: snapData['message'],
      commentDescription: snapData['commentDescription'],
      createdOn: snapData['createdOn'],
      profilePic: snapData['profilePic'],
    );
  }
}
