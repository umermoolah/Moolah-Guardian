import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moolah/util/common_widgets/CommonGradientBackground.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/images.dart';
import 'package:video_player/video_player.dart';

class TutorialScreen extends StatefulWidget {
  static const screenName = "tutorialScreen";
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {

  late VideoPlayerController controller;
  bool initialized = false;

  @override
  void initState() {
    controller = VideoPlayerController.asset("assets/tutorial_video/tutorial_video.mp4");
    controller.initialize().then((value) {
      controller.play();
      setState(() {
        initialized = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonGradientBackground(
        child: Column(children: [
          commonAppBar(heading: "Tutorial"),
          verticalSpace(50),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: roundedContainer(
                  // width: 100,
                  //   height: 100,
                    color: Colors.red,
                    child: initialized ? VideoPlayer(controller) : Image.asset(AppImages.videoThumbnail, fit: BoxFit.fill,)),
              ),
            ),
          )
        ],));
  }
}
