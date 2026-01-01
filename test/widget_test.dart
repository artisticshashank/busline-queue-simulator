// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:busline/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BusLineApp());

    // Verify that the app title is present (or basic UI structure)
    // Note: This might still fail if Supabase requires initialization which isn't mocked here.
    // Ideally we should mock Supabase or just check that the widgets render.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
