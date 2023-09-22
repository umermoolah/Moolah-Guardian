import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:moolah/screens/main_menu_profile/screens/change_password/widget/password_reset.dart';

import '../../../../util/common_widgets/CommonGradientBackground.dart';
import '../../../../util/common_widgets/common_appbar.dart';
import '../../../../util/common_widgets/common_button.dart';
import '../../../../util/common_widgets/common_text_field.dart';
import '../../../../util/common_widgets/common_widgets.dart';
import '../../../../util/images.dart';

class ChangePassword extends StatefulWidget {
  static const screenName = "change_password";
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return CommonGradientBackground(
      child: SafeArea(
        child: Column(
          children: [
            commonAppBar(heading: "Change Password"),
            Expanded(
              child: roundedContainer(
                borderRadiusWhole: BorderRadius.circular(13).copyWith(
                    bottomRight: Radius.zero, bottomLeft: Radius.zero),
                padding: const EdgeInsets.all(25).copyWith(bottom: 0, left: 15),
                margin: const EdgeInsets.all(10).copyWith(bottom: 0),
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(20),
                      CustomTextField(
                          hintText: "Enter Current Password",
                          otherOne: true,
                          prefixIcon: AppImages.passwordField),
                      verticalSpace(15),
                      CustomTextField(
                          hintText: "Enter New Password",
                          otherOne: true,
                          prefixIcon: AppImages.passwordField),
                      verticalSpace(15),
                      CustomTextField(
                          hintText: "Confirm New Password",
                          otherOne: true,
                          prefixIcon: AppImages.passwordField),

                      verticalSpace(35),
                      CustomButton(
                        text: "Save Password",
                        margin: EdgeInsets.zero,
                        onTap: (){
                          Get.toNamed(PasswordReset.screenName);
                        },
                      ),
                      verticalSpace(30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
