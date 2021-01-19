import 'package:dart_ice_and_fire/services/iceFireState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetails extends StatelessWidget {
  final bookUrl;

  BookDetails(this.bookUrl);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final response = watch(oneBookFuture(bookUrl));
        return response.when(
            data: (value) {
              var bookData = response.data.value;
              return Scaffold(
                appBar: AppBar(
                  title: Text(bookData.name),
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Author'),
                          Text(bookData.authors.first)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Released'),
                          Text(bookData.released.toString())
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Pages'),
                          Text(bookData.numberOfPages.toString())
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Publisher'), Text(bookData.publisher)],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 1,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Book Characters',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
            error: (e, s) => Center(
                  child: Text(e.toString()),
                ));
      },
    );
  }
}
