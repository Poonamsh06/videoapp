import 'package:biscuit1/views/home/widgets/buttons.dart';
import 'package:biscuit1/views/home/widgets/circleVideoAnimation.dart';
import 'package:biscuit1/views/home/widgets/videoPlayerItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: fire.collection('videos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              final QuerySnapshot snapData = snapshot.data as QuerySnapshot;
              if (snapData.docs.isEmpty) {
                return const Center(child: Text('no videos to show.'));
              } else {
                return PageView.builder(
                  itemCount: snapData.docs.length,
                  controller:
                      PageController(initialPage: 0, viewportFraction: 1),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final videoData =
                        snapData.docs[index].data() as Map<String, dynamic>;
                    return Stack(
                      children: [
                        VideoPlayerItem(videoUrl: videoData['videoUrl']),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: size.width * 0.70,
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    videoData['videoName'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    videoData['description'],
                                    style: const TextStyle(
                                      overflow: TextOverflow.fade,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person_sharp,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        videoData['username'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              margin: EdgeInsets.only(top: size.height * 0.4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //
                                  buildProfileImage(videoData),
                                  //
                                  Like().customLikeButton(
                                    videoData['id'],
                                    videoData['isLiked'],
                                  ),
                                  //
                                  Text(videoData['likes'].toString()),
                                  //
                                  const SizedBox(height: 10),
                                  commentButton(videoData['id']),
                                  //
                                  Text(videoData['commentCount'].toString()),
                                  //
                                  shareButton(videoData['videoUrl']),
                                  //
                                  const SizedBox(height: 20),
                                  CircleVideoAnimation(
                                    child: buildMusicAlbum(
                                      videoData['profilePhoto'],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              }
            } else if (snapshot.hasError) {
              return const Text('error');
            } else {
              return const Text('nothing to show');
            }
          }
        },
      ),
    );
  }
}
