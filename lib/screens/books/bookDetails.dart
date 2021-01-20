import 'package:dart_ice_and_fire/models/books.dart';
import 'package:dart_ice_and_fire/utilities/charactersPagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetails extends StatelessWidget {
  final Books details;

  const BookDetails({Key key, this.details}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          details.name,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Author'), Text(details.authors.first)],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Released'),
                  Text(details.released.toString().split(' ')[0])
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
                  Text(details.numberOfPages.toString())
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Publisher'), Text(details.publisher)],
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
              Consumer(
                builder: (context, watch, child) {
                  var charactersAppeared =
                      watch(characterPaginationController.state).characters;
                  final paginationController =
                      watch(characterPaginationController);
                  return Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: List<Widget>.generate(
                      details.characters.length,
                      (index) {
                        paginationController.handleScrollWithIndex(index);
                        return Chip(
                            label: Text(charactersAppeared[index]
                                    .name
                                    .isNotEmpty
                                ? charactersAppeared[index].name
                                : charactersAppeared[index]
                                        .aliases
                                        .first
                                        .isNotEmpty
                                    ? charactersAppeared[index].aliases.first
                                    : ''));
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
