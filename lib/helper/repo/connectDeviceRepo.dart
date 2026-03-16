import '../endpoints.dart';
import '../network.dart';

class ConnectDeviceRepo {
  static linkKidByConnectCode({
    required String code,
    required String parentFullName,
  }) async {
    return await Network.post(EndPoints.linkKidByConnectCode, body: {
      "code": code,
      "parentFullName": parentFullName,
    });
  }
}
