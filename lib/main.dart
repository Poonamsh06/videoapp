import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/Auth/google_auth_controller.dart';
import 'views/auth_page.dart';
import 'views/home_Page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? currentUser = FirebaseAuth.instance.currentUser;
  // log(currentUser!.email.toString());
  // log(currentUser.phoneNumber.toString());

  if (currentUser != null) {
    log(currentUser.email.toString());
    runApp(MyApp(Home(user: currentUser)));
  } else {
    runApp(MyApp(Signin()));
  }
}

class MyApp extends StatelessWidget {
  MyApp(this.screen);
  dynamic screen;
  final GoogleAuthController controller = Get.put(GoogleAuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      title: 'To do app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home:  email == 'hello' ? Signin() : Home()
      // home: EmailVerificationScreen(),
      home: screen,
      // home: ProfileFillUpScreen(user: auth.currentUser!),
      getPages: [
        GetPage(name: '/', page: () => Signin()),
        // GetPage(name: '/homePage', page: () =>  Home(user: ,)),
        // Dynamic route
      ],
    );
  }
}


// git push --set-upstream origin email_auth/phone_auth