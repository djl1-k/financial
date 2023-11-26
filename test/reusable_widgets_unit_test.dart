import 'package:financial_app/view/reusable_widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_app/view/reusable_widgets/my_button.dart';

void main() {
  testWidgets('MyButton Widget Test', (WidgetTester tester) async {

    // Build a sample MyButton
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyButton(
            text: 'Press me',
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.byType(MyButton), findsOneWidget);

    expect(find.text('Press me'), findsOneWidget);

  });

  testWidgets('MyTextField Widget Test', (WidgetTester tester) async {
    // Create a TextEditingController for testing
    final TextEditingController controller = TextEditingController();

    // Build a sample MyTextField 
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyTextField(
            hintText: 'Enter text',
            obscureText: true,
            controller: controller,
            maxLine: 1,
          ),
        ),
      ),
    );

    // Test if hintText is getting passed corrctly.
    expect(find.text('Enter text'), findsOneWidget);

    // Test if there is a textfield with the obscureText true is present
    final textFieldFinder = find.byType(TextField);
    expect(tester.widget<TextField>(textFieldFinder).obscureText, true);

    // Enter text into the text field and check if the test is being stored inside controller.
    await tester.enterText(textFieldFinder, 'Test Input');
    expect(controller.text, 'Test Input');

  });

  
}
