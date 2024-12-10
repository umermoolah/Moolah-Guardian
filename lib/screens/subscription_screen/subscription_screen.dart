import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/images.dart';

import '../../controllers/authController.dart';
import '../../util/common_widgets/common_widgets.dart';
import '../home/home.dart';
import '../onboard/onboard.dart';

class SubscriptionScreen extends StatefulWidget {
  static const screenName = "subscription_screen";
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> with SingleTickerProviderStateMixin {

  TabController? tabController;
  int currentIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController?.addListener(() {
      currentIndex = tabController!.index;
      setState(() {});
      // if (currentIndex != prevIndex) {
      //   setState(() {
      //     headingText = currentIndex == 0 ? "Black List App" : "Black List URL";
      //   });
      //   prevIndex = currentIndex ?? 0;
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.normalGreen,
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonBackButton(onTap: () {
                  Get.offAllNamed(Home.screenName);
                }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      regularText("Current Package", color: Colors.white, fontWeight: FontWeight.w500),
                      regularText("Monthly : Expire on 12/11/33", color: Colors.white, fontWeight: FontWeight.w100),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  verticalSpace(10),
                  roundedContainer(
                      borderRadius: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(AppImages.crown),
                      )
                  ),
                  bigHeadingText("GeoLock Standard", color: Colors.white),
                  SizedBox(
                      width: 180,
                      // height: 100,
                      child: tabBar()),
                  (currentIndex == 0)?
                  priceBoard(price: "3.99", duration: "Month", features: [
                    "Get full report of cars",
                    "Get a spare car while your car is being fixed",
                    "Get the latest deals first",
                  ]):priceBoard(price: "30", duration: "Year", features: [
                    "Get full report of cars",
                    "Get a spare car while your car is being fixed",
                    "Get the latest deals first",
                  ]),
                  autoRenewalToggle(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomButton(text: "Subscribe", onTap: (){
                      Get.offAllNamed(Home.screenName);
                    }),
                  ),
                  verticalSpace(10),
                  regularText("Restore Purchase", underline: true, fontSize: 12, color: Colors.white,decorationColor: Colors.white),
                  verticalSpace(10),
                  InkWell(
                    onTap: (){
                      Get.find<AuthController>().logout();
                      Get.offAllNamed(OnBoard.screenName);
                    },
                      child: regularText("Logout", underline: true, fontSize: 12, color: Colors.white,decorationColor: Colors.white))
                ],
              ),
            ),
            verticalSpace(80)
          ],
        ),
      ),
    );
  }

  Widget tabBar() {
    return roundedContainer(
      padding: const EdgeInsets.all(5),
      // margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10)
      //     .copyWith(bottom: 0),
      color: AppColors.veryVeryLightGreen,
      child: Theme(
        data: Theme.of(context).copyWith(colorScheme: Theme.of(context).colorScheme.copyWith(surfaceVariant: Colors.transparent)),
        child: TabBar(
            overlayColor:
            MaterialStateColor.resolveWith((states) => AppColors.lightGreen),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.normalGreen),
            onTap: (v) {
              setState(() {});
            },
            controller: tabController,
            tabs: [
              textForTab("Monthly", tabController!.index == 0, unselectedTextColor: Colors.black),
              textForTab("Yearly", tabController!.index == 1, unselectedTextColor: Colors.black),
              // textForTab("Messages", tabController!.index == 2),

              /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
              // regularText("Browser History",color: AppColors.normalGreen, fontWeight: FontWeight.w500),
            ]),
      ),
    );
  }

  Widget priceBoard({required String price, required String duration, List<String> features = const[]}) {
    return roundedContainer(
      borderRadius: 10,
      color: AppColors.lightGreen,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        bigHeadingText("\$$price", color: Colors.white,fontSize:20),
                        bigHeadingText("/$duration", color: Colors.white,fontSize:17),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppImages.crown, color: Colors.white, width: 20,),
                        subHeadingText(" Package", color: Colors.white,fontSize:17),
                      ],
                    )
                  ],
                ),
                subHeadingText("Introductory Price", color: Colors.white)
              ],
            ),
          ),
          roundedContainer(
            margin: EdgeInsets.symmetric(horizontal: 7).copyWith(bottom: 7),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child:Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(int i=0;i<features.length;i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        regularText(features[i], fontWeight: FontWeight.w500),
                        if(i!=features.length-1)
                        verticalSpace(10),
                      ],
                    ),

                    // regularText("Unlock Secure SMS Monitioring", fontWeight: FontWeight.w500),
                    // verticalSpace(10),
                    // regularText("Unlock Secure SMS Monitioring", fontWeight: FontWeight.w500),
                  ],
                ),
              ],
            )
          )
        ],
      )
    );
  }

  Widget autoRenewalToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          regularText("Auto Renewal Payment", color: Colors.white),
          customSwitch()
        ],
      ),
    );
  }

  customSwitch() {
    double size = 35;
    return customGestureDetecter(child: Stack(
      // alignment: switchButton ? Alignment.centerRight : Alignment.centerLeft,
      children: [
        roundedContainer(
            borderRadius: 30,
            color:
            AppColors.lightGreen,
            height: size * 0.65,
            width: size * 1.2),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            roundedContainer(
              borderRadius: 30,
              color: Colors.white,
              margin: EdgeInsets.all(size * 0.083), //2.5
              height: size * 0.5,
              width: size * 0.5,
            ),
            // if (showM)
            //   regularText("M!",
            //       customFontFamily: fontFamilyPraise,
            //       color: switchButton
            //           ? AppColors.lightGreen
            //           : AppColors.darkLightGrey,
            //       fontSize: 11)
          ],
        ),
      ],
    ),);
  }


}
