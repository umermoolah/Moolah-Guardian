import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:moolah/screens/parent_security_check/parent_security_check.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';

import '../../util/apptext.dart';
import '../../util/common_widgets/CommonGradientBackground.dart';
import '../../util/images.dart';

class ScanBarcode extends StatefulWidget {
  static const screenName = "scanbarcode";
  const ScanBarcode({Key? key}) : super(key: key);

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), (){
      showD();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CommonGradientBackground(child: Column(
      children: [
        verticalSpace(15),
        customGestureDetecter(
          onTap: (){
            // JUST TO TEST IT
            showD();
          },
            child: commonAppBar(heading: "Moolah Parent Code")),
        verticalSpace(20),
        Expanded(child: Stack(
          children: [
            MobileScanner(
              onDetect: (BarcodeCapture capture){
                showD();
              },
            ),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.srcOut),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        backgroundBlendMode: BlendMode.lighten), // This one will handle background + difference out
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: roundedContainer(
                      borderRadius: 30,
                      margin: const EdgeInsets.only(bottom: 20),
                      height: width * 0.7,
                      width: width * 0.7,
                      // decoration: BoxDecoration(
                      //   color: Colors.red,
                      //   borderRadius: BorderRadius.circular(100),
                      // ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ))
      ],
    ));
  }

  void showD() async {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    await Get.toNamed(ParentSecurityCheck.screenName);
    showDialog(context: context, builder: (_){
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: roundedContainer(
            // height: 100,
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppImages.linkCircle),
                verticalSpace(20),
                bigHeadingText("Device Synced"),
                verticalSpace(20),
                subHeadingText("Congrats! You have successfully \nconnected to your Kids Device!"),
                verticalSpace(20),
                CustomButton(text: "Back to home", onTap: (){
                  Get.back();
                  Get.back();
                },)
              ],
            )
          ),
        ),
      );
    });
  }
}
