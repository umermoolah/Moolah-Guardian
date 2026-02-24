import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/authController.dart';
import 'package:moolah/controllers/subscription_controller.dart';
import 'package:moolah/screens/onboard/onboard.dart';
import 'package:moolah/screens/subscription_screen/subscription_screen.dart';

// --- Mock Controllers ---
class MockSubscriptionController extends SubscriptionController {
  bool purchaseSubscriptionCalled = false;
  bool? wasMonthly;

  void purchaseSubscription({required bool isMonthly}) {
    purchaseSubscriptionCalled = true;
    wasMonthly = isMonthly;
  }
}

class MockAuthController extends AuthController {
  bool logoutCalled = false;

  @override
  void logout() {
    logoutCalled = true;
    super.logout();
  }
}

void main() {
  setUp(() {
    // Register mock controllers before each test.
    Get.put<SubscriptionController>(MockSubscriptionController() as SubscriptionController);
    Get.put<AuthController>(MockAuthController() as AuthController);
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestableWidget(Widget child) {
    return GetMaterialApp(
      home: child,
      getPages: [
        GetPage(name: OnBoard.screenName, page: () => const Scaffold(body: Text('OnBoard Screen'))),
      ],
    );
  }

  testWidgets('SubscriptionScreen should render initial UI for Monthly plan', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const SubscriptionScreen()));
    await tester.pumpAndSettle();

    // Verify titles and buttons.
    expect(find.text('Moolah Guardian Standard'), findsOneWidget);
    expect(find.text('Subscribe'), findsOneWidget);

    // Verify that the Monthly plan is active by default.
    expect(find.textContaining('\$3.99'), findsOneWidget);
    expect(find.textContaining('/Month'), findsOneWidget);

    // Verify features for the monthly plan are visible.
    expect(find.text('Unlock Secure SMS Monitioring'), findsOneWidget);

    // Verify other UI elements.
    expect(find.text('Restore Purchase'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('Should switch to Yearly plan when tab is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const SubscriptionScreen()));
    await tester.pumpAndSettle();

    // Verify initial state is Monthly.
    expect(find.textContaining('\$3.99'), findsOneWidget);

    // Tap the 'Yearly' tab.
    await tester.tap(find.text('Yearly'));
    await tester.pumpAndSettle();

    // Verify the UI updates to the Yearly plan.
    expect(find.textContaining('\$30'), findsOneWidget);
    expect(find.textContaining('/Year'), findsOneWidget);

    // The features are the same, so we just check for presence.
    expect(find.text('Unlock Secure SMS Monitioring'), findsOneWidget);

    // Monthly price should no longer be visible.
    expect(find.textContaining('\$3.99'), findsNothing);
  });

  testWidgets('Subscribe button should call controller with correct plan', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const SubscriptionScreen()));
    await tester.pumpAndSettle();

    final controller = Get.find<SubscriptionController>() as MockSubscriptionController;

    // --- Test Monthly subscription ---
    await tester.tap(find.text('Subscribe'));
    await tester.pump();

    expect(controller.purchaseSubscriptionCalled, isTrue);
    expect(controller.wasMonthly, isTrue, reason: "Should be monthly by default");

    // Reset for the next check.
    controller.purchaseSubscriptionCalled = false;

    // --- Test Yearly subscription ---
    // Switch to yearly tab.
    await tester.tap(find.text('Yearly'));
    await tester.pumpAndSettle();

    // Tap subscribe again.
    await tester.tap(find.text('Subscribe'));
    await tester.pump();

    expect(controller.purchaseSubscriptionCalled, isTrue);
    expect(controller.wasMonthly, isFalse, reason: "Should be yearly after switching tabs");
  });

  testWidgets('Logout text should call AuthController.logout', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const SubscriptionScreen()));
    await tester.pumpAndSettle();

    final authController = Get.find<AuthController>() as MockAuthController;

    // Tap the logout text.
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    // Verify the method was called.
    expect(authController.logoutCalled, isTrue);
    // Also verify navigation to the OnBoard screen.
    expect(find.text('OnBoard Screen'), findsOneWidget);
  });
}
