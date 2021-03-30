import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_test/main.dart';
import 'package:firebase_test/pages/home.dart';
import 'package:firebase_test/setup/logIn.dart';

void main() {
  testWidgets('Sign In to the system without providing a password',
      (WidgetTester tester) async {
    // Find all widgets needed
    final emailField = find.byKey(ValueKey('emailField'));
    final passwordField = find.byKey(ValueKey('passwordField'));
    final loginButton = find.byKey(ValueKey('loginButton'));

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Insert email into emailField
    await tester.enterText(emailField, 'a.meshref@alustudent.com');
    // Insert incorrect password into passwordField
    await tester.enterText(passwordField, '');
    // Press the button
    await tester.tap(loginButton);

    await tester.pump(); // Rebuild the widget

    // Verify that our counter has incremented.
    expect(find.text('welcome a.meshref@alustudent.com'), findsNothing);
    expect(
        find.text('Password should contain at least 7 chars'), findsOneWidget);
    expect(find.text('Insert email'), findsNothing);
  });

  testWidgets('Sign In to the system without providing an email',
      (WidgetTester tester) async {
    // Find all widgets needed
    final emailField = find.byKey(ValueKey('emailField'));
    final passwordField = find.byKey(ValueKey('passwordField'));
    final loginButton = find.byKey(ValueKey('loginButton'));

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Insert email into emailField
    await tester.enterText(emailField, '');
    // Insert incorrect password into passwordField
    await tester.enterText(passwordField, 'jasdjksajdsakdjksa');
    // Press the button
    await tester.tap(loginButton);

    await tester.pump(); // Rebuild the widget

    // Verify that our counter has incremented.
    expect(find.text('welcome a.meshref@alustudent.com'), findsNothing);
    expect(find.text('Password should contain at least 7 chars'), findsNothing);
    expect(find.text('Insert email'), findsOneWidget);
  });

  testWidgets('Sign In to the system with correct credientials',
      (WidgetTester tester) async {
    // Find all widgets needed
    final emailField = find.byKey(ValueKey('emailField'));
    final passwordField = find.byKey(ValueKey('passwordField'));
    final loginButton = find.byKey(ValueKey('loginButton'));

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Insert email into emailField
    await tester.enterText(emailField, 'a.meshref@alustudent.com');
    // Insert incorrect password into passwordField
    await tester.enterText(passwordField, '123456789');
    // Press the button
    await tester.tap(loginButton);

    await tester.pumpAndSettle(); // Rebuild the widget

    // Verify that our counter has incremented.
    expect(find.text('Wrong password provided for that user'), findsNothing);
    expect(find.text('No user found for that email.'), findsNothing);
  });
}
