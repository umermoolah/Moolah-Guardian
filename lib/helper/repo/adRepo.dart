import '../endpoints.dart';
import '../models/response_model.dart';
import '../network.dart';

class AdRepo {
  static Future<ResponseModel> getBannerAds() async {
    return await Network.post(EndPoints.getBannerAds);
  }
}