import 'package:dart_ice_and_fire/models/books.dart';
import 'package:dart_ice_and_fire/screens/books/bookDetails.dart';
import 'package:dart_ice_and_fire/screens/moreScreen.dart';
import 'package:dart_ice_and_fire/services/iceFireState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<List<Books>> booksData = watch(allBooksFuture);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Books'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings_sharp),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MoreScreen()))),
        ],
      ),
      body: booksData.when(
        data: (value) => RefreshIndicator(
          onRefresh: () => context.refresh(allBooksFuture),
          child: ListView.builder(
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) {
              var book = value[index];
              return Card(
                child: ListTile(
                  title: Text(book.name),
                  subtitle: Text(
                      "Released:${book.released.toString().split(' ')[0]}\nPages:${book.numberOfPages.toString()}"),
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
        loading: () => Center(child: const CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('${error.toString()}')),
      ),
    );
  }
}
