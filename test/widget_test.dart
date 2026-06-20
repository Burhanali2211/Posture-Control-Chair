import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posture_chair_companion/main.dart';

void main() {
  testWidgets('App launches without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PostureChairApp()));
    expect(find.byType(MaterialApp), findsNothing); // MaterialApp.router used
    expect(find.byType(Router<Object>), findsOneWidget);
  });
}
