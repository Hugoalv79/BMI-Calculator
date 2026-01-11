// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:bmi_calculator/main.dart';

void main() {
  testWidgets('BMI Calculator loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BMICalculatorApp());

    // Verify that the BMI Calculator title is displayed.
    expect(find.text('BMI CALCULATOR'), findsOneWidget);

    // Verify that gender selection cards are present.
    expect(find.text('MALE'), findsOneWidget);
    expect(find.text('FEMALE'), findsOneWidget);

    // Verify that the calculate button is present.
    expect(find.text('CALCULATE BMI'), findsOneWidget);
  });
}
