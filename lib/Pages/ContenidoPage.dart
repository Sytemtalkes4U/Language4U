import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

//stf

class ContenidoPage extends StatefulWidget {
  const ContenidoPage({super.key, required this.s});

  final String s;

  @override
  State<ContenidoPage> createState() => _ContenidoPageState(this.s);
}

class _ContenidoPageState extends State<ContenidoPage> {
  _ContenidoPageState(this.s);
  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  late CustomVideoPlayerWebController _customVideoPlayerWebController;
  final CustomVideoPlayerSettings _customVideoPlayerSettings =
  const CustomVideoPlayerSettings(showSeekButtons: true);
  final CustomVideoPlayerWebSettings _customVideoPlayerWebSettings =
  CustomVideoPlayerWebSettings(
    src: longVideo,
  );
  final String s;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      longVideo,
    )..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
    _customVideoPlayerWebController = CustomVideoPlayerWebController(
      webVideoPlayerSettings: _customVideoPlayerWebSettings,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(""),
      ),
      backgroundColor: Colors.blue,
      child: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 10,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "videos",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          height: 4,
                          fontWeight: FontWeight.w800),
                    ),
                  ]),
            ),
            kIsWeb
                ? Expanded(
              child: CustomVideoPlayerWeb(
                customVideoPlayerWebController:
                _customVideoPlayerWebController,
              ),
            )
                : CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "videos",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          height: 4,
                          fontWeight: FontWeight.w800),
                    ),
                  ]),
            ),
            kIsWeb
                ? Expanded(
              child: CustomVideoPlayerWeb(
                customVideoPlayerWebController:
                _customVideoPlayerWebController,
              ),
            )
                : CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController,
            ),
          ],
        ),
      ),
    );
  }
}

String video240 =
    "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_10mb.mp4";
String video480 =
    "https://www.sample-videos.com/video123/mp4/480/big_buck_bunny_480p_10mb.mp4";
String longVideo =
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
