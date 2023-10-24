import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moolah/helper/route_helper.dart';
import 'package:moolah/helper/sharedHelper.dart';
import 'package:moolah/screens/main_menu_profile/main_menu_profile.dart';
import 'package:moolah/screens/splash/splash.dart';
import './helper/get_di/get_di.dart' as get_di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  get_di.init();
  Prefs.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: RouteHelper.routes,
      initialRoute: Splash.screenName,
    );
  }
}

