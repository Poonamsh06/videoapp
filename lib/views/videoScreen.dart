import 'package:biscuit1/controllers/Video/videoController.dart';
import 'package:biscuit1/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/circleVideoAnimation.dart';
import '../Widgets/videoPlayerItem.dart';
import '../utilities/home_component/buttons.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhotoUrl) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Stack(
          children: [
            Positioned(
              left: 5,
              child: Container(
                padding: const EdgeInsets.all(1),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white, width: 1.6),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    profilePhotoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 4,
              left: 20,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  size: 21,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildMusicAlbum(String imageUrl) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(colors: [
                Colors.grey,
                Colors.white,
              ]),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videos.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final videoData = videoController.videos[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: videoData.videoUrl),
                Column(
                  children: [
                    const SizedBox(height: 100),
                    Expanded(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            // color: Colors.pink,
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  videoData.username,
                                  style: kNormalSizeTextStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  videoData.videoName,
                                  style: kSmallSizeTextStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.music_note_rounded,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      videoData.description,
                                      style: kWSmallSizeTextStyle.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          // color: Colors.pink,
                          margin: EdgeInsets.only(top: size.height * 0.2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildProfile(videoData.profilePhoto),
                              Custom_likeButton(),
                              // Text(videoData.likes.toString()),
                              comment_button(),
                              Text(videoData.commentCount.toString()),
                              share_button(),
                              const SizedBox(height: 20),
                              CircleVideoAnimation(
                                child: buildMusicAlbum(videoData.profilePhoto),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                )
              ],
            );
          },
        );
      }),
    );
  }

 
}
