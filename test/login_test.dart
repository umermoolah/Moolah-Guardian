
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/authController.dart';
import 'package:moolah/screens/login/login.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_text_field.dart';

// A mock AuthController for testing purposes.
// This fake implementation allows us to test the UI in isolation.
class MockAuthController extends GetxController {
  var isLoading = false.obs;
  var isAuthenticated = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    if (email == 'test@example.com' && password == 'password') {
      isAuthenticated.value = true;
    }
    isLoading.value = false;
  }
}

void main() {
  // Use setUp and tearDown to ensure a clean state for each test.
  setUp(() {
    // Register our mock controller with GetX.
    Get.put<AuthController>(MockAuthController());
  });

  tearDown(() {
    // Reset GetX after each test.
    Get.reset();
  });

  // A helper function to wrap widgets in a MaterialApp for testing.
  Widget buildTestableWidget(Widget child) {
    return GetMaterialApp(home: child);
  }

  testWidgets('Login screen should render all UI elements', (WidgetTester tester) async {
    // Build the Login widget.
    await tester.pumpWidget(buildTestableWidget(Login()));
    await tester.pumpAndSettle();

    // Verify that all the expected widgets are on the screen.
    expect(find.text('Login'), findsNWidgets(2), reason: "Should find a heading and a button titled 'Login'");
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.byType(CustomTextField), findsNWidgets(2), reason: "Should find Email and Password text fields");
    expect(find.byType(CustomButton), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Don’t have an account?'), findsOneWidget);
  });

  testWidgets('Should show validation errors for empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(Login()));
    await tester.pumpAndSettle();

    // Tap the login button without entering any text.
    await tester.tap(find.widgetWithText(CustomButton, 'Login'));
    await tester.pump(); // Let the UI rebuild to show validation messages.

    // Because the exact validation messages aren't in the provided code,
    // we'll check for non-empty validation error text.
    // You should replace "Email is required" and "Password is required"
    // with your actual validation messages.
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('Should call login on controller when form is valid', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(Login()));
    await tester.pumpAndSettle();

    // Get a reference to our mock controller.
    final authController = Get.find<AuthController>() as MockAuthController;

    // Find the email and password fields.
    final emailField = find.byType(CustomTextField).first;
    final passwordField = find.byType(CustomTextField).last;

    // Enter valid credentials.
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password');
    await tester.pump();

    // Tap the login button.
    await tester.tap(find.widgetWithText(CustomButton, 'Login'));
    await tester.pump(); // Let the UI rebuild and show the loader.

    // Check that the loading indicator is shown.
    expect(authController.isLoading.value, isTrue);
    await tester.pumpAndSettle(); // Wait for the login future to complete.

    // Check that the user is marked as authenticated.
    expect(authController.isAuthenticated.value, isTrue);
  });
}
