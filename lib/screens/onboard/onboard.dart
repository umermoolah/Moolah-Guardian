import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moolah/screens/login/login.dart';
import 'package:moolah/screens/signup/signup.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_text_field.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';

import '../../util/common_widgets/CommonGradientBackground.dart';

class OnBoard extends StatefulWidget {
  static const screenName = "onboard";
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CommonGradientBackground(child: SafeArea(
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appLogo(),
            verticalSpace(30),
            bigHeadingText("Moolah Guardians", color: AppColors.white),
            verticalSpace(20),
            subHeadingText("Equipping Moolah Users with tools to  Secure, Monitor and Protect Moolah Devices", color: AppColors.white, textAlign: TextAlign.center, fontSize: 18),
            verticalSpace(height*0.06),
            CustomButton(text: "Sign Up", onTap: (){
              Get.toNamed(SignUp.screenName);
            }),
            CustomButton(color: Colors.transparent, textColor: AppColors.white, text: "Login", onTap: (){
              Get.toNamed(Login.screenName);
            }),
          ],
        ),
      ),
    ));
  }
}
