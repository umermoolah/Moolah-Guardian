import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:moolah/screens/login/login.dart';
import 'package:moolah/screens/login/screens/enter_email_login.dart';
import 'package:moolah/screens/signup/signup.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_text_field.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/images.dart';
import 'package:video_player/video_player.dart';

import '../../util/common_widgets/CommonGradientBackground.dart';
import '../../util/mixpanel_events.dart';
import '../signup/screens/enter_email.dart';

class OnBoard extends StatefulWidget {
  static const screenName = "onboard";
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  late VideoPlayerController controller;
  late ChewieController cController;
  bool initialized = false;
  bool isPlaying = false;
  bool videoCompleted = false;
  bool initialPlay = true;
  bool stopped = false;

  Size? size;
  @override
  void initState() {
    controller =
        VideoPlayerController.asset("assets/tutorial_video/tutorial_video.mp4");
    controller.initialize().then((value) {
      setState(() {
        initialized = true;
      });
      cController = ChewieController(videoPlayerController: controller, aspectRatio: controller.value.aspectRatio, showControls: false);
      controller.addListener(() async {
        if (!controller.value.isPlaying && !videoCompleted) {
          if (controller.value.position >= controller.value.duration) {
            setState(() {
              videoCompleted = true;
            });
          }
        }
      });
    });

    getSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print("controller.value.size.width");
    print((height/width * 96.47234042553191) / controller.value.size.width);
    //0.2519
    print((0.2519 * controller.value.size.width)/(height/width));
    return CommonGradientBackground(
        otherOne: true,
        child: SafeArea(
          child: SizedBox(
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appLogo(size: 60),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if(initialized && !initialPlay)
                                  roundedContainer(
                                    color: Colors.transparent,
                                    borderRadius: 0,
                                    height: controller.value.size.height *
                                        ((((height / width) * 175.47234042553191) /
                                            controller.value.size.height)),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    width: controller.value.size.width * ((((height/width) * 110.47234042553191) / controller.value.size.width)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Chewie(controller: cController,),
                                      // child: VideoPlayer(controller),
                                    ),
                                  ),
                                ],
                              ),
                              if (initialPlay)
                                Center(
                                  child: roundedContainer(
                                    color: Colors.transparent,
                                      borderRadius: 0,
                                      // margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 65),
                                      width: controller.value.size.width * ((((height/width) * 96.47234042553191) / controller.value.size.width)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          child: Image.asset(
                                            AppImages.videoThumbnail,
                                            fit: BoxFit.fill,
                                          ))),
                                ),
                              if (videoCompleted || initialPlay || stopped)
                                Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: customGestureDetecter(
                                      onTap: () {
                                        setState(() {
                                          print("play");
                                          controller.play();
                                          if (!stopped) {
                                            initialPlay = false;
                                            videoCompleted = false;
                                          } else {
                                            stopped = false;
                                          }
                                        });
                                      },
                                      child: roundedContainer(
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.all(160.0),
                                        // child: SvgPicture.asset(
                                        //     AppImages.playButton,
                                        //     width: 50),
                                      ),
                                    )),
                              if (!videoCompleted && !initialPlay && !stopped)
                                Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: customGestureDetecter(
                                      onTap: () {
                                        stopVideo();
                                      },
                                      child: roundedContainer(
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.all(130.0),
                                        // child: SvgPicture.asset(AppImages.playButton, width: 50),
                                      ),
                                    )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  verticalSpace(10),
                  bigHeadingText("Moolah Guardians",
                      color: AppColors.white, fontSize: 22),
                  verticalSpace(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: subHeadingText(
                        "Empowering Parents to Safeguard, Monitor, and Nurture Their Kids' Digital World",
                        color: AppColors.white,
                        textAlign: TextAlign.center,
                        fontSize: 15),
                  ),
                  // verticalSpace(height * 0.06),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            text: "Sign Up",
                            onTap: () {
                              stopVideo(reset: true);
                              Get.toNamed(EnterEmailSignUp.screenName);
                            }),
                      ),
                      Expanded(
                        child: CustomButton(
                            color: Colors.transparent,
                            textColor: AppColors.white,
                            text: "Login",
                            onTap: () {
                              stopVideo(reset: true);
                              Get.toNamed(EnterEmailLogin.screenName);
                            }),
                      ),
                    ],
                  ),
                  googleButton()
                ],
              ),
            ),
          ),
        ));
  }

  void stopVideo({bool reset = false}) {
    if (!reset) {
      setState(() {
        controller.pause();
        setState(() {
          stopped = true;
        });
      });
    } else {
      controller.pause();
      controller.seekTo(const Duration(seconds: 0));
      setState(() {
        isPlaying = false;
        videoCompleted = false;
        initialPlay = true;
        stopped = false;
      });
    }
  }

  void getSize() async {
    // ByteData data = await rootBundle.load(AppImages.videoThumbnail);
    // // List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    //
    // size = ImageSizeGetter.getSize(MemoryInput(
    //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)));
  }
}
