import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
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
  late ChewieController cController;
  bool initialized = false;
  final _key = GlobalKey();
  // double height = 0;
  Size? size;


  @override
  void initState() {
    //.image.resolve(ImageConfiguration()).addListener(ImageStreamListener((image, synchronousCall) {
    //   setState(() {
    //     print("image.image.height.toDouble()");
    //     print(image.image.height.toDouble());
    //     height = image.image.height.toDouble();
    //   });
    // }));
    // final file = Image.asset(AppImages.videoThumbnail).;

    getSize();
    // size = ImageSizeGetter.getSize(MemoryInput(file.readAsBytesSync()));
    controller = VideoPlayerController.asset("assets/tutorial_video/tutorial_video.mp4");
    controller.initialize().then((value) {
      cController = ChewieController(videoPlayerController: controller, aspectRatio: controller.value.aspectRatio, showControls: false);
      controller.play();
      setState(() {
        initialized = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    double vidHeight = 0;
    double vidWidth = 0;
    if(initialized) {
      vidHeight = controller.value.size.height *
          ((((height / width) * 260.47234042553191) /
              controller.value.size.height));
      vidWidth = controller.value.size.width *
          ((((height / width) * 162) /
              controller.value.size.width));
    }
    // size = Image.asset(AppImages.videoThumbnail,key: _key,).createState().context.size;
    print("size::::: ${vidWidth}");
    // print(size!.height - 167);
    return CommonGradientBackground(
        child: Column(children: [
          commonAppBar(heading: "Tutorial"),
          verticalSpace(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  if(!initialized)
                    Center(
                      child: Container(
                        color: Colors.red,
                        height: vidHeight,
                        // width: vidWidth,
                        child: Image.asset(AppImages.videoThumbnail, fit: BoxFit.fill,)
                          ..image.resolve(ImageConfiguration()).addListener(ImageStreamListener((image, synchronousCall) {
                            setState(() {
                              print("image.image.height.toDouble()");
                              print(image.image.height.toDouble());
                              // height = image.image.height.toDouble();
                            });
                          })),
                      ),
                    ),
                  if(initialized)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        roundedContainer(
                          color: Colors.transparent,
                          height: vidHeight,
                          width: vidWidth,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                              child: Chewie(controller: cController,)),),
                      ],
                    )
                ],
              ),
              // child: roundedContainer(
              //   // width: 100,
              //   //   height: 100,
              //   // height: vidHeight,
              //     width: vidWidth,
              //     color: Colors.red,
              //     child: ),
            ),
          )
        ],));
  }

  void getSize() async {
    ByteData data = await rootBundle.load(AppImages.videoThumbnail);
    // List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    size = ImageSizeGetter.getSize(MemoryInput(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)));
  }
}
