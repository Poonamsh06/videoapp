import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final fire = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
final store = FirebaseStorage.instance;

const kNormalSizeTextStyle = TextStyle(
  fontSize: 20,
);

const kNormalSizeBoldTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const kSmallSizeTextStyle = TextStyle(
  fontSize: 15,
);

const kVerySmallSizeTextStyle = TextStyle(
  fontSize: 12,
  color: Colors.grey,
);

const kSmallSizeBoldTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const kBigSizeTextStyle = TextStyle(
  fontSize: 25,
);

const kBigSizeBoldTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

//////////////////////////////  primary  ///////////////////////////

const kPNormalSizeTextStyle = TextStyle(
  fontSize: 20,
  color: Color.fromARGB(255, 236, 129, 255),
);

const kPNormalSizeBoldTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 236, 129, 255),
);

const kPSmallSizeTextStyle = TextStyle(
  fontSize: 15,
  color: Color.fromARGB(255, 236, 129, 255),
);

const kPVerySmallSizeTextStyle = TextStyle(
  fontSize: 12,
  color: Color.fromARGB(255, 236, 129, 255),
);

const kPSmallSizeBoldTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 236, 129, 255),
);

const kPBigSizeTextStyle = TextStyle(
  fontSize: 25,
  color: Color.fromARGB(255, 236, 129, 255),
);

const kPBigSizeBoldTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 236, 129, 255),
);

//////////////////////////////  white  ///////////////////////////

const kWNormalSizeTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
);

const kWNormalSizeBoldTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const kWSmallSizeBoldTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kWSmallSizeTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.white,
);

const kWSmallBoldSizeTextStyle = TextStyle(
  fontSize: 15,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const kWBigSizeTextStyle = TextStyle(
  fontSize: 25,
  color: Colors.white,
);

const kWBigSizeBoldTextStyle = TextStyle(
  fontSize: 25,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
