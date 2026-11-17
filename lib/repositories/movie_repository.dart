import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie>? _cachedMovies;

  List<Movie> getMovies() {
    final List<Movie>? cachedMovies = _cachedMovies;
    if (cachedMovies != null) {
      return cachedMovies;
    }

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

  Future<List<Movie>> loadMoviesFromAsset({
    String assetPath = 'assets/data/movies.json',
  }) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final dynamic decodedData = jsonDecode(jsonString);
    final List<dynamic> jsonList = decodedData as List<dynamic>;
    final List<Movie> loadedMovies = [];

    for (final dynamic item in jsonList) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      final Movie movie = Movie.fromJson(itemMap);
      loadedMovies.add(movie);
    }

    _cachedMovies = loadedMovies;
    return loadedMovies;
  }
}