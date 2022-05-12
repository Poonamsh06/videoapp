import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String username;
  String uid;
  String id;
  int likes;
  int commentCount;
  int shareCount;
  String videoName;
  String description;
  String videoUrl;
  String thumbnailUrl;
  String profilePhoto;

  VideoModel({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.videoName,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.profilePhoto,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'uid': uid,
      'id': id,
      'likes': likes,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'videoName': videoName,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'profilePhoto': profilePhoto,
    };
  }

  static VideoModel fromSnapshot(DocumentSnapshot documentSnapshot) {
    final snapData = documentSnapshot.data() as Map<String, dynamic>;
    return VideoModel(
      username: snapData['username'],
      uid: snapData['uid'],
      id: snapData['id'],
      likes: snapData['likes'],
      commentCount: snapData['commentCount'],
      shareCount: snapData['shareCount'],
      videoName: snapData['videoName'],
      description: snapData['description'],
      videoUrl: snapData['videoUrl'],
      thumbnailUrl: snapData['thumbnailUrl'],
      profilePhoto: snapData['profilePhoto'],
    );
  }
}
