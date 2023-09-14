import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moolah/screens/home/home.dart';
import 'package:moolah/screens/login/login.dart';
import 'package:moolah/screens/onboard/onboard.dart';
import 'package:moolah/screens/parent_security_check/parent_security_check.dart';
import 'package:moolah/screens/scan_barcode/scan_barcode.dart';
import 'package:moolah/screens/signup/signup.dart';

import '../screens/splash/splash.dart';
import '../screens/sync_device_detail_screen/sync_device_detail_screen.dart';

class RouteHelper {
  static Map<String, WidgetBuilder> routes = {
    Splash.screenName: (_) => const Splash(),
    OnBoard.screenName: (_) => const OnBoard(),
    SignUp.screenName: (_) => const SignUp(),
    Home.screenName: (_) => const Home(),
    Login.screenName: (_) => Login(fromSignup: Get.arguments?["fromSignup"] ?? false),
    ScanBarcode.screenName: (_) => const ScanBarcode(),
    SyncDeviceDetailScreen.screenName: (_) => const SyncDeviceDetailScreen(),
    ParentSecurityCheck.screenName: (_) => const ParentSecurityCheck(),
  };
}