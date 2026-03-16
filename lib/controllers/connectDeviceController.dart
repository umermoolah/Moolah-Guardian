import 'package:flutter/material.dart';
import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/helper/repo/connectDeviceRepo.dart';
import '../util/customtoast.dart';

class ConnectDeviceController extends BaseController {

  Future<bool> linkKidByConnectCode({
    required BuildContext context,
    required String code,
    required String parentFullName,
  }) async {
    isLoading = true;
    update();
    final res = await ConnectDeviceRepo.linkKidByConnectCode(
      code: code,
      parentFullName: parentFullName,
    );
    isLoading = false;
    update();
    if (res.isSuccessful) {
      successToast(
          "Congratulations!! You have successfully synched with a device and added it to your Moolah Guardian Account. Go to your dashboard to view real time data about this device.");
    } else {
      errorToast(res.message ?? "Invalid code. Please check and try again.");
    }
    return res.isSuccessful;
  }
}
