import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/helper/repo/connectDeviceRepo.dart';

import '../helper/models/response_model.dart';
import '../util/apptext.dart';
import '../util/common_widgets/common_button.dart';
import '../util/common_widgets/common_widgets.dart';
import '../util/customtoast.dart';

class ConnectDeviceController extends BaseController {

  String kidDeviceAccountUserID = "";

  String emailGlob = "";
  String passwordGlob = "";

  // Future<bool> parentSecurityCheck(
  //     {
  //       required String kidEmail,
  //       required String kidPassword
  //     }) async {
  //   kidDeviceAccountUserID = "";
  //   isLoading = true;
  //   ResponseModel res = await ConnectDeviceRepo.parentSecurityCheck(
  //       kidEmail: kidEmail,
  //       kidPassword: kidPassword
  //   );
  //   if(res.isSuccessful){
  //     kidDeviceAccountUserID = res.data["kidDeviceAccountUserID"];
  //   }
  //   apiToast(res);
  //   isLoading = false;
  //   return res.isSuccessful;
  // }

  Future<bool> parentSecurityCheck(BuildContext context) async {
    kidDeviceAccountUserID = "";
    isLoading = true;
    ResponseModel res = await ConnectDeviceRepo.parentSecurityCheck(
        kidEmail: emailGlob,
        kidPassword: passwordGlob
    );
    if(res.isSuccessful){
      kidDeviceAccountUserID = res.data["kidDeviceAccountUserID"];
    }
    // apiToast(res);
    if (!res.isSuccessful) {
      bool tryAgain = await _showWarningPopUp(context);
      if(tryAgain){
        return await parentSecurityCheck(context);
      }
      // errorToast("Oh No. Looks like your credentials do not match. To make a secure connection, your email, password and birthday must match exactly to the device that you are trying to synch with. Would you like to try again?");
    } else {
      successToast("Congratulations!! You have successfully synched with a device and added it to your Moolah Guardian Account. Go to your dashboard to view real time data about this device.");
    }
    isLoading = false;
    return res.isSuccessful;
  }

  Future<bool> parentKidDeviceConnect(
      {required String kidDeviceAccountConnectID}
      // required String kidDeviceAccountUserID}
      )
  async {
    isLoading = true;
    ResponseModel res = await ConnectDeviceRepo.parentKidDeviceConnect(
        kidDeviceAccountConnectID: kidDeviceAccountConnectID,
        kidDeviceAccountUserID: kidDeviceAccountUserID);
    apiToast(res);
    isLoading = false;
    return res.isSuccessful;
  }


  Future<bool> _showWarningPopUp(context) async {
    bool tryAgain = false;
    await showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (c) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              roundedContainer(
                borderRadius: 20,
                padding: const EdgeInsets.all(15.0).copyWith(top: 20),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    regularText("Oh No. Looks like your credentials do not match. To make a secure connection, your email, password and birthday must match exactly to the device that you are trying to synch with. Would you like to try again?", fontSize: 16, textAlign: TextAlign.center, fontWeight: FontWeight.w500),
                    verticalSpace(10),
                    CustomButton(text: "Okay", onTap: Get.back),
                    // verticalSpace(10),
                    CustomButton(text: "Try Again", onTap: () {
                      tryAgain = true;
                      Get.back();
                    }),
                    verticalSpace(60)
                  ],
                ),
              ),
            ],
          );
        });

    return tryAgain;
  }
}
