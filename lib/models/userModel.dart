import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? aboutme;
  String? profilepic;
  int followers = 0;
  int following = 0;
  bool success = false;
  bool isprofilecomplete = false;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.aboutme,
    required this.profilepic,
    required this.followers,
    required this.following,
    required this.success,
    required this.isprofilecomplete,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'aboutme': aboutme,
      'profilepic': profilepic,
      'followers': followers,
      'following': following,
      'success': success,
      'isprofilecomplete': isprofilecomplete,
    };
  }

  List<String> toList() {
    return [
      uid ?? '',
      name ?? '',
      email ?? '',
      phone ?? '',
      aboutme ?? '',
      profilepic ?? '',
      followers.toString(),
      following.toString(),
      success.toString(),
      isprofilecomplete.toString(),
    ];
  }

  // UserModel.fromList(List<String> userModelList) {
  //   return UserModel(
  //     uid: userModelList[0],
  //     name: userModelList[1],
  //     email: userModelList[2],
  //     phone: userModelList[3],
  //     aboutme: userModelList[4],
  //     profilepic: userModelList[5],
  //     followers: int.parse(userModelList[6]),
  //     following: int.parse(userModelList[7]),
  //     success: userModelList[8].toLowerCase() == 'true',
  //     isprofilecomplete: userModelList[9].toLowerCase() == 'true',
  //   );
  // }

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    aboutme = map['aboutme'];
    profilepic = map['profilepic'];
    followers = map['followers'];
    following = map['following'];
    success = map['success'];
    isprofilecomplete = map['isprofilecomplete'];
  }

  static UserModel fromSnapShot(DocumentSnapshot snapshot) {
    final snapData = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapData['uid'],
      name: snapData['name'],
      email: snapData['email'],
      phone: snapData['phone'],
      aboutme: snapData['aboutme'],
      profilepic: snapData['profilepic'],
      followers: snapData['followers'],
      following: snapData['following'],
      success: snapData['success'],
      isprofilecomplete: snapData['isprofilecomplete'],
    );
  }
}
