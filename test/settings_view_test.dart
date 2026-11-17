import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  group('SettingsView widget tests', () {
    testWidgets('SettingsView displays form fields and switch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsView()));

      expect(find.text('Customer Profile'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.byType(Switch), findsOneWidget);
      expect(find.text('SAVE SETTINGS'), findsOneWidget);
    });

    testWidgets('Entering details, toggling switch and saving updates state',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsView()));

      await tester.enterText(
        find.widgetWithText(TextField, 'Full name'),
        'Alex Smith',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Address'),
        '10 Elm Road, Portsmouth',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Email address'),
        'alex@example.com',
      );

      final Finder switchFinder = find.byType(Switch);
      expect(tester.widget<Switch>(switchFinder).value, isFalse);
      await tester.tap(switchFinder);
      await tester.pump();
      expect(tester.widget<Switch>(switchFinder).value, isTrue);

      await tester.tap(find.text('SAVE SETTINGS'));
      await tester.pump();

      expect(find.text('Settings saved for Alex Smith'), findsOneWidget);
    });
  });
}
