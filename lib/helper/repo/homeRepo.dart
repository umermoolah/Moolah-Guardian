import '../endpoints.dart';
import '../models/response_model.dart';
import '../network.dart';

class HomeRepo {
  static Future<ResponseModel> getSyncedKidDevices() async => await Network.get(EndPoints.getSyncedKidDevicesUrl);

  static Future<ResponseModel> sendActionToDevice(
      {required String actionId, required String message, required String deviceId}) async => await Network.post(EndPoints.sendActionToDevice, body: {
    'actionId': actionId,
    'message': message,
    'deviceId': deviceId
  });


}