import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({super.key, required this.movie});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 1;
  String _bookingMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.movie.title.toUpperCase()} (${widget.movie.ageRating})',
              style: cinemaHeaderStyle.copyWith(color: Colors.red),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.movie.posterPath,
                  width: 120,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(widget.movie.synopsis)),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Southsea Cinema Room'),
            const SizedBox(height: 8),
            Text(widget.movie.screeningTime),
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
                final ticketPrice = Text(
                  'Adult (${widget.movie.formattedPrice})',
                );

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
            PrimaryButton(
              label: 'ADD TO ORDER',
              onPressed: () {
                BasketRepository.instance.addItem(
                  BasketItem(movie: widget.movie, quantity: _ticketQuantity),
                );
                setState(() {
                  _bookingMessage =
                      'Added $_ticketQuantity tickets to the order';
                });
              },
            ),
            Text(_bookingMessage),
          ],
        ),
      ),
    );
  }
}
