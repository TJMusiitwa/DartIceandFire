import 'package:flutter/material.dart' hide Characters;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/characters.dart';
import '../../services/iceFireState.dart';
import '../../widgets/archive.dart';
import '../books/bookDetails.dart';
import '../houses/houseDetails.dart';

String characterName(Characters c) => (c.name ?? '').isNotEmpty
    ? c.name!
    : (c.aliases ?? []).where((a) => a.isNotEmpty).firstOrNull ?? 'Unknown';
String firstValue(List<String>? values) =>
    (values ?? []).where((v) => v.isNotEmpty).firstOrNull ?? '';

class CharacterDetails extends StatelessWidget {
  final Characters? details;
  const CharacterDetails({super.key, this.details});
  @override
  Widget build(BuildContext context) {
    final c = details!;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailHeader(
              category: 'Character',
              title: characterName(c),
              subtitle: firstValue(c.titles),
            ),
            DetailRow('Born', c.born ?? ''),
            DetailRow('Died', c.died ?? ''),
            DetailRow('Culture', c.culture ?? ''),
            DetailRow('Gender', c.gender ?? ''),
            DetailRow('Alias', firstValue(c.aliases)),
            const SizedBox(height: 24),
            const Text('House allegiances', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            if ((c.allegiances ?? []).isEmpty)
              const Text('No allegiance recorded.')
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: c.allegiances!
                    .map((url) => AllegianceChip(url: url))
                    .toList(),
              ),
            const SizedBox(height: 28),
            const Text('Book appearances', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            if ((c.books ?? []).isEmpty)
              const Text('No appearances recorded.')
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: c.books!.map((url) => BookChip(url: url)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class AllegianceChip extends ConsumerWidget {
  final String url;
  const AllegianceChip({super.key, required this.url});
  @override
  Widget build(BuildContext context, WidgetRef ref) => ref
      .watch(oneHouseFuture(url))
      .when(
        data: (house) => ActionChip(
          label: Text(house.name ?? 'Unknown'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HouseDetails(details: house)),
          ),
        ),
        loading: () => const Chip(label: Text('Loading house')),
        error: (_, _) => const Chip(label: Text('House unavailable')),
      );
}

class BookChip extends ConsumerWidget {
  final String url;
  const BookChip({super.key, required this.url});
  @override
  Widget build(BuildContext context, WidgetRef ref) => ref
      .watch(oneBookFuture(url))
      .when(
        data: (book) => ActionChip(
          label: Text(book.name ?? 'Unknown'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookDetails(details: book)),
          ),
        ),
        loading: () => const Chip(label: Text('Loading book')),
        error: (_, _) => const Chip(label: Text('Book unavailable')),
      );
}
