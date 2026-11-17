import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

const Movie testMovie1 = Movie(
  id: 'test-1',
  title: 'Test Movie One',
  synopsis: 'First test film.',
  ageRating: '15',
  screeningTime: 'Monday 16 Nov 2026, 18:00',
  price: 10.0,
  posterPath: 'assets/images/scarface.jpg',
);

const Movie testMovie2 = Movie(
  id: 'test-2',
  title: 'Test Movie Two',
  synopsis: 'Second test film.',
  ageRating: '12A',
  screeningTime: 'Tuesday 17 Nov 2026, 20:00',
  price: 6.0,
  posterPath: 'assets/images/fight_club.jpg',
);

void main() {
  setUp(() {
    BasketRepository.instance.clear();
  });

  group('BasketRepository tests', () {
    test('starts with an empty basket and zero total', () {
      final BasketRepository basket = BasketRepository.instance;
      expect(basket.getItems().length, 0);
      expect(basket.getTotalTickets(), 0);
      expect(basket.getTotal(), 0.0);
    });

    test('adds tickets and calculates the total', () {
      final BasketRepository basket = BasketRepository.instance;
      basket.addItem(const BasketItem(movie: testMovie1, quantity: 2));
      basket.addItem(const BasketItem(movie: testMovie2, quantity: 1));

      expect(basket.getItems().length, 2);
      expect(basket.getTotalTickets(), 3);
      expect(basket.getTotal(), 26.0);
    });

    test('removes tickets correctly', () {
      final BasketRepository basket = BasketRepository.instance;
      basket.addItem(const BasketItem(movie: testMovie1, quantity: 1));
      expect(basket.getItems().length, 1);

      basket.removeItem(0);
      expect(basket.getItems().length, 0);
      expect(basket.getTotal(), 0.0);
    });

    test('clear empties the basket', () {
      final BasketRepository basket = BasketRepository.instance;
      basket.addItem(const BasketItem(movie: testMovie1, quantity: 3));
      basket.clear();

      expect(basket.getItems(), isEmpty);
      expect(basket.getTotal(), 0.0);
    });
  });
}
