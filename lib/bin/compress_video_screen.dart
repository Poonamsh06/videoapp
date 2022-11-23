// import 'dart:io';

// import 'package:VMedia/controllers/Video/upload_video_controller.dart';
// import 'package:flutter/material.dart';

// class CompressVideoScreen extends StatefulWidget {
//   CompressVideoScreen({
//     Key? key,
//     required this.videoFile,
//     required this.videoPath,
//   }) : super(key: key);

//   File videoFile;
//   String videoPath;

//   @override
//   State<CompressVideoScreen> createState() => _CompressVideoScreenState();
// }

// class _CompressVideoScreenState extends State<CompressVideoScreen> {
//   File? vidThumb;
//   void getVideoThumbnail() async {
//     setState(() async {
//       vidThumb = await UploadVideoController.getThumbnail(widget.videoPath);
//     });
//   }

//   @override
//   void initState() {
//     getVideoThumbnail;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(children: [
//           if (vidThumb != null)
//             SizedBox(
//               width: 200,
//               height: 200,
//               child: Image.file(vidThumb!),
//             ),
//         ]),
//       ),
//     );
//   }
// }
