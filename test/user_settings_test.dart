import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';

void main() {
  group('UserSettings model tests', () {
    test('default UserSettings has empty fields and no newsletter', () {
      const UserSettings settings = UserSettings();

      expect(settings.name, isEmpty);
      expect(settings.address, isEmpty);
      expect(settings.email, isEmpty);
      expect(settings.receiveNewsletter, isFalse);
    });

    test('configured UserSettings stores the given values', () {
      const UserSettings settings = UserSettings(
        name: 'Alex Smith',
        address: '10 Elm Road, Portsmouth',
        email: 'alex@example.com',
        receiveNewsletter: true,
      );

      expect(settings.name, 'Alex Smith');
      expect(settings.address, '10 Elm Road, Portsmouth');
      expect(settings.email, 'alex@example.com');
      expect(settings.receiveNewsletter, isTrue);
    });
  });
}