import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moolah/screens/chat/chat_list_screen.dart';
import 'package:moolah/screens/home/widget/SyncDevice.dart';
import 'package:moolah/screens/scan_barcode/scan_barcode.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/images.dart';

import '../../controllers/authController.dart';
import '../../helper/sharedHelper.dart';
import '../../util/common_widgets/CommonGradientBackground.dart';

class Home extends StatefulWidget {
  static const screenName = "home";

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Get.find<AuthController>().refreshToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CommonGradientBackground(
        child: GetBuilder<AuthController>(builder: (con) {
      return Column(
        children: [
          verticalSpace(40),
          verticalSpace(height * 0.03),
          Expanded(
            child: roundedContainer(
                borderRadiusWhole: BorderRadius.circular(13).copyWith(
                    bottomRight: Radius.zero, bottomLeft: Radius.zero),
                padding: const EdgeInsets.all(25)
                    .copyWith(bottom: 0, left: 20, right: 20),
                margin: const EdgeInsets.all(10).copyWith(bottom: 0),
                width: width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 2,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                subHeadingText(
                                    "Good Morning${Prefs.firstName.get().isNotEmpty ? "," : ""} ",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                subHeadingText(Prefs.firstName.get(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black)
                              ],
                            ),
                          ),
                          Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ChatListScreen(),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    SvgPicture.asset(AppImages.messaging),
                                    roundedContainer(
                                        color: Colors.red,
                                        height: 15,
                                        width: 15,
                                        child: Center(
                                            child: regularText("1",
                                                fontSize: 10,
                                                color: AppColors.white)))
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    verticalSpace(30),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: SvgPicture.asset(AppImages.person)),
                    verticalSpace(15),
                    bigSubHeading(
                        "${Prefs.firstName.get()} ${Prefs.lastName.get()}"),
                    verticalSpace(15),
                    CustomButton(
                        text: "Connect Kids Device",
                        notExpanded: true,
                        icon: AppImages.scanBarcode,
                        onTap: () {
                          // Get.find<AuthController>().refreshToken();
                          Get.toNamed(ScanBarcode.screenName);
                        }),
                    verticalSpace(height * 0.07),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: bigSubHeading("Sync Devices (4)")),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SyncDevice(
                              image: AppImages.child1,
                              name: "John Campbell",
                              battery: "56",
                              mbps: "9.2",
                              active: "32 m ago",
                            ),
                            SyncDevice(
                              image: AppImages.child2,
                              name: "Anna Campbell",
                              battery: "10",
                              mbps: "3.2",
                              active: "Now",
                            ),
                            SyncDevice(
                                image: AppImages.child3,
                                name: "Rayan Campbell",
                                battery: "100",
                                mbps: "5.2",
                                active: "14 m ago",
                                isIPad: true),
                            SyncDevice(
                              image: AppImages.child4,
                              name: "Milli Campbell",
                              battery: "90",
                              mbps: "1.0",
                              active: "2 m ago",
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      );
    }));
  }
}
