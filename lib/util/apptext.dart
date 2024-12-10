import 'package:flutter/material.dart';

import 'colors.dart';

String fontFamily = "DM Sans";
String fontFamilyPraise = "praise";

var textStyle = TextStyle(fontFamily:fontFamily);

Widget regularText(String text, {double? fontSize, FontWeight? fontWeight, Color? color, TextAlign? textAlign, bool underline = false, bool italic = false, String? customFontFamily, int? maxLines, TextOverflow? textOverflow, Color? decorationColor, double? height}){
  return Text(text, style: textStyle.copyWith(fontFamily: customFontFamily ?? fontFamily, fontSize: fontSize, fontWeight: fontWeight, color: color, decoration: underline ? TextDecoration.underline : null,fontStyle: italic ? FontStyle.italic : null, decorationColor: decorationColor, height: height),textAlign: textAlign, maxLines: maxLines,overflow: textOverflow,);
}

Widget boldText(String text, {double? fontSize, FontWeight? fontWeight, Color? color, String? customFontFamily, int? maxLines, TextOverflow? textOverflow, double? height}){
  return regularText(text,fontSize: fontSize, fontWeight: fontWeight??FontWeight.bold, color: color,customFontFamily: customFontFamily, maxLines: maxLines, textOverflow: textOverflow, height: height);
}

Widget bigHeadingText(String text, {Color? color, double? fontSize, String? customFontFamily, double? height}){
  return boldText(text, fontSize: fontSize??30, fontWeight: FontWeight.w600, color: color,customFontFamily: customFontFamily, height: height);
}
Widget subHeadingText(String text, {double? fontSize = 14, FontWeight? fontWeight, Color color = Colors.grey, TextAlign? textAlign, double? height}){
  return regularText(text, color: color, fontSize: fontSize, fontWeight: fontWeight, textAlign: textAlign, height: height);
}

Widget bigSubHeading(text, {Color? color, double? height}){
  return subHeadingText(text, fontSize: 16, fontWeight: FontWeight.w700, color: color?? AppColors.black, height: height);
}