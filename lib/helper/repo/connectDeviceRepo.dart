import '../endpoints.dart';
import '../network.dart';

class ConnectDeviceRepo {
  static parentSecurityCheck(
      {required String kidEmail,
      required String kidPassword,
      required String birthday}) async {
    return await Network.post(EndPoints.parentAppSecurityCheck, body: {
      "kidAccountEmail": kidEmail,
      "kidAccountPassword": kidPassword,
      "kidAccountBirthday": birthday,
      "moolahApp": "guardian"
    });
  }

  static parentKidDeviceConnect(
      {required String kidDeviceAccountConnectID,
      required String kidDeviceAccountUserID}) async {
    return await Network.post(EndPoints.parentKidDeviceConnect, body: {
      "kidDeviceAccountConnectID": kidDeviceAccountConnectID,
      "kidDeviceAccountUserID": kidDeviceAccountUserID,
      "moolahApp": "guardian"
    });
  }
}
