import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  setUp(() {
    rootBundle.clear();
  });

  group('App smoke tests', () {
    testWidgets('App displays HomeView as home', (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
      expect(find.text(appTitle), findsOneWidget);
    });

    testWidgets('Shows a loading indicator before films load',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Displays movie cards with titles and booking buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      expect(find.byType(MovieCard), findsWidgets);
      expect(find.text('Scarface'), findsOneWidget);
      expect(find.text('Fight Club'), findsOneWidget);
      expect(find.text('BOOK NOW'), findsWidgets);
    });

    testWidgets('Tapping BOOK NOW opens MovieListing and shows feedback',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('BOOK NOW').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('SCARFACE (18)'), findsOneWidget);
      expect(find.text('Friday 13 Nov 2026, 19:30'), findsOneWidget);

      await tester.tap(find.text('ADD TO ORDER'));
      await tester.pump();

      expect(find.text('Added 1 tickets to the order'), findsOneWidget);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
      expect(find.byType(MovieListing), findsNothing);

      await tester.tap(find.text('BOOK NOW').last);
      await tester.pumpAndSettle();

      expect(find.text('FIGHT CLUB (18)'), findsOneWidget);
      expect(find.text('Saturday 14 Nov 2026, 20:00'), findsOneWidget);
      expect(find.text('Added 1 tickets to the order'), findsNothing);
    });
  });
}
