import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../util/apptext.dart';
import '../../../util/colors.dart';
import '../../../util/common_widgets/CommonGradientBackground.dart';
import '../../../util/common_widgets/common_appbar.dart';
import '../../../util/common_widgets/common_button.dart';
import '../../../util/common_widgets/common_widgets.dart';
import '../../../util/images.dart';

class CheckYourEmail extends StatefulWidget {
  static const screenName = "check_your_email";
  const CheckYourEmail({Key? key}) : super(key: key);

  @override
  State<CheckYourEmail> createState() => _CheckYourEmailState();
}

class _CheckYourEmailState extends State<CheckYourEmail> {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.emailCheck),
                    verticalSpace(30),
                    bigHeadingText("Check your Email"),
                    verticalSpace(10),
                    subHeadingText("We sent a password reset link to"),
                    subHeadingText("r.mukaram@gmail.com", color: Colors.black),

                    verticalSpace(10),
                    CustomButton(text: "Open Email App", onTap: (){
                      // Get.offAllNamed(Home.screenName);
                    },),
                    verticalSpace(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        subHeadingText("Didn’t Recive an Email?"),
                        customGestureDetecter(
                            onTap: () {
                              // Get.toNamed(Login.screenName);
                            },
                            child: subHeadingText(" Send Again",
                                fontWeight: FontWeight.bold,
                                color: AppColors.black)),
                      ],
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
