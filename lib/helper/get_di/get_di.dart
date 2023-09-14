import 'package:get/get.dart';
import 'package:moolah/controllers/authController.dart';
import 'package:moolah/controllers/baseController.dart';

init(){
  Get.lazyPut(() => BaseController());
  Get.lazyPut(() => AuthController());
}