import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 1;
  String _bookingMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SCARFACE (1983) (18)',
              style: cinemaHeaderStyle.copyWith(color: Colors.red),
            ),
            const SizedBox(height: 16),
            const Text('Southsea Cinema Room'),
            const SizedBox(height: 8),
            const Text('Friday 23 Oct 2026, 19:30 – ends at 22:20'),
            const SizedBox(height: 8),
            const Text('Runtime: 2h 50m'),
            const SizedBox(height: 16),
            const Text(
              'In 1980 Miami, Cuban refugee Tony Montana claws his way up from '
              'nothing to become a powerful drug lord, but greed and paranoia '
              'threaten to destroy everything he has built.',
            ),
            const SizedBox(height: 16),
            const Text('Select Quantities (Up to 5 in total)'),
            const SizedBox(height: 16),
            const Text(
              'Tickets',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final ticketDropdown = DropdownMenu<int>(
                  initialSelection: _ticketQuantity,
                  onSelected: (int? value) {
                    if (value != null) {
                      setState(() {
                        _ticketQuantity = value;
                        print('Tickets selected: $_ticketQuantity');
                      });
                    }
                  },
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 1, label: '1'),
                    DropdownMenuEntry(value: 2, label: '2'),
                    DropdownMenuEntry(value: 3, label: '3'),
                    DropdownMenuEntry(value: 4, label: '4'),
                    DropdownMenuEntry(value: 5, label: '5'),
                  ],
                );
                const ticketPrice = Text('Adult (£7.50)');

                if (constraints.maxWidth > 600) {
                  return Row(
                    children: [
                      ticketDropdown,
                      const SizedBox(width: 12),
                      ticketPrice,
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ticketDropdown,
                      const SizedBox(height: 8),
                      ticketPrice,
                    ],
                  );
                }
              },
            ),
            Text('Tickets selected: $_ticketQuantity'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: cinemaBrand,
                foregroundColor: cinemaFontWhite,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {
                setState(() {
                  _bookingMessage =
                      'Added $_ticketQuantity tickets to the order';
                });
                print(_bookingMessage);
              },
              child: const Text('ADD TO ORDER'),
            ),
            Text(_bookingMessage),
          ],
        ),
      ),
    );
  }
}
