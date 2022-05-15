import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              // backgroundColor: Colors.amber,
              elevation: 10,
              pinned: true,
              forceElevated: true,
              floating: false,
              title: const Text('Appbar'),
              expandedHeight: size.width,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.fadeTitle,
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground,
                ],
                background: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        'assests/girl.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      // bottom: 100,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              Text(
                                'sangamesh k ',
                                style: kWBigSizeBoldTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              toolbarHeight: 60,
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                  color: Colors.black,
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [const Text('HEY SAN', style: TextStyle(fontSize: 550))],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           children: const [
//                             Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: CircleAvatar(
//                                 radius: 40,
//                                 backgroundImage: NetworkImage(
//                                   "https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?cs=srgb&dl=pexels-pixabay-60597.jpg&fm=jpg",
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               'sangamesh k ',
//                               style: kBigSizeBoldTextStyle,
//                             )
//                           ],
//                         ),


//  body :Center(
//         child: ElevatedButton(
//           child: const Text('logout'),
//           onPressed: () async {
//             await auth.signOut();
//             await GoogleSignIn().signOut();
//             Get.offAll(Signin());
//           },
//         ),
//       )

