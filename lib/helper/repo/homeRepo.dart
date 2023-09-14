import '../endpoints.dart';
import '../models/response_model.dart';
import '../network.dart';

class HomeRepo {
  static Future<ResponseModel> getSyncedKidDevices() async => await Network.get(EndPoints.getSyncedKidDevicesUrl);
}