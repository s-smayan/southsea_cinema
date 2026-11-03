import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('creates Movie instance with given properties', () {
      const movie = Movie(
        id: 'test-movie',
        title: 'Test Movie',
        synopsis: 'A test synopsis.',
        ageRating: '15',
        screeningTime: 'Monday 16 Nov 2026, 18:00',
        price: 6.25,
        posterPath: 'assets/images/scarface.jpg',
      );

      expect(movie.id, 'test-movie');
      expect(movie.title, 'Test Movie');
      expect(movie.synopsis, 'A test synopsis.');
      expect(movie.ageRating, '15');
      expect(movie.screeningTime, 'Monday 16 Nov 2026, 18:00');
      expect(movie.price, 6.25);
      expect(movie.posterPath, 'assets/images/scarface.jpg');
    });

    test('formattedPrice shows a whole-pound price with two decimals', () {
      const movie = Movie(
        id: 'test-movie',
        title: 'Test Movie',
        synopsis: 'A test synopsis.',
        ageRating: '15',
        screeningTime: 'Monday 16 Nov 2026, 18:00',
        price: 8.0,
        posterPath: 'assets/images/scarface.jpg',
      );

      expect(movie.formattedPrice, '£8.00');
    });

    test('formattedPrice shows a price with pence', () {
      const movie = Movie(
        id: 'test-movie',
        title: 'Test Movie',
        synopsis: 'A test synopsis.',
        ageRating: '15',
        screeningTime: 'Monday 16 Nov 2026, 18:00',
        price: 6.25,
        posterPath: 'assets/images/scarface.jpg',
      );

      expect(movie.formattedPrice, '£6.25');
    });
  });
}
