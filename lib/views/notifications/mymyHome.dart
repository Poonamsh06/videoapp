import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utilities/constants.dart';
import '../auth_page.dart';

class MyMyHome extends StatelessWidget {
  MyMyHome({Key? key}) : super(key: key);

  List<String> tags = [
    "travel",
    "urban",
    "fation",
    "LifeStyle",
  ];

  Future<void> _fun() async {
    log('triggered');
  }

  void logOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    Get.offAll(Signin());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: CustomScrollView(
          shrinkWrap: false,
          slivers: [
            SliverAppBar(
              surfaceTintColor: Colors.black,
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => logOut(),
                  ),
                ),
              ],
              stretchTriggerOffset: 100,
              onStretchTrigger: _fun,
              toolbarHeight: 60,
              elevation: 0,
              pinned: false,
              forceElevated: true,
              floating: false,
              expandedHeight: size.width * 0.8,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.fadeTitle,
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground,
                ],
                background: Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 100),
                        //name section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 28, top: 7),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                    "https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?cs=srgb&dl=pexels-pixabay-60597.jpg&fm=jpg"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 38.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Careen Page",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 17,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Text(
                                            "Delhi",
                                            style: TextStyle(
                                              color: Colors.white,
                                              wordSpacing: 2,
                                              letterSpacing: 4,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        //followiing section
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 38.0, left: 38, top: 15, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '17k',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    'followers',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Container(
                                color: Colors.white,
                                width: 0.2,
                                height: 22,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '387',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    'followers',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Container(
                                color: Colors.white,
                                width: 0.2,
                                height: 22,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 18, right: 18, top: 8, bottom: 8),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(33)),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff6d0eb5),
                                      Color(0xff4059f1)
                                    ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.centerLeft,
                                  ),
                                ),
                                child: const Text(
                                  'Follow',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )

                        //tags Section
                        ,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 44,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tags.length,
                              itemBuilder: ((context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              149, 255, 255, 255))),
                                  margin: const EdgeInsets.only(right: 13),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 13.0,
                                        bottom: 5,
                                        right: 20,
                                        left: 20),
                                    child: Text(
                                      tags[index],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Expanded(
                    child: Container(
                      // padding: const EdgeInsets.only(top: 30),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.horizontal_rule_rounded),
                              Icon(Icons.horizontal_rule_rounded),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // keyboard_double_arrow_down_rounded power_input_rounded reorder →supervised_user_circle_sharp swap_vertical_circle_outlined view_week_rounded wifi_1_bar_rounded →
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              ' My Collections',
                              style: kNormalSizeBoldTextStyle,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: size.height - 160,
                            child: GridView.builder(
                              padding: const EdgeInsets.only(
                                  left: 2, bottom: 350, right: 2, top: 2),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                                crossAxisSpacing: 2,
                                // mainAxisExtent: 40,
                                mainAxisSpacing: 2,
                              ),
                              itemBuilder: (context, index) => Container(
                                width: 100,
                                height: 100,
                                color: Colors.pink,
                                child: const Text('gdgsdfsds'),
                              ),
                              itemCount: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

buildVideoCard(int index) => Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'https://source.unsplash.com/random/?city,night$index',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
