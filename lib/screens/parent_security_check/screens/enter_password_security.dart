import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/connectDeviceController.dart';
import 'package:moolah/screens/parent_security_check/screens/enter_dob_security.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/common_widgets/CommonGradientBackground.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/common_widgets/loader.dart';
import 'package:moolah/util/customtoast.dart';
import 'package:moolah/util/images.dart';

import '../../../util/colors.dart';
import '../../../util/common_widgets/common_appbar.dart';
import '../../../util/common_widgets/common_text_field.dart';
import '../../scan_barcode/scan_barcode.dart';

class EnterPasswordParentSecurityCheck extends StatefulWidget {
  static const screenName = "enterPasswordParentSecurityCheck";
  const EnterPasswordParentSecurityCheck({Key? key}) : super(key: key);

  @override
  State<EnterPasswordParentSecurityCheck> createState() => _EnterPasswordParentSecurityCheckState();
}

class _EnterPasswordParentSecurityCheckState extends State<EnterPasswordParentSecurityCheck> {
  DateTime? dateOfBirth;
  // TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CommonGradientBackground(child:
    GetBuilder<ConnectDeviceController>(builder: (connectDeviceController) {
      return Loader(
        c: connectDeviceController,
        child: Column(
          children: [
            verticalSpace(10),
            commonAppBar(withIcon: true),
            Expanded(
              child: roundedContainer(
                  width: width,
                  borderRadiusWhole: BorderRadius.circular(13).copyWith(
                      bottomRight: Radius.zero, bottomLeft: Radius.zero),
                  padding: const EdgeInsets.all(25)
                      .copyWith(bottom: 0, left: 20, right: 20),
                  margin: const EdgeInsets.all(10).copyWith(bottom: 0),
                  child: Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        bigHeadingText("Parent Security Check", fontSize: 27),
                        verticalSpace(4),
                        subHeadingText(
                            "Please provide the following data for security"),
                        verticalSpace(7),
                        subHeadingText(
                            "purposes before syncing to your device. "),
                        verticalSpace(10),
                        // CustomTextField(
                        //     hintText: "Moolah Wallet Device Email",
                        //     textEditingController: emailController,
                        //     validators: Validators.email),
                        CustomTextField(
                            hintText: "Kid Device Password",
                            textEditingController: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            validators: Validators.password),
                        verticalSpace(10),
                        // subHeadingText("Device Account Birthday",
                        //     fontWeight: FontWeight.w500, color: Colors.grey),
                        // verticalSpace(10),
                        // customGestureDetecter(
                        //   onTap: () async {
                        //     dateOfBirth = await showDatePicker(
                        //         context: context,
                        //         initialDate: DateTime(DateTime.now().year - 8),
                        //         firstDate: DateTime(1940),
                        //         lastDate: DateTime(DateTime.now().year - 2),
                        //         builder: (context, child) {
                        //           return Theme(
                        //             data: Theme.of(context).copyWith(
                        //               colorScheme: ColorScheme.light(
                        //                 primary: AppColors
                        //                     .normalGreen, // header background color
                        //                 onPrimary: AppColors
                        //                     .black, // header text color
                        //                 onSurface: AppColors
                        //                     .normalGreen, // body text color
                        //               ),
                        //               textButtonTheme: TextButtonThemeData(
                        //                 style: TextButton.styleFrom(
                        //                   foregroundColor:
                        //                       Colors.black, // button text color
                        //                 ),
                        //               ),
                        //             ),
                        //             child: child!,
                        //           );
                        //         });
                        //     setState(() {});
                        //   },
                        //   child: roundedContainer(
                        //     padding: EdgeInsets.symmetric(
                        //         vertical: 15, horizontal: 10),
                        //     color: AppColors.lightGrey,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         regularText(dateOfBirth == null
                        //             ? "__/__/____"
                        //             : getSortedDate(dateOfBirth)),
                        //         Align(
                        //             alignment: Alignment.centerRight,
                        //             child: SvgPicture.asset(AppImages.date))
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        verticalSpace(15),
                        CustomButton(
                          text: "Next",
                          margin: EdgeInsets.zero,
                          onTap: () async {

                            if (key.currentState!.validate()) {
                              connectDeviceController.passwordGlob = passwordController.text;
                              Get.toNamed(EnterDobParentSecurityCheck.screenName);
                              // if (key.currentState!.validate()) {
                              //   // if (dateOfBirth != null) {
                              //   if (await connectDeviceController
                              //       .parentSecurityCheck(
                              //       kidEmail: emailController.text,
                              //       kidPassword: passwordController.text
                              //   )
                              //   ) {
                              //     Get.toNamed(ScanBarcode.screenName,
                              //       // arguments: {
                              //       // "kidDeviceAccountUserID":
                              //       // }
                              //     );
                              //   }
                              //   // }else{
                              //   //   errorToast("Please enter date of birth");
                              //   // }
                            }
                          },
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      );
    }));
  }
}
