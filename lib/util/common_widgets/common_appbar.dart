import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moolah/screens/otp_verification/otp_verification.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';

import '../../screens/subscription_screen/subscription_screen.dart';

Widget commonAppBar({bool withIcon = false, String heading = "", void Function()? onTap}){
  return Padding(
    padding: const EdgeInsets.all(8.0).copyWith(top: 30),
    child: Stack(
      children: [
        Row(
          children: [
            commonBackButton(onTap: onTap),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (withIcon)?
            GestureDetector(
              onTap: () {
                Get.toNamed(OtpVerification.screenName);
              },
              child: Container(
                // color: Colors.red,
                  child: appLogo(size: 100)),
            ):
                Center(child: Column(
                  children: [
                    verticalSpace(13),
                    bigSubHeading(heading),
                  ],
                ))
          ],
        )
      ],
    ),
  );
}