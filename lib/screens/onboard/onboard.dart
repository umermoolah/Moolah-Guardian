import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
  bool initialized = false;
  bool isPlaying = false;
  bool videoCompleted = false;
  bool initialPlay = true;
  bool stopped = false;

  @override
  void initState() {
    controller = VideoPlayerController.asset("assets/tutorial_video/tutorial_video.mp4");
    controller.initialize().then((value) {
      setState(() {
        initialized = true;
      });

      controller.addListener(() async {
        if (!controller.value.isPlaying && !videoCompleted) {
          if (controller.value.position >=
              controller.value.duration) {
            setState(() {
              videoCompleted = true;
            });
          }
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
                          roundedContainer(
                            borderRadius: 20,
                            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 65),
                            width: width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: VideoPlayer(controller))
                          ),
                          if(initialPlay)
                            roundedContainer(
                                borderRadius: 20,
                                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 65),
                                width: width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(AppImages.videoThumbnail, fit: BoxFit.fill,))
                            ),
                          if(videoCompleted || initialPlay || stopped)
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
                                    if(!stopped){
                                      initialPlay = false;
                                      videoCompleted = false;
                                    }else{
                                      stopped = false;
                                    }
                                  });
                                },
                                child: roundedContainer(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.all(160.0),
                                  child: SvgPicture.asset(AppImages.playButton, width: 50),
                                ),
                              )),
                          if(!videoCompleted && !initialPlay && !stopped)
                          Positioned(
                            top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: customGestureDetecter(
                                onTap: () {
                                  setState(() {
                                    controller.pause();
                                    setState(() {
                                      stopped = true;
                                    });
                                  });
                                },
                                child: roundedContainer(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.all(160.0),
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
              bigHeadingText("Moolah Guardians", color: AppColors.white,fontSize: 22),
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
                          Get.toNamed(EnterEmailSignUp.screenName);
                        }),
                  ),
                  Expanded(
                    child: CustomButton(
                        color: Colors.transparent,
                        textColor: AppColors.white,
                        text: "Login",
                        onTap: () {
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
}
