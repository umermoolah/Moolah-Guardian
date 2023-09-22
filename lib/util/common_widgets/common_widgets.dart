import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moolah/util/images.dart';

import '../apptext.dart';
import '../colors.dart';





/// APP LOGO
Widget appLogo({double? size}) {
 double? height = size;
 double? width = size;
  return SvgPicture.asset(
    AppImages.appLogoSvg,
    height: height,
    width: width,
  );
}


Widget commonBackButton(){
  return customGestureDetecter(
    onTap: (){
      Get.back();
    },
    child: roundedContainer(
      height: 30,
      width: 30,
      padding: const EdgeInsets.all(7.0),
      margin: const EdgeInsets.all(7.0),
      child: SvgPicture.asset(AppImages.backButtonIcon)
    ),
  );
}

Widget roundedContainer({double borderRadius = 7, Color? color, Widget? child, double? height, double? width, EdgeInsets? padding, EdgeInsets? margin, BorderRadius? borderRadiusWhole, BoxBorder? border}){
  return Container(
    height: height,
    width: width,
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
      border: border,
      borderRadius: borderRadiusWhole ?? BorderRadius.circular(borderRadius),
      color: color ?? AppColors.white
    ),
    child: child,
  );
}

Widget customProfileViewer({double size = 80}) {
  return roundedContainer(
      borderRadius: 100,
      height: size,
      width: size,
      color: Colors.lightGreen,
      child: Center(
          child: SizedBox(
            // height: 65,
            // width: 65,
            child: ClipRRect(
              child: Image.asset(AppImages.profileImage),
            ),
          )
      )
  );
}

Widget verticalSpace(double height){
  return SizedBox(height: height,);
}

Widget horizontalSpace(double width){
  return SizedBox(width: width,);
}

Widget customGestureDetecter({required Widget child, void Function()? onTap}){
  return GestureDetector(
    onTap: onTap,
    child: AbsorbPointer(child: child),
  );
}

Widget iconText(String icon, String s, {bool isItalic = false}) {
  double size = 15;
  return Row(
    children: [
      SvgPicture.asset(icon, width: size, height: size,),
      horizontalSpace(5),
      regularText(s, color: AppColors.grey, fontSize: 10, italic: isItalic)
    ],
  );
}

