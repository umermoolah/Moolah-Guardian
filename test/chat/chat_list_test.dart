
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/homeController.dart';
import 'package:moolah/helper/models/kid_model.dart';
import 'package:moolah/helper/models/message_model.dart';
import 'package:moolah/helper/models/thread_model.dart';
import 'package:moolah/screens/chat/chat_list_screen.dart';
import 'package:moolah/screens/chat/messaging_screen.dart';

// --- Mock Models and Controller ---
// These fake classes mimic your real objects, providing controlled data for tests.

class MockHomeController extends GetxController {
  var smsMonitoringEnabled = true;
  var updateCalled = false;
  var enableSmsMonitoringCalledWith = -1; // Use a value that won't be a real kidId

  @override
  List<KidModel> get connectedKids => [
        KidModel(
          id: 'kid123',
          msmsMonitoringStatus: smsMonitoringEnabled,
          threads: [
            ThreadModel(
              lastMessage: MessageModel(
                messageData: MessageData(
                  senderNumber: 'John Campbell',
                  message: 'Mom i need 5 more mins',
                  messageTimeStamp: DateTime.now().toIso8601String(),
                ),
              ),
            ),
            ThreadModel(
              lastMessage: MessageModel(
                messageData: MessageData(
                  senderNumber: 'Anna Campbell',
                  message: 'Mom can i use my device',
                  messageTimeStamp: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
                ),
              ),
            ),
          ],
        ),
      ];

  @override
  int getSelectedKidIndex(String kidId) => 0; // Always return the first kid

  @override
  KidModel getSelectedKid(String kidId) => connectedKids[0];

  @override
  void enableMSMSMonitoring({required String kidId, required bool value}) {
    smsMonitoringEnabled = value;
    enableSmsMonitoringCalledWith = value ? 1 : 0;
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    updateCalled = true;
    super.update(ids, condition);
  }
}

void main() {
  setUp(() {
    // Set up a fresh mock controller before each test.
    Get.put<HomeController>(MockHomeController());
  });

  tearDown(() {
    Get.reset();
  });

  // Helper to build the widget within GetMaterialApp.
  Widget buildTestableWidget(Widget child) {
    return GetMaterialApp(
      home: Scaffold(body: child),
      // Define a route for the navigation test.
      getPages: [
        GetPage(name: '/', page: () => child),
        GetPage(name: '/messaging', page: () => const MessagingScreen()),
      ],
    );
  }

  testWidgets('ChatListScreen should render UI with mock data', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(ChatListScreen(kidId: 'kid123')));
    await tester.pumpAndSettle();

    // Verify UI elements are present.
    expect(find.text('SMS Monitoring  Enabled'), findsOneWidget);
    expect(find.text('John Campbell'), findsOneWidget);
    expect(find.text('Mom i need 5 more mins'), findsOneWidget);
    expect(find.text('Anna Campbell'), findsOneWidget);
    expect(find.text('Mom can i use my device'), findsOneWidget);
  });

  testWidgets('Tapping SMS monitoring switch should call controller method', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(ChatListScreen(kidId: 'kid123')));
    await tester.pumpAndSettle();

    final controller = Get.find<HomeController>() as MockHomeController;

    // Find and tap the switch.
    await tester.tap(find.byType(Stack).first); // Tapping the custom switch widget
    await tester.pump();

    // Verify the correct method was called on the controller.
    expect(controller.enableSmsMonitoringCalledWith, 0); // 0 corresponds to `false`
    expect(controller.updateCalled, isTrue);
  });

  testWidgets('Tapping a chat item should navigate to MessagingScreen', (WidgetTester tester) async {
    // The actual navigation is done with Navigator.push, not Get.toNamed.
    // A robust test for this requires a mock navigator or more complex setup.
    // Here, we confirm the tap succeeds and the app doesn't crash.
    await tester.pumpWidget(buildTestableWidget(ChatListScreen(kidId: 'kid123')));
    await tester.pumpAndSettle();

    // Find and tap the first chat item.
    await tester.tap(find.widgetWithText(ListTile, 'John Campbell'));
    await tester.pumpAndSettle(); // Allow navigation to complete.

    // Verify that we have navigated away from the chat list and to the messaging screen.
    expect(find.byType(MessagingScreen), findsOneWidget);
    expect(find.byType(ChatListScreen), findsNothing);
  });
}
