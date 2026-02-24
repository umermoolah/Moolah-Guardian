import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/connectDeviceController.dart';
import 'package:moolah/screens/parent_security_check/screens/enter_dob_security.dart';
import 'package:moolah/screens/parent_security_check/screens/enter_password_security.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_text_field.dart';

// --- Mock Controller ---
class MockConnectDeviceController extends ConnectDeviceController {
  String? passwordGlob;
  // Use the parent class isLoading property; keep mock simple.
}

void main() {
  setUp(() {
    // Register mock controller instance; cast to match the expected type for Get.put<T>().
    Get.put<ConnectDeviceController>(MockConnectDeviceController() as ConnectDeviceController);
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestableWidget(Widget child) {
    return GetMaterialApp(
      home: child,
      getPages: [
        GetPage(
          name: EnterDobParentSecurityCheck.screenName,
          page: () => const Scaffold(body: Text('DOB Security Screen')),
        ),
      ],
    );
  }

  testWidgets('EnterPasswordParentSecurityCheck should render initial UI', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const EnterPasswordParentSecurityCheck()));
    await tester.pumpAndSettle();

    // Verify the main heading and subheading.
    expect(find.text('Moolah Guardian Secure Connection'), findsOneWidget);
    expect(find.textContaining('provide the following data for security purposes'), findsOneWidget);

    // Verify the password field and button are present.
    expect(find.byType(CustomTextField), findsOneWidget);
    expect(find.widgetWithText(CustomButton, 'Next'), findsOneWidget);
  });

  testWidgets('Should show validation error if password is empty', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const EnterPasswordParentSecurityCheck()));
    await tester.pumpAndSettle();

    // Tap the 'Next' button without entering a password.
    await tester.tap(find.widgetWithText(CustomButton, 'Next'));
    await tester.pump();

    // Check for a validation error. The exact message depends on your `Validators.password` implementation.
    // We'll assume it shows a generic error message.
    expect(find.text('Password is required'), findsOneWidget, reason: "A validation error for the empty password field should be shown.");
  });

  testWidgets('Should update controller and navigate when password is valid', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const EnterPasswordParentSecurityCheck()));
    await tester.pumpAndSettle();

    final controller = Get.find<ConnectDeviceController>() as MockConnectDeviceController;

    // Enter a valid password.
    const password = 'validPassword123';
    await tester.enterText(find.byType(CustomTextField), password);
    await tester.pump();

    // Tap the 'Next' button.
    await tester.tap(find.widgetWithText(CustomButton, 'Next'));
    await tester.pumpAndSettle(); // Allow navigation to complete.

    // Verify the controller's password property was updated.
    expect(controller.passwordGlob, password);

    // Verify navigation to the next screen.
    expect(find.text('DOB Security Screen'), findsOneWidget);
  });
}
