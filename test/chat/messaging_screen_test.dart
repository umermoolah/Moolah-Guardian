
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:moolah/controllers/homeController.dart';
import 'package:moolah/helper/models/message_model.dart';
import 'package:moolah/screens/chat/messaging_screen.dart';

// --- Mock HomeController ---
class MockHomeController extends GetxController {
  @override
  Future<List<MessageModel>> getMessages() async {
    // Simulate a network delay.
    await Future.delayed(const Duration(milliseconds: 100));
    // Return a controlled list of messages for the test.
    return [
      MessageModel(
        messageData: MessageData(message: 'Hello from child'),
      ),
      MessageModel(
        messageData: MessageData(message: 'Hi from me'),
      ),
      MessageModel(
        messageData: MessageData(message: 'How are you?'),
      ),
    ];
  }
}

void main() {
  setUp(() {
    Get.put<HomeController>(MockHomeController());
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildTestableWidget(Widget child) {
    return GetMaterialApp(
      home: child,
    );
  }

  testWidgets('MessagingScreen should render AppBar and messages', (WidgetTester tester) async {
    // Build the MessagingScreen widget.
    await tester.pumpWidget(buildTestableWidget(const MessagingScreen()));

    // Let the screen rebuild after fetching messages from the mock controller.
    await tester.pumpAndSettle();

    // --- Verify AppBar ---
    expect(find.text('John Campbell'), findsOneWidget);
    expect(find.text('Online'), findsOneWidget);

    // --- Verify Messages ---
    // The ListView is reversed, so the test data appears in a specific order.
    // The itemCount is messages.length + 1 because of a spacer.

    // Note: The logic `index % 2 == 0` determines if a message is from the child or the user.
    // This is brittle. A better implementation would have a 'sender' property on the message.
    // Based on the current logic, we test for the rendered text.

    expect(find.text('Hi from me'), findsOneWidget, reason: "My message should be visible");
    expect(find.text('Hello from child'), findsOneWidget, reason: "Child message should be visible");
    expect(find.text('How are you?'), findsOneWidget, reason: "A second child message should be visible");

    // --- Verify Message Input Field (which is commented out in the original code) ---
    // If the text field were visible, you could test it like this:
    // expect(find.widgetWithText(TextField, 'Type your message'), findsOneWidget);
  });
}
