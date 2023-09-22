import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moolah/screens/home/home.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/common_widgets/CommonGradientBackground.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/images.dart';

class PasswordReset extends StatefulWidget {
  static const screenName = "password_reset";
  const PasswordReset({Key? key}) : super(key: key);

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return CommonGradientBackground(
      child: SafeArea(
        child: Column(
          children: [
            commonAppBar(withIcon: true),
            verticalSpace(50),
            roundedContainer(
              borderRadius: 20,
              margin: const EdgeInsets.all(15),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              width: width,
              child: Column(
                children: [
                  SvgPicture.asset(AppImages.passwordReset),
                  verticalSpace(30),
                  bigHeadingText("Password Reset"),
                  verticalSpace(10),
                  subHeadingText("You Password is Successfully changed"),
                  verticalSpace(10),
                  CustomButton(text: "Back to Home", onTap: (){
                    Get.offAllNamed(Home.screenName);
                  },)
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
