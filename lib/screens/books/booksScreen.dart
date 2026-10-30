import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/iceFireState.dart';
import '../../widgets/archive.dart';
import 'bookDetails.dart';

class BooksScreen extends ConsumerWidget {
  const BooksScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(allBooksFuture);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(allBooksFuture);
            await ref.read(allBooksFuture.future);
          },
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: ArchiveHeader(
                  title: 'Books',
                  subtitle: 'Explore the volumes that hold the history of this world.',
                  chapter: '03 / THE CHRONICLES',
                ),
              ),
              books.when(
                data: (items) => items.isEmpty
                    ? const SliverFillRemaining(
                        child: Center(child: Text('No books found.')),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final book = items[index];
                          return ArchiveEntry(
                            number: 'VOLUME / ${index + 1}',
                            title: book.name ?? 'Unknown',
                            subtitle: [
                              if (book.released != null)
                                '${book.released!.year}',
                              if (book.numberOfPages != null)
                                '${book.numberOfPages} pages',
                            ].join('  ·  '),
                            icon: Icons.menu_book_outlined,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookDetails(details: book),
                              ),
                            ),
                          );
                        }, childCount: items.length),
                      ),
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, _) => SliverFillRemaining(
                  child: Center(
                    child: TextButton(
                      onPressed: () => ref.invalidate(allBooksFuture),
                      child: const Text('Unable to load books. Tap to retry'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
