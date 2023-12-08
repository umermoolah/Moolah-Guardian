import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/authController.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';

import '../images.dart';
import '../mixpanel_events.dart';

class CustomButton extends StatefulWidget {
  CustomButton(
      {this.color,
      this.textColor,
      required this.text,
      this.onTap,
      this.margin,
      this.icon,
        this.notExpanded = false,
        this.isImage = false,
        this.border,
        this.borderRadius = 10
      });

  Color? color;
  Color? textColor;
  void Function()? onTap;
  String text;
  EdgeInsets? margin;
  String? icon;
  BoxBorder? border;
  double borderRadius;
  bool notExpanded;
  bool isImage;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    Color bg = widget.color ?? AppColors.black;

    return customGestureDetecter(
      onTap: widget.onTap,
      child: roundedContainer(
          border: widget.border ?? (bg != AppColors.black
              ? Border.all(color: AppColors.white, width: 1.5)
              : null),
          color: bg,
          margin: widget.margin ??
              const EdgeInsets.all(10).copyWith(bottom: 0, top: 14),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          borderRadius: widget.borderRadius,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: widget.isImage ? Image.asset(widget.icon!, width: 20,) : SvgPicture.asset(widget.icon!),
                ),
              widget.notExpanded ? rest() :
              Expanded(child: rest()),
            ],
          )),
    );
  }

  Widget rest() {
    return Center(
        child: regularText(widget.text,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: widget.textColor ?? AppColors.white));
  }
}

Widget googleButton(){
  return CustomButton(
    border: Border.all(color: AppColors.buttonBorderGrey),
      color: Colors.white,
      icon: AppImages.googlePng,
      isImage: true,
      notExpanded: true,
      textColor: AppColors.black,
      text: "Sign in with Google",
      onTap: () {


        Get.find<AuthController>().googleSignIn();
      });
}