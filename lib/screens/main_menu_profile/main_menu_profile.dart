import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/authController.dart';
import 'package:moolah/screens/login/login.dart';
import 'package:moolah/screens/main_menu_profile/screens/change_password/change_password.dart';
import 'package:moolah/screens/main_menu_profile/screens/change_password/widget/password_reset.dart';
import 'package:moolah/screens/main_menu_profile/screens/profile/profile.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/CommonGradientBackground.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/images.dart';

import '../../helper/sharedHelper.dart';
import '../../util/common_widgets/common_widgets.dart';

class MainMenuProfile extends StatefulWidget {
  static const screenName = "main_menu_profile";
  const MainMenuProfile({Key? key}) : super(key: key);

  @override
  State<MainMenuProfile> createState() => _MainMenuProfileState();
}

class _MainMenuProfileState extends State<MainMenuProfile> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return CommonGradientBackground(
        child: SafeArea(
      child: GetBuilder<AuthController>(
        builder: (context) {
          return Column(
            children: [
              commonAppBar(heading: "Menu"),
              Expanded(
                child: roundedContainer(
                  borderRadiusWhole: BorderRadius.circular(13)
                      .copyWith(bottomRight: Radius.zero, bottomLeft: Radius.zero),
                  padding: const EdgeInsets.all(25).copyWith(bottom: 0, left: 15),
                  margin: const EdgeInsets.all(10).copyWith(bottom: 0),
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        verticalSpace(10),
                        customProfileViewer(),
                        verticalSpace(10),
                        bigSubHeading("${Prefs.firstName.get()} ${Prefs.lastName.get()}".trim().isEmpty ? "Your Name" : "${Prefs.firstName.get()} ${Prefs.lastName.get()}"),
                        subHeadingText("Good Morning"),
                        verticalSpace(30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: bigSubHeading("More Option"),
                        ),
                        verticalSpace(10),
                        option(icon: AppImages.profile, text: "Edit Profile", onTap: () => Get.toNamed(Profile.screenName)),
                        option(icon: AppImages.password, text: "Password", onTap: () => Get.toNamed(ChangePassword.screenName)),
                        option(icon: AppImages.tutorial, text: "Tutorials"),
                        option(icon: AppImages.feedback, text: "Feedback"),
                        option(icon: AppImages.contactUs, text: "Contact us"),
                        option(icon: AppImages.privacyPolicy, text: "Privacy Policy"),
                        verticalSpace(20),
                        CustomButton(onTap: (){
                          Get.offAllNamed(Login.screenName);
                        },text: "Logout", color: AppColors.lightRed.withOpacity(0.2), textColor: AppColors.red,icon: AppImages.logout,notExpanded: true,margin: EdgeInsets.zero),
                        verticalSpace(10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    ));
  }

  option({required String icon, required String text, void Function()? onTap}) {
    return customGestureDetecter(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                roundedContainer(
                  color: AppColors.greyF0F0,
                  borderRadius: 50,
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(icon)
                ),
                horizontalSpace(20),
                regularText(text)
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 10,)
          ],
        ),
      ),
    );
  }
}
