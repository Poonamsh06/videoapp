import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/Auth/google_auth_controller.dart';
import '../utilities/customButton.dart';
import 'auth/email_auth_screen.dart';
import 'auth/phone_auth_screen.dart';

class Signin extends StatelessWidget {
  var check = false.obs;
  final GoogleAuthController controller = Get.put(GoogleAuthController());
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: deviceSize.height * 0.5,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assests/background.png'),
                    fit: BoxFit.fill)),
            child: Stack(
              children: <Widget>[
                Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assests/light-1.png'))),
                    )),
                Positioned(
                  left: 140,
                  width: 80,
                  height: 150,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assests/light-2.png'))),
                  ),
                ),
                Positioned(
                  right: 40,
                  top: 40,
                  width: 80,
                  height: 150,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assests/clock.png'))),
                  ),
                ),
                Positioned(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: const Center(
                      child: Text(
                        "Biscuit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Column(children: <Widget>[
              Obx(
                () => check == true
                    ? fixed_container(350.0)
                    : fixed_container(200.0),
              )
            ]),
          ),
          Obx(
            () => check == false
                ? const Padding(
                    padding: EdgeInsets.fromLTRB(40, 5, 40, 0),
                    child: Divider(
                      height: 50,
                      color: Color.fromARGB(255, 195, 189, 201),
                      thickness: 0,
                    ),
                  )
                : const SizedBox(),
          ),
          Obx(() => check == false
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        // controller: controller,
                        title: "Google",
                        icon: FontAwesomeIcons.google,
                        onPressed: () => controller.loginWithGoogle(),
                        // onPressed: () => FirebaseHelper.logOut(),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CustomButton(
                        // controller: controller,
                        title: "Email",
                        icon: FontAwesomeIcons.envelope,
                        onPressed: () {
                          check.value = true;
                          // Get.to(() => EmailAuthScreen());
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox())
        ],
      )),
    );
  }

  SingleChildScrollView fixed_container(double height) {
    return SingleChildScrollView(
      child: Container(
        height: height,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(143, 148, 251, .2),
                  blurRadius: 20.0,
                  offset: Offset(0, 10))
            ]),
        child: Obx(
          (() => check == true
              ? EmailAuthScreen()
              : PhoneAuthScreen(isVerify: false)),
        ),
      ),
    );
  }
}
