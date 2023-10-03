import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:moolah/screens/sync_device_detail_screen/sync_device_detail_screen.dart';
import 'package:moolah/util/apptext.dart';
import 'package:moolah/util/colors.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/images.dart';

class SyncDevice extends StatefulWidget {
  SyncDevice({
    required this.kidId,
    required this.name,
    required this.image,
    required this.active,
    required this.battery,
    this.isIPad = false,
    required this.mbps

});

  String kidId;
  bool isIPad;
  String? image;
  String name;
  String battery;
  String mbps;
  String active;


  @override
  State<SyncDevice> createState() => _SyncDeviceState();
}

class _SyncDeviceState extends State<SyncDevice> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return customGestureDetecter(
      onTap: (){
        Get.toNamed(SyncDeviceDetailScreen.screenName, arguments: {"kidId": widget.kidId});
      },
      child: roundedContainer(
        width: width,
        color: AppColors.lightGrey,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 55,
              width: 55,
              child: ClipRRect(
                child: widget.image == null ? ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: SvgPicture.asset(AppImages.person)) : Image.network(widget.image!),
              ),
            ),
            horizontalSpace(10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          bigSubHeading(widget.name),
                          horizontalSpace(10),
                          SvgPicture.asset(widget.isIPad ? AppImages.iPad : AppImages.mobile)
                        ],
                      ),
                      regularText("View", color: AppColors.normalGreen, underline: true)
                    ],
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      iconText(AppImages.emptyBattery, "${widget.battery}%"),
                      iconText(AppImages.global, "${widget.mbps} Mb per sec"),
                      iconText(AppImages.clock, "Active ${widget.active}",isItalic: true),
                    ],
                  )
                ],
              ),
            ),

          ],
        )
      ),
    );
  }


}
