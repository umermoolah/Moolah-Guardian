import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moolah/helper/sharedHelper.dart';
import 'package:moolah/screens/onboard/onboard.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';

import '../../util/common_widgets/CommonGradientBackground.dart';
import '../../util/mixpanel_events.dart';
import '../home/home.dart';

class Splash extends StatefulWidget {
  static const screenName = "splash";
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animate;

  @override
  void initState() {
    setController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonGradientBackground(
        child: Center(child: appLogo(size: animate?.value)));
  }

  void setController() async {

    Get.find<MixPanelEventsController>().track(MixEvents.viewLanding);

    /// To Animate the logo on the Splash
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animate = Tween(begin: 100.0, end: 300.0).animate(animationController!);
    animationController!.addListener(() {
      setState(() {});
    });
    await animationController!.forward();
    if(Prefs.isLoggedIn.get()){
      Get.offAllNamed(Home.screenName);
    }else{
      Get.offAllNamed(OnBoard.screenName);
    }
  }
}
