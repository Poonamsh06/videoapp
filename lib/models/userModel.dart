import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? profilepic;
  String? email;
  String? phone;
  String? aboutme;
  bool success = false;
  bool isprofilecomplete = false;

  UserModel({
    required this.uid,
    required this.name,
    required this.profilepic,
    required this.email,
    required this.phone,
    required this.aboutme,
    required this.success,
    required this.isprofilecomplete,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'profilepic': profilepic,
      'email': email,
      'phone': phone,
      'aboutme': aboutme,
      'success': success,
      'isprofilecomplete': isprofilecomplete,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    name = map['name'];
    profilepic = map['profilepic'];
    email = map['email'];
    phone = map['phone'];
    aboutme = map['aboutme'];
    success = map['success'];
    isprofilecomplete = map['isprofilecomplete'];
  }

  static UserModel fromSnapShot(DocumentSnapshot snapshot) {
    final snapData = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapData['uid'],
      name: snapData['name'],
      profilepic: snapData['profilepic'],
      email: snapData['email'],
      phone: snapData['phone'],
      aboutme: snapData['aboutme'],
      success: snapData['success'],
      isprofilecomplete: snapData['isprofilecomplete'],
    );
  }
}
