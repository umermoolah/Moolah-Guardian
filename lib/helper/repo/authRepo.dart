import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:moolah/helper/endpoints.dart';
import 'package:moolah/helper/models/response_model.dart';
import 'package:moolah/helper/network.dart';

class AuthRepo {
  static Future<ResponseModel> login(String email, String password) async {
    return await Network.post(EndPoints.login,
        body: {"email": email, "password": password, "moolahApp": "guardian"});
  }

  static Future<ResponseModel> signUp(
      String email,
      String password,
      String firstName,
      String lastName,
      String phone,
      String dob,
      String username) async {

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = Platform.isAndroid?(await deviceInfo.androidInfo).id:Platform.isIOS?(await deviceInfo.iosInfo).identifierForVendor??"":"";
    String moolahApp = "guardian";
    return await Network.post(EndPoints.signUp, body: {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "dob": dob,
      "username": username,
      "moolahApp": moolahApp,
      "device_id": deviceId,
      "imei": ""
    });
  }
  
  static refreshToken(String rToken) async {
    return await Network.post(EndPoints.refreshToken, body: {
      "refreshToken": rToken
    });
  }
}
