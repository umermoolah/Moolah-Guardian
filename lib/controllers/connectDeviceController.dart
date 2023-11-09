import 'package:get/get.dart';
import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/helper/repo/connectDeviceRepo.dart';

import '../helper/models/response_model.dart';
import '../util/customtoast.dart';

class ConnectDeviceController extends BaseController {

  String kidDeviceAccountUserID = "";

  Future<bool> parentSecurityCheck(
      {
        required String kidEmail,
        required String kidPassword
      }) async {
    kidDeviceAccountUserID = "";
    isLoading = true;
    ResponseModel res = await ConnectDeviceRepo.parentSecurityCheck(
        kidEmail: kidEmail,
        kidPassword: kidPassword
    );
    if(res.isSuccessful){
      kidDeviceAccountUserID = res.data["kidDeviceAccountUserID"];
    }
    apiToast(res);
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
}
