import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';

class CompressProgressTile extends StatefulWidget {
  const CompressProgressTile({Key? key}) : super(key: key);

  @override
  State<CompressProgressTile> createState() => _CompressProgressTileState();
}

class _CompressProgressTileState extends State<CompressProgressTile> {
  //
  double? progress = 0;
  late Subscription subscription;

  @override
  void initState() {
    VideoCompress.setLogLevel(0);
    subscription = VideoCompress.compressProgress$.subscribe(
      (progress) => setState(() => this.progress = progress),
    );
    super.initState();
  }

  @override
  void dispose() {
    VideoCompress.cancelCompression();
    VideoCompress.dispose();
    subscription.unsubscribe;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: progress);
  }
}
