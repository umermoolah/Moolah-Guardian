import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:moolah/controllers/connectDeviceController.dart';
import 'package:moolah/screens/parent_security_check/parent_security_check.dart';
import 'package:moolah/util/common_widgets/common_appbar.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_widgets.dart';
import 'package:moolah/util/customtoast.dart';

import '../../util/apptext.dart';
import '../../util/common_widgets/CommonGradientBackground.dart';
import '../../util/common_widgets/loader.dart';
import '../../util/images.dart';
import '../home/home.dart';

class ScanBarcode extends StatefulWidget {
  static const screenName = "scanbarcode";
  const ScanBarcode({Key? key}) : super(key: key);

  @override
  State<ScanBarcode> createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {

  bool scanned = false;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return CommonGradientBackground(child:
    GetBuilder<ConnectDeviceController>(
      builder: (connectDeviceController) {
        return Loader(
          c: connectDeviceController,
          child: Column(
            children: [
              verticalSpace(15),
              customGestureDetecter(
                onTap: (){
                },
                  child: commonAppBar(heading: "Moolah Guardian Code")),
              verticalSpace(20),
              Expanded(child: Stack(
                children: [
                  MobileScanner(
                    onDetect: (BarcodeCapture capture) async {
                      print("--- QR CODE DETECTED ---");
                      
                      try{
                        if(!scanned){
                          if (capture.barcodes.isEmpty) return;
                          
                          final String? codeValue = capture.barcodes.first.displayValue;
                          print("Code display value: $codeValue");

                          if(codeValue != null){
                            scanned = true;
                            print("Attempting to decode JSON...");
                            Map data = jsonDecode(codeValue);
                            print("Decoded JSON data: $data");

                            // Check for possible keys: kidConnectId, kidDeviceAccountUserID, or user_device_id
                            String? finalData = data["kidConnectId"]?.toString() ?? 
                                              data["kidDeviceAccountUserID"]?.toString() ?? 
                                              data["user_device_id"]?.toString();

                            if(finalData != null && finalData.isNotEmpty){
                              print("Extracted ID: $finalData");
                              print("Calling parentKidDeviceConnect API...");
                              
                              if(await connectDeviceController.parentKidDeviceConnect(kidDeviceAccountConnectID: finalData)){
                                print("API Success");
                                showD();
                              }else{
                                print("API Failed");
                                scanned = false;
                              }
                            } else {
                              print("Required key (kidConnectId, kidDeviceAccountUserID, or user_device_id) missing in JSON.");
                              scanned = false;
                            }
                          }
                        }
                      }catch(e, stacktrace){
                        print("ERROR during QR scan processing: $e");
                        print("Stacktrace: $stacktrace");
                        scanned = false;
                      }
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
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        );
      }
    ));
  }

  void showD() async {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    await showDialog(context: context, builder: (_){
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: roundedContainer(
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
                subHeadingText("Congrats! You have successfully \n connected to your Moolah Device!"),
                verticalSpace(20),
                CustomButton(text: "Back to home", onTap: (){
                  Get.offAllNamed(Home.screenName);
                },)
              ],
            )
          ),
        ),
      );
    });
    scanned = false;
  }
}
