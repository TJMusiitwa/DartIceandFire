import 'package:dart_ice_and_fire/models/characters.dart' show Characters;
import 'package:dart_ice_and_fire/services/iceFireState.dart';
import 'package:dart_ice_and_fire/utilities/housesPagination.dart';
import 'package:flutter/material.dart' hide Characters;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterDetails extends StatelessWidget {
  final Characters? details;

  const CharacterDetails({Key? key, this.details}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          details!.name!.isNotEmpty ? details!.name! : details!.aliases!.first,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Born'),
                Text(details!.born == '' ? 'N/A' : details!.born!)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Died'),
                Text(details!.died == '' ? 'N/A' : details!.died!)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Gender'),
                Text(details!.gender == '' ? 'N/A' : details!.gender!)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Culture'),
                Text(details!.culture == '' ? 'N/A' : details!.culture!)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Titles'),
                Text(details!.titles!.first == ''
                    ? 'N/A'
                    : details!.titles!.first),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Alias'),
                Text(details!.aliases!.first == ''
                    ? 'N/A'
                    : details!.aliases!.first)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [Text('Allegiances'), Text(details.allegiances.first)],
            // ),
            // SizedBox(
            //   height: 10,
            // ),

            Text('House Allegiances'),
            details!.allegiances!.isEmpty
                ? Text('No House Allegiance')
                : Consumer(
                    builder: (context, watch, child) {
                      var housesAlliedTo =
                          watch(housesPaginationController).houses;
                      final paginationController =
                          watch(housesPaginationController.notifier);

                      return Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: List<Widget>.generate(
                          details!.allegiances!.length,
                          (index) {
                            paginationController.handleScrollWithIndex(index);
                            return Chip(
                                label: Text(housesAlliedTo![index].name == ''
                                    ? 'N/A'
                                    : housesAlliedTo[index].name!));
                          },
                        ),
                      );
                    },
                  ),
            SizedBox(
              height: 10,
            ),
            Text('Book Appearences'),
            Consumer(builder: (context, watch, child) {
              var booksAppeared = watch(allBooksFuture).data!.value;
              return Wrap(
                spacing: 6,
                runSpacing: 6,
                runAlignment: WrapAlignment.start,
                children: List<Widget>.generate(
                  details!.books!.length,
                  (index) => Chip(label: Text(booksAppeared[index].name!)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
