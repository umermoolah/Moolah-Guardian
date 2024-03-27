import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:moolah/controllers/homeController.dart';
import 'package:moolah/screens/blacklist/blacklist_screen.dart';
import 'package:moolah/screens/chat/chat_list_screen.dart';
import 'package:moolah/screens/sync_device_detail_screen/screens/live_location.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/common_widgets/loader.dart';
import 'package:moolah/util/images.dart';

import '../../controllers/authController.dart';
import '../../helper/models/app_usage_model.dart';
import '../../helper/models/blocked_url_model.dart';
import '../../helper/models/device_detail_model.dart' ;
import '../../helper/models/kids_model.dart';
import '../../util/apptext.dart';
import '../../util/common_widgets/CommonGradientBackground.dart';
import '../../util/common_widgets/common_text_field.dart';

class SyncDeviceDetailScreen extends StatefulWidget {
  static const screenName = "syncDeviceDetailScreen";

  SyncDeviceDetailScreen({required this.kidId});
  String kidId;

  @override
  State<SyncDeviceDetailScreen> createState() => _SyncDeviceDetailScreenState();
}

class _SyncDeviceDetailScreenState extends State<SyncDeviceDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  String headingText = "Black List App";
  int prevIndex = 0;

  @override
  void initState() {
    super.initState();
    initAPIS();
    tabController = TabController(length: 3, vsync: this);
    tabController?.addListener(() {
      final currentIndex = tabController?.index;
      if (currentIndex != prevIndex) {
        setState(() {
          headingText = currentIndex == 0 ? "Black List App" : "Add Black List URL";
        });
        prevIndex = currentIndex ?? 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeController) {
      return CommonGradientBackground(
        child: Loader(
          c: homeController,
          child: Column(
            children: [
              verticalSpace(20),
              commonAppBar(
                  heading:
                      "${homeController.getSelectedKid(widget.kidId).name?.split(" ")[0]}'s Summary"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0).copyWith(bottom: 0),
                  child: Column(
                    children: [
                      headingWidget(homeController),
                      verticalSpace(15),
                      Expanded(
                        child: roundedContainer(
                            borderRadius: 15,
                            borderRadiusWhole: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              // mainAxisAlignment: tabController?.index == 0 ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                              children: [
                                tabBar(),
                                // if (tabController?.index == 0)
                                  // section(homeController),
                                  if (tabController?.index != 2)
                                    CustomButton(
                                      text: headingText,
                                      onTap: () {
                                        if (tabController?.index != 1) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const BlackListScreen(),
                                            ),
                                          );
                                        }else{
                                          _showAddBlackListDialog();
                                        }

                                      },
                                    ),
                                verticalSpace(0),
                                if (tabController?.index == 0)
                                  appSection(homeController)
                                else if (tabController?.index == 1) //1
                                  // comingSoon()
                                  urlSection(homeController)
                                else if (tabController?.index == 2) //2
                                  messagesSection(homeController),
                                // if(tabController?.index != 0)
                                //   comingSoon()
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showAddBlackListDialog() async {
    String url = "";
    TextEditingController urlController = TextEditingController();
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(10),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Builder(builder: (context) {
              var width = MediaQuery.of(context).size.width;
              return SizedBox(
                width: width - 40,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 26,
                        ),
                        boldText('Black List URL', fontSize: 18),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(hintText: "Enter URL", textEditingController: urlController,),
                    ),
                    CustomButton(
                      text: 'Black List',
                      onTap: () {
                        if(urlController.text.trim().isNotEmpty){
                          url = urlController.text.trim();
                        }
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 10,)
                  ],
                ),
              );
            }),
          );
        },
      );
      if(url.isNotEmpty){
        Get.find<HomeController>().addBlacklistUrl(kidId: widget.kidId??"", url: url);
      }
    }

  Widget appSection(HomeController homeController) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            /// Commented for now
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     bigHeadingText(
            //         "${homeController.getSelectedKid(widget.kidId).appUsage?.deviceDailyAvgUsage ?? ""} "),
            //     Column(
            //       children: [
            //         subHeadingText(
            //             homeController
            //                     .getSelectedKid(widget.kidId)
            //                     .appUsage
            //                     ?.deviceDailyAvgUsageChange ??
            //                 "",
            //             color: AppColors.normalGreen),
            //         verticalSpace(5)
            //       ],
            //     )
            //   ],
            // ),
            // regularText("Daily Average", fontSize: 12, color: AppColors.grey),
            /// Commented for now
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16).copyWith(bottom: 25,top: 0),
              child: boldText('All Apps', fontSize: 18),
            ),

            ///FOR PRODUCTION
            for (int i = 0;
                i <
                    ((homeController
                                .getSelectedKid(widget.kidId)
                                .deviceDetail
                                // ?.data
                                ?.realTimeStats
                                ?.appUsageData
                                ?.length)
                            ?.toInt() ??
                        0) /*.appUsage!.listOfInstalledApps!.length*/;
                i++)
              ((homeController
                              .getSelectedKid(widget.kidId)
                              .deviceDetail!
                              // .data!
                              .realTimeStats!
                              .appUsageData![i]
                              .lastUsedTime ??
                              // .mFgUsageTime ??
                          0) == 0)
                  ? const SizedBox()
                  : appItem(
                      homeController
                          .getSelectedKid(widget.kidId)
                          .deviceDetail!
                          // .!
                          .realTimeStats!
                          .appUsageData![i],
                      // totalTime: homeController
                      //         .getSelectedKid(widget.kidId)
                      //         .deviceDetail!
                      //         .data!
                      //         .realTimeStats!
                      //         .totalAppUsageData
                      //         ?.toInt() ??
                      //     0
                    ),

            ///FOR PRODUCTION
            ///FOR Staging
            // for(int i=0;i<homeController.getSelectedKid(widget.kidId).appUsage!.listOfInstalledApps!.length;i++)
            //   appItemStagging(
            //       homeController.getSelectedKid(widget.kidId).appUsage!.listOfInstalledApps![i]),
            ///FOR Staging
            // appItem('assets/images/home/instagram.svg', 'Instagram', 4,
            //     "1h 29 mins"),
            // appItem(
            //     'assets/images/home/snapchat.svg', 'Snapchat', 3, "30 mins"),
            // appItem('assets/images/home/tiktok.svg', 'Tiktok', 2, "15 mins"),
            // appItem('assets/images/home/Facebook.svg', 'Facebook', 1, "5 mins"),
          ],
        ),
      ),
    );
  }

  Widget appItem(AppUsageDatum listOfInstalledApp, {int totalTime = 0}) {
    // String iconPath = listOfInstalledApp//.appIcon!;
    var width = MediaQuery.of(context).size.width;
    print("listOfInstalledApp.mFgUsageTime!:::${totalTime}");
    String appName = listOfInstalledApp.mPackageName!; //.appName!;
    double flex = ((listOfInstalledApp.mFgUsageTime) ?? 0) /
        totalTime; //listOfInstalledApp.//.percentUsage! ~/ 10;
    String time =
        "${Duration(milliseconds: listOfInstalledApp.mFgUsageTime!).inMinutes % 60}mins ${Duration(milliseconds: listOfInstalledApp.mFgUsageTime!).inSeconds % 60} sec"; //.durationOfUsage!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          // SvgPicture.asset(iconPath),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boldText(appName, fontSize: 14),
                Row(
                  children: [
                    Flexible(
                      flex: (7).toInt(),
                      child: Container(
                        height: 5,
                        width: ((width * .5) * flex),
                        decoration: BoxDecoration(
                            color: const Color(0xffE8EAE3),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 3,
                      child: regularText(time,
                          fontSize: 12, color: AppColors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
          PopupMenuButton(
            icon: SvgPicture.asset('assets/images/home/more.svg'),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  print("deleteApp");
                  // Get.find<HomeController>().deleteApp(kidId: widget.kidId, appId: listOfInstalledApp.mPackageName);
                },
                padding: const EdgeInsets.only(left: 5),
                height: 30,
                value: 1,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/home/trash.svg'),
                    const SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    regularText("Remove App",
                        color: AppColors.red, fontSize: 13)
                  ],
                ),
              ),
              PopupMenuItem(
                padding: const EdgeInsets.only(left: 5),
                height: 30,
                value: 2,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/home/slash.svg'),
                    const SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    regularText("Blacklist App", fontSize: 13)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget appItemStagging(ListOfInstalledApp listOfInstalledApp) {
    String iconPath = listOfInstalledApp.appIcon!;
    String appName = listOfInstalledApp.appName!;
    int flex = listOfInstalledApp.percentUsage! ~/ 10;
    String time = listOfInstalledApp.durationOfUsage!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boldText(appName, fontSize: 14),
                Row(
                  children: [
                    Flexible(
                      flex: flex,
                      child: Container(
                        height: 5,
                        decoration: BoxDecoration(
                            color: const Color(0xffE8EAE3),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 3,
                      child: regularText(time,
                          fontSize: 12, color: AppColors.grey),
                    )
                  ],
                )
              ],
            ),
          ),
          PopupMenuButton(
            icon: SvgPicture.asset('assets/images/home/more.svg'),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  print("deleteApp");
                  Get.find<HomeController>().deleteApp(
                      kidId: widget.kidId,
                      appId: listOfInstalledApp.appId ?? 0);
                },
                padding: const EdgeInsets.only(left: 5),
                height: 30,
                value: 1,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/home/trash.svg'),
                    const SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    regularText("Remove App",
                        color: AppColors.red, fontSize: 13)
                  ],
                ),
              ),
              PopupMenuItem(
                padding: const EdgeInsets.only(left: 5),
                height: 30,
                value: 2,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/home/slash.svg'),
                    const SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    regularText("Blacklist App", fontSize: 13)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }

  Widget urlSection(HomeController homeController ) {
    BlockedUrlModel? list = homeController.connectedKids[homeController.getSelectedKidIndex(widget.kidId)].blockedUrls;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 25),
        child: ListView.builder(
          itemCount: list?.blockedUrlsData?.blockedUrls?.length ?? 0,
          itemBuilder: (context, index) =>
              urlItem(list?.blockedUrlsData?.blockedUrls?[index]??""),
        ),
      ),
    );
  }

  messagesSection(HomeController homeController) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10)
            .copyWith(top: 20),
        child:
        (homeController.getSelectedKid(widget.kidId).msmsMonitoringStatus ?? false) ?
        ChatListScreen(kidId: widget.kidId):
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boldText("Enable SMS Monitoring"),

                regularText("Monitor SMS messages sent to this device.", fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.grey8181),
                verticalSpace(10),
                customGestureDetecter(
                  onTap: () {
                    homeController.enableMSMSMonitoring(kidId: widget.kidId, value: !(homeController.getSelectedKid(widget.kidId).msmsMonitoringStatus??false));
                    // homeController.getSelectedKid(widget.kidId).msmsMonitoringStatus = true;
                  },
                    child: customSwitchSMS(value: homeController.getSelectedKid(widget.kidId).msmsMonitoringStatus??false, showM: false))
              ],
            )
        ,


        // child: ListView.builder(
        //   itemCount: 15,
        //   itemBuilder: (context, index) =>
        //       urlItem('https://www.fiverr.com/cp/product-release-2023'),
        // ),
      ),
    );
  }

  Widget urlItem(String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SvgPicture.asset(AppImages.globalOutlined),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              url,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 14,
                color: AppColors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget percentageContainer(
      Color color, String icon, String text, String value, String t,
      {bool otherOne = false}) {
    return Expanded(
      child: roundedContainer(
          padding: const EdgeInsets.all(7),
          color: AppColors.lightGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  roundedContainer(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    color: color,
                    child: SvgPicture.asset(
                      icon,
                      color: AppColors.white,
                    ),
                  ),
                  horizontalSpace(3),
                  if (otherOne)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: regularText(text, fontSize: 15,fontWeight: FontWeight.w600),
                    )
                  else
                    subHeadingText(text, fontSize: 10),
                ],
              ),
              if (!otherOne)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    bigHeadingText(value, fontSize: 20),
                    Column(
                      children: [
                        bigHeadingText(t, fontSize: 12),
                        verticalSpace(2)
                      ],
                    ),
                  ],
                )
              else
                const Icon(Icons.arrow_forward_ios, size: 15,)
            ],
          )),
    );
  }

  Widget headingWidget(HomeController homeController) {
    Kid kid = homeController.getSelectedKid(widget.kidId);
    return roundedContainer(
      borderRadius: 15,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: ClipRRect(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: kid.kidPic == null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: SvgPicture.asset(AppImages.person))
                          : Image.network(kid.kidPic!, errorBuilder: (c, e, v) => SvgPicture.asset(AppImages.person)),
                    )),
                  ),
                  horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bigSubHeading(kid.name),
                      iconText(AppImages.clock, "Active ${kid.lastActive}",
                          isItalic: true),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      customGestureDetecter(
                          onTap: () {
                            _showAdDialog();
                          },
                          child: SvgPicture.asset(AppImages.information)),
                      horizontalSpace(10),
                      customSwitch(value: kid.walletEnabled ?? false)
                    ],
                  ),
                  verticalSpace(2),
                  regularText(
                      kid.walletEnabled ?? false
                          ? "Wallet Enabled"
                          : "Wallet Disabled",
                      color: kid.walletEnabled ?? false
                          ? AppColors.normalGreen
                          : AppColors.grey,
                      fontSize: 10,
                      italic: true)
                ],
              )
            ],
          ),
          verticalSpace(20),
          Row(
            children: [
              percentageContainer(AppColors.yellow, AppImages.emptyBattery,
                  "Battery %", kid.deviceDetail?.realTimeStats?.batteryLevel?.toString() ?? "", "%"),
              horizontalSpace(10),
              percentageContainer(AppColors.blue, AppImages.global, "Data Used",
                  kid.deviceDetail?.realTimeStats?.deviceDataUsage?.toString() ?? "", "GB")
            ],
          ),
          verticalSpace(10),
          customGestureDetecter(
            onTap: () {
              Get.toNamed(LiveLocation.screenName);
            },
            child: Row(
              children: [

                  percentageContainer(AppColors.purple, AppImages.location,
                      "View Last Location", kid.batteryStatus ?? "", "%",
                      otherOne: true),

              ],
            ),
          ),
        ],
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
              textForTab("Apps", tabController!.index == 0),
              textForTab("Browser History", tabController!.index == 1),
              textForTab("Messages", tabController!.index == 2),
        
              /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
              // regularText("Browser History",color: AppColors.normalGreen, fontWeight: FontWeight.w500),
            ]),
      ),
    );
  }

  Widget customSwitch({bool showM = true, required bool value}) {
    double size = 35;
    bool switchButton = value;
    return customGestureDetecter(
      onTap: () {
        setState(() {
          switchButton = !switchButton;
        });
        if (switchButton) {
          // _showAdDialog();
        } else {}
        if (!showM) {
          Get.back();
        }
        Get.find<HomeController>()
            .enableWallet(value: switchButton, kidId: widget.kidId);
      },
      child: Stack(
        alignment: switchButton ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          roundedContainer(
              borderRadius: 30,
              color:
                  switchButton ? AppColors.lightGreen : AppColors.darkLightGrey,
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
              if (showM)
                regularText("M!",
                    customFontFamily: fontFamilyPraise,
                    color: switchButton
                        ? AppColors.lightGreen
                        : AppColors.darkLightGrey,
                    fontSize: 11)
            ],
          ),
        ],
      ),
    );
  }

  Widget customSwitchSMS({bool showM = true, required bool value}) {
    double size = 35;
    bool switchButton = value;
    return customGestureDetecter(
      onTap: () {
        setState(() {
          switchButton = !switchButton;
        });
        if (switchButton) {
          // _showAdDialog();
        } else {}
        if (!showM) {
          Get.back();
        }
      },
      child: Stack(
        alignment: switchButton ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          roundedContainer(
              borderRadius: 30,
              color:
              switchButton ? AppColors.lightGreen : AppColors.darkLightGrey,
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
              if (showM)
                regularText("M!",
                    customFontFamily: fontFamilyPraise,
                    color: switchButton
                        ? AppColors.lightGreen
                        : AppColors.darkLightGrey,
                    fontSize: 11)
            ],
          ),
        ],
      ),
    );
  }

  void _showAdDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: roundedContainer(
                  // height: 100,
                  margin: const EdgeInsets.all(30),
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(AppImages.earningImage),
                      verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          bigHeadingText("Enable Earning "),
                          bigHeadingText("M!",
                              customFontFamily: fontFamilyPraise),
                        ],
                      ),
                      verticalSpace(20),
                      subHeadingText("""Earning M! is enabled by default
 in all Moolah M1 tablets. Parents
can choose to disable Moolah Ads
and Wallet from kid devices here.

                  """),
                      verticalSpace(20),
                      customSwitch(
                          showM: false,
                          value: Get.find<HomeController>()
                                  .getSelectedKid(widget.kidId)
                                  .walletEnabled ??
                              false),
                    ],
                  )),
            ),
          );
        });
  }

  void initAPIS() async {
    Get.find<HomeController>().getAppUsage(kidId: widget.kidId);
    await Get.find<AuthController>().refreshToken();
    Get.find<HomeController>()
        .getDeviceDetail(kidId: /*"97eb1071c123c76b"*/ widget.kidId);
    Get.find<HomeController>()
        .getMessageThreads(kidId: widget.kidId);
    Get.find<HomeController>()
        .getBlacklistUrls(kidId: widget.kidId);
    Get.find<HomeController>()
        .getWalletStatus(kidId: widget.kidId);
    Get.find<HomeController>()
        .getMSMSMonitoringStatus(kidId: widget.kidId);

  }

  // Widget section(homeController) {
  //   return Column(
  //     children: [
  //     ],
  //   );
  // }

  comingSoon() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.comingSoon),
        ],
      ),
    );
  }
}
