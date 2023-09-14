import 'package:get/get.dart';

class BaseController extends GetxController implements GetxService {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }
}