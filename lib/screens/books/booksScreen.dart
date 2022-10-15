import 'package:dart_ice_and_fire/screens/books/bookDetails.dart';
import 'package:dart_ice_and_fire/screens/moreScreen.dart';
import 'package:dart_ice_and_fire/services/iceFireState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var booksData = ref.watch(allBooksFuture);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Books'),
        actions: [
          IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MoreScreen()))),
        ],
      ),
      body: booksData.when(
        data: (value) => RefreshIndicator(
          onRefresh: () {
            ref.invalidate(allBooksFuture);
            return ref.refresh(allBooksFuture.future);
          },
          child: ListView.builder(
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) {
              var book = value[index];
              return Card(
                child: ListTile(
                  title: Text(book.name!),
                  subtitle: Text(
                      'Released:${book.released.toString().split(' ')[0]}\nPages:${book.numberOfPages.toString()}'),
                  isThreeLine: true,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BookDetails(
                                details: book,
                              ),
                          fullscreenDialog: true)),
                ),
              );
            },
          ),
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
