import 'package:biscuit1/views/profile/utils/videoPopUpScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utilities/constants.dart';

class VideoSectionBuilder extends StatelessWidget {
  VideoSectionBuilder({Key? key, required this.uid}) : super(key: key);
  //
  final String userID = auth.currentUser!.uid;
  final String uid;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final size =
        media.size.height - AppBar().preferredSize.height - media.padding.top;
    return StreamBuilder(
      stream: fire
          .collection('videos')
          .where('uid', isEqualTo: uid == '' ? userID : uid)
          .snapshots(),
      //
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final myVidSnap = snapshot.data as QuerySnapshot;

          return Container(
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
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    myVidSnap.docs.isEmpty ? '' : ' My Collections',
                    textAlign: TextAlign.start,
                    style: kNormalSizeBoldTextStyle,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: size - 160,
                  child: myVidSnap.docs.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 400),
                            child: Text('no videos uploaded yet'),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.only(
                              left: 2, bottom: 350, right: 2, top: 2),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                          ),
                          itemCount: myVidSnap.docs.length,
                          itemBuilder: (context, index) {
                            final myVidData = myVidSnap.docs[index].data()
                                as Map<String, dynamic>;

                            return GestureDetector(
                              onTap: () => VideoPopUpScreen.showVideo(
                                  context, myVidData),
                              child: Container(
                                color: Colors.pink,
                                // child: Image.network(
                                //   myVidData['thumbnailUrl'],
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('error occured'));
        } else {
          return const Center(
            child: Text('no videos uploaded yet'),
          );
        }
      },
    );
  }
}
