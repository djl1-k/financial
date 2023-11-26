// ignore_for_file: prefer_const_constructors, avoid_print


import 'package:financial_app/view/pages/login_page.dart';
import 'package:financial_app/view/reusable_widgets/my_button.dart';
import 'package:financial_app/view/reusable_widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  testWidgets('Test LoginPage UI', (WidgetTester tester) async {    

    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    final appNameFinder = find.text('G A L A X Y R A Y');
    expect(appNameFinder, findsOneWidget);

    final appIconFinder = find.byIcon(Icons.account_balance);
    expect(appIconFinder, findsOneWidget);

    final subTitleFinder = find.text('In House Finance Tracker');
    expect(subTitleFinder, findsOneWidget);
    
    final myTextFieldFinder = find.byType(MyTextField);
    expect(myTextFieldFinder, findsNWidgets(2));

    final myButtonFinder = find.byType(MyButton);
    expect(myButtonFinder, findsOneWidget);

  });

}
