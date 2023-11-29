import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:get/get.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:moolah/helper/route_helper.dart';
import 'package:moolah/helper/sharedHelper.dart';
import 'package:moolah/screens/main_menu_profile/main_menu_profile.dart';
import 'package:moolah/screens/splash/splash.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import './helper/get_di/get_di.dart' as get_di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  get_di.init();
  Prefs.init();
  initSDKS();
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


void initSDKS() async {

  /// Firebase
  print("Initializing Firebase");
  await Firebase.initializeApp();

  /// Mixpanel SDK
  print("Initializing Mixpanel");
  await Mixpanel.init("b2c2ea88edf4da993cb3572c6f126f6c", trackAutomaticEvents: true);

  /// OneSignal SDK
  print("Initializing OneSignal");
  initOneSignal();

  /// IronSource SDK
  await IronSource.init(appKey: "9459d105");
}


Future<void> initOneSignal() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("476bba3d-a3d6-4b7c-b5c2-4eaefdb30bc3");
  print("OneSignal.Notifications.permission");
  print(OneSignal.Notifications.permission);
  if(!OneSignal.Notifications.permission) {
    print("OneSignal.Notifications.permission::1");
    await OneSignal.Notifications.requestPermission(true);
    print("OneSignal.Notifications.permission::2");
    OneSignal.Notifications.addPermissionObserver((permission) {
      print("Has permission $permission");

      if(!permission){
        OneSignal.Notifications.requestPermission(true);
      }
    });
  }
}
