import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/widgets/buttons.dart';
import '../../home/widgets/my_Like_Btn.dart';
import '../../home/widgets/videoPlayerItem.dart';

class VideoPopUpScreen extends StatelessWidget {
  const VideoPopUpScreen({Key? key, required this.videoUrl}) : super(key: key);

  final String videoUrl;

  static void showVideo(BuildContext context, Map<String, dynamic> vidData) {
    final height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final size = MediaQuery.of(context).size;
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5, left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                // width: size.width * 0.8,
                // height: size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.8,
                      height: height * 0.6,
                      child: VideoPlayerItem(videoUrl: vidData['videoUrl']),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: size.width * 0.8,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 25,
                            child: Text(
                              vidData['videoName'],
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                          const Spacer(),
                          //
                          MyLike(
                            isLike: vidData['isLiked'],
                            videoId: vidData['id'],
                          ),
                          //
                          commentButton(vidData['id'], Colors.purple),
                          //
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child:
                                shareButton(vidData['videoUrl'], Colors.purple),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      barrierColor: Colors.blue.withAlpha(50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
