import 'package:flutter/material.dart';

import '../../models/books.dart';
import '../../widgets/archive.dart';

class BookDetails extends StatelessWidget {
  final Books? details;
  const BookDetails({super.key, this.details});
  @override
  Widget build(BuildContext context) {
    final b = details!;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailHeader(
              category: 'Book',
              title: b.name ?? 'Unknown',
              subtitle: (b.authors ?? []).join(', '),
            ),
            DetailRow(
              'Released',
              b.released?.toIso8601String().split('T').first ?? '',
            ),
            DetailRow('Pages', b.numberOfPages?.toString() ?? ''),
            DetailRow('Publisher', b.publisher ?? ''),
            DetailRow('Format', b.mediaType ?? ''),
            DetailRow('ISBN', b.isbn ?? ''),
            const SizedBox(height: 24),
            Text(
              '${b.characters?.length ?? 0} characters recorded',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${b.povCharacters?.length ?? 0} point-of-view characters recorded',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
