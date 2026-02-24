
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:moolah/screens/blacklist/blacklist_screen.dart';
import 'package:moolah/util/common_widgets/common_button.dart';
import 'package:moolah/util/common_widgets/common_text_field.dart';

void main() {
  // A helper function to wrap widgets in a MaterialApp for testing.
  Widget buildTestableWidget(Widget child) {
    return GetMaterialApp(home: child);
  }

  testWidgets('BlackListScreen should render initial UI correctly', (WidgetTester tester) async {
    // Build the BlackListScreen widget.
    await tester.pumpWidget(buildTestableWidget(const BlackListScreen()));
    await tester.pumpAndSettle();

    // Verify the AppBar title and initial action button text.
    expect(find.text('Black Listed URL'), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget, reason: "Should find the 'Edit' button in the AppBar");
    expect(find.text('Save'), findsNothing);

    // Verify the main content.
    expect(find.widgetWithText(CustomButton, 'Add URL'), findsOneWidget, reason: "Should find the 'Add URL' button");
    expect(find.text('https://www.fiverr.com/cp/product-release-2023'), findsNWidgets(5), reason: "Should find 5 hardcoded URL items");
  });

  testWidgets('BlackListScreen should toggle edit mode', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const BlackListScreen()));
    await tester.pumpAndSettle();

    // Verify initial state (not in edit mode).
    final initialUrlText = tester.widget<Text>(find.text('https://www.fiverr.com/cp/product-release-2023').first);
    expect(initialUrlText.style?.color, Colors.red, reason: "URL text should be red when not in edit mode");

    // Tap the 'Edit' button to enter edit mode.
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    // Verify UI changes in edit mode.
    expect(find.text('Save'), findsOneWidget, reason: "Button text should change to 'Save'");
    expect(find.text('Edit'), findsNothing);
    expect(find.widgetWithText(CustomButton, 'Add URL'), findsNothing, reason: "'Add URL' button should be hidden in edit mode");

    final editedUrlText = tester.widget<Text>(find.text('https://www.fiverr.com/cp/product-release-2023').first);
    expect(editedUrlText.style?.color, Colors.black, reason: "URL text should be black when in edit mode");

    // Tap the 'Save' button to exit edit mode.
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify the UI returns to its initial state.
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Save'), findsNothing);
    expect(find.widgetWithText(CustomButton, 'Add URL'), findsOneWidget);
  });

  testWidgets('BlackListScreen should show and hide the add URL dialog', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const BlackListScreen()));
    await tester.pumpAndSettle();

    // The dialog should not be visible initially.
    expect(find.byType(AlertDialog), findsNothing);

    // Tap the 'Add URL' button to show the dialog.
    await tester.tap(find.widgetWithText(CustomButton, 'Add URL'));
    await tester.pumpAndSettle();

    // Verify the dialog is now visible with its content.
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Black List URL'), findsOneWidget);
    expect(find.byType(CustomTextField), findsOneWidget, reason: "Should find a text field for the URL");
    expect(find.widgetWithText(CustomButton, 'Black List'), findsOneWidget, reason: "Should find a 'Black List' button in the dialog");

    // Enter text into the text field.
    await tester.enterText(find.byType(CustomTextField), 'https://example.com');
    await tester.pump();

    // Tap the 'Black List' button to close the dialog.
    // Note: The test can't verify the item is added because the logic is not implemented.
    await tester.tap(find.widgetWithText(CustomButton, 'Black List'));
    await tester.pumpAndSettle();

    // Verify the dialog is now closed.
    expect(find.byType(AlertDialog), findsNothing);
  });
}
