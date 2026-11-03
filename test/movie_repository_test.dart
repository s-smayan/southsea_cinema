import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository unit tests', () {
    test('getMovies returns two movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);
    });

    test('getMovies contains valid Scarface and Fight Club', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      final Movie scarface = movies[0];
      expect(scarface.id, 'scarface');
      expect(scarface.title, 'Scarface');
      expect(scarface.price, 7.50);
      expect(scarface.posterPath, isNotEmpty);

      final Movie fightClub = movies[1];
      expect(fightClub.id, 'fight-club');
      expect(fightClub.title, 'Fight Club');
      expect(fightClub.price, 7.50);
      expect(fightClub.posterPath, isNotEmpty);
    });

    test('getMovieById returns matching movie when id exists', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('scarface');

      expect(movie, isNotNull);
      expect(movie?.title, 'Scarface');
      expect(movie?.price, 7.50);
    });

    test('getMovieById returns null when id does not exist', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('non-existent');

      expect(movie, isNull);
    });
  });
}
