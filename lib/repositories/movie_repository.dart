import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return [
      const Movie(
        id: 'scarface',
        title: 'Scarface',
        synopsis:
            'In 1980 Miami, Cuban refugee Tony Montana claws his way up from '
            'nothing to become a powerful drug lord, but greed and paranoia '
            'threaten to destroy everything he has built.',
        ageRating: '18',
        screeningTime: 'Friday 13 Nov 2026, 19:30',
        price: 7.50,
        posterPath: 'assets/images/scarface.jpg',
      ),
      const Movie(
        id: 'fight-club',
        title: 'Fight Club',
        synopsis:
            'An insomniac office worker and a reckless soap salesman start an '
            'underground fight club that spirals into something far more '
            'dangerous.',
        ageRating: '18',
        screeningTime: 'Saturday 14 Nov 2026, 20:00',
        price: 7.50,
        posterPath: 'assets/images/fight_club.jpg',
      ),
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }
}