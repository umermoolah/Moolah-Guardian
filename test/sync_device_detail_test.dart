
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/authController.dart';
import 'package:moolah/controllers/homeController.dart';
import 'package:moolah/helper/models/blocked_url_model.dart';
import 'package:moolah/helper/models/device_detail_model.dart';
import 'package:moolah/helper/models/kid_model.dart';
import 'package:moolah/screens/sync_device_detail_screen/screens/live_location.dart';
import 'package:moolah/screens/sync_device_detail_screen/sync_device_detail_screen.dart';

// --- Mock Models and Controllers ---
class MockHomeController extends GetxController {
  var walletEnabled = false.obs;
  var smsMonitoringEnabled = true.obs;
  String? addedBlacklistUrl;
  String? deletedAppPackage;
  String? blacklistedAppPackage;

  @override
  Future<void> getAppUsage({required String kidId}) async {}
  @override
  Future<void> getDeviceDetail({required String kidId}) async {}
  @override
  Future<void> getMessageThreads({required String kidId}) async {}
  @override
  Future<void> getBlacklistUrls({required String kidId}) async {}
  @override
  Future<void> getWalletStatus({required String kidId}) async {}
  @override
  Future<void> getMSMSMonitoringStatus({required String kidId}) async {}

  @override
  KidModel getSelectedKid(String kidId) {
    return KidModel(
      id: kidId,
      name: 'John Doe',
      lastActive: '5 mins ago',
      walletEnabled: walletEnabled.value,
      msmsMonitoringStatus: smsMonitoringEnabled.value,
      deviceDetail: DeviceDetailModel(
        data: Data(
          deviceId: 'dev123',
          apps: [
            App(appName: 'Instagram', packageName: 'com.instagram.android', systemApp: false, isEnabled: 1),
            App(appName: 'TikTok', packageName: 'com.zhiliaoapp.musically', systemApp: false, isEnabled: 1),
          ],
          realTimeStats: RealTimeStats(batteryLevel: 80, currentLatitude: 34.05, currentLongitude: -118.25),
        ),
      ),
      blockedUrls: BlockedUrlModel(
        blockedUrlsData: BlockedUrlsData(
          blockedUrls: ['https://badsite.com', 'https://anothersite.com'],
        ),
      ),
      threads: [], // Keep this simple for this test file
    );
  }

  @override
  int getSelectedKidIndex(String kidId) => 0;

  @override
  void addBlacklistUrl({required String kidId, required String url}) {
    addedBlacklistUrl = url;
  }
  @override
  void deleteApp({required String kidId, required String deviceId, required String appPackage}){
    deletedAppPackage = appPackage;
  }
  @override
  void blacklistApp({required String kidId, required String deviceId, required String appPackage}){
    blacklistedAppPackage = appPackage;
  }
  @override
  void enableWallet({required bool value, required String kidId}){
    walletEnabled.value = value;
  }
  @override
  void enableMSMSMonitoring({required String kidId, required bool value}){
    smsMonitoringEnabled.value = value;
    update();
  }
}

class MockAuthController extends GetxController {
  Future<void> refreshToken() async {}
}

void main() {
  setUp(() {
    Get.put<HomeController>(MockHomeController());
    Get.put<AuthController>(MockAuthController());
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestableWidget(Widget child) {
    return GetMaterialApp(
      home: child,
      getPages: [
        GetPage(name: LiveLocation.screenName, page: ()=> const Scaffold(body: Text("Live Location Screen")))
      ],
    );
  }

  testWidgets('SyncDeviceDetailScreen should render initial UI (Apps tab)', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(SyncDeviceDetailScreen(kidId: 'kid123')));
    await tester.pumpAndSettle();

    // Verify header and summary data
    expect(find.text("John's Summary"), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('80%'), findsOneWidget); // Battery

    // Verify 'Apps' tab is active and shows content
    expect(find.text('Instagram'), findsOneWidget);
    expect(find.text('TikTok'), findsOneWidget);
  });

  testWidgets('Should switch to Browser History tab and show URLs', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(SyncDeviceDetailScreen(kidId: 'kid123')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Browser History'));
    await tester.pumpAndSettle();

    // Verify content of the browser history tab
    expect(find.text('https://badsite.com'), findsOneWidget);
    expect(find.text('https://anothersite.com'), findsOneWidget);
    expect(find.widgetWithText(CustomButton, 'Add Black List URL'), findsOneWidget);
  });

   testWidgets('Should show and interact with the Add URL dialog', (WidgetTester tester) async {
    final controller = Get.find<HomeController>() as MockHomeController;
    await tester.pumpWidget(buildTestableWidget(SyncDeviceDetailScreen(kidId: 'kid123')));
    await tester.pumpAndSettle();

    // Switch to browser tab and open dialog
    await tester.tap(find.text('Browser History'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(CustomButton, 'Add Black List URL'));
    await tester.pumpAndSettle();

    // Interact with dialog
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'http://newbadsite.com');
    await tester.tap(find.widgetWithText(CustomButton, 'Black List'));
    await tester.pumpAndSettle();

    // Verify dialog closed and controller method was called
    expect(find.byType(AlertDialog), findsNothing);
    expect(controller.addedBlacklistUrl, 'http://newbadsite.com');
  });

  testWidgets('Should switch to Messages tab and show content based on monitoring status', (WidgetTester tester) async {
    final controller = Get.find<HomeController>() as MockHomeController;
    await tester.pumpWidget(buildTestableWidget(SyncDeviceDetailScreen(kidId: 'kid123')));

    // Test with monitoring ON
    controller.smsMonitoringEnabled.value = true;
    await tester.pumpAndSettle();
    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    expect(find.byType(ChatListScreen), findsOneWidget, reason: "Chat list should be visible when monitoring is on");

    // Test with monitoring OFF
    controller.smsMonitoringEnabled.value = false;
    await tester.pumpAndSettle(); // Re-render with new state
    expect(find.text('Enable SMS Monitoring'), findsOneWidget);

    // Tap the switch to enable it
    await tester.tap(find.byType(Stack).last); // Find the custom switch
    await tester.pump();
    expect(controller.smsMonitoringEnabled.value, isTrue, reason: "Controller should be told to enable monitoring");
  });

  testWidgets('Should interact with an app''s popup menu', (WidgetTester tester) async {
    final controller = Get.find<HomeController>() as MockHomeController;
    await tester.pumpWidget(buildTestableWidget(SyncDeviceDetailScreen(kidId: 'kid123')));
    await tester.pumpAndSettle();

    // Find the popup menu for Instagram and tap it.
    await tester.tap(find.byIcon(Icons.more_vert).first);
    await tester.pumpAndSettle();

    // Tap the 'Disable App' option
    await tester.tap(find.text("Disable App"));
    await tester.pumpAndSettle();

    expect(controller.blacklistedAppPackage, 'com.instagram.android');
  });

  testWidgets('Should navigate to Live Location screen', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(SyncDeviceDetailScreen(kidId: 'kid123')));
    await tester.pumpAndSettle();

    // Tap the 'View Last Location' area
    await tester.tap(find.text('View Last Location'));
    await tester.pumpAndSettle();

    expect(find.text('Live Location Screen'), findsOneWidget);
  });
}
