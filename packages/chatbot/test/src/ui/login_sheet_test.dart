import 'package:etiya_chatbot_flutter/etiya_chatbot_flutter.dart';
import 'package:etiya_chatbot_flutter/src/ui/login_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginSheet Tests', () {
    testWidgets(
        'Login form should validate email and password before submitting',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginSheet(),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('tr', ''),
          ],
        ),
      );

      final Finder emailField = find.byType(TextFormField).first;
      final Finder passwordField = find.byType(TextFormField).last;
      final Finder loginButton = find.text('Login');

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');

      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('Login button should trigger validation and submission',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginSheet(),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('tr', ''),
          ],
        ),
      );

      final Finder loginButton = find.byType(MaterialButton);

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.text('Enter non-empty password'), findsOneWidget);
      expect(find.text('Enter valid email'), findsOneWidget);

      await tester.enterText(
        find.byType(TextFormField).first,
        'correct@example.com',
      );
      await tester.enterText(
        find.byType(TextFormField).last,
        'correctPassword',
      );
      await tester.tap(loginButton);
      await tester.pump();
    });

    testWidgets('should toggle password visibility when IconButton is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginSheet(),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('tr', ''),
          ],
        ),
      );

      expect(find.byIcon(Icons.visibility_off), findsNothing);
      expect(find.byIcon(Icons.visibility), findsOneWidget);

      final Finder iconButton = find.byType(IconButton);
      await tester.tap(iconButton);
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsNothing);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      await tester.tap(iconButton);
      await tester.pump();

      expect(find.byIcon(Icons.visibility_off), findsNothing);
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
    testWidgets('LoginButton widget test', (WidgetTester tester) async {
      const buttonText = 'Login';
      final buttonStyle = OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.blue),
      );
      bool isPressed = false;

      void onPressed() {
        isPressed = true;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginButton(
              buttonText: buttonText,
              onPressed: onPressed,
              buttonStyle: buttonStyle,
            ),
          ),
        ),
      );

      expect(find.text(buttonText), findsOneWidget);

      final OutlinedButton outlinedButton =
          tester.widget(find.byType(OutlinedButton));
      expect(outlinedButton.style, buttonStyle);

      await tester.tap(find.byType(OutlinedButton));
      await tester.pump();

      expect(isPressed, true);
    });
  });
}
