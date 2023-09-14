import 'package:get/get.dart';
import 'package:moolah/controllers/authController.dart';
import 'package:moolah/controllers/baseController.dart';
import 'package:moolah/controllers/homeController.dart';

init(){
  Get.lazyPut(() => BaseController());
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => HomeController());
}