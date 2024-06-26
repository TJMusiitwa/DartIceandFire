import 'package:dart_ice_and_fire/models/characters.dart' show Characters;
import 'package:dart_ice_and_fire/services/iceFireState.dart';
import 'package:dart_ice_and_fire/utilities/housesPagination.dart';
import 'package:flutter/material.dart' hide Characters;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterDetails extends StatelessWidget {
  final Characters? details;

  const CharacterDetails({super.key, this.details});
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
                const Text('Born'),
                Text(details!.born == '' ? 'N/A' : details!.born!)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text('Died'),
                Text(details!.died == '' ? 'N/A' : details!.died!)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text('Gender'),
                Text(details!.gender == '' ? 'N/A' : details!.gender!)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text('Culture'),
                Text(details!.culture == '' ? 'N/A' : details!.culture!)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Titles'),
                Text(details!.titles!.first == ''
                    ? 'N/A'
                    : details!.titles!.first),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Alias'),
                Text(details!.aliases!.first == ''
                    ? 'N/A'
                    : details!.aliases!.first)
              ],
            ),
            const SizedBox(
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
            Text(
              'House Allegiances',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(),
            details!.allegiances!.isEmpty
                ? const Text('No House Allegiance')
                : Consumer(
                    builder: (context, ref, child) {
                      var housesAlliedTo =
                          ref.watch(housesPaginationController).houses;
                      final paginationController =
                          ref.watch(housesPaginationController.notifier);

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
            const SizedBox(height: 10),
            Text(
              'Book Appearences',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(),
            Consumer(builder: (context, ref, child) {
              return ref.watch(allBooksFuture).when(
                  data: (booksAppeared) => Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        runAlignment: WrapAlignment.start,
                        children: List<Widget>.generate(
                          details!.books!.length,
                          (index) =>
                              Chip(label: Text(booksAppeared[index].name!)),
                        ),
                      ),
                  error: (_, __) =>
                      const Center(child: Text('Unable to load books')),
                  loading: () => const CircularProgressIndicator.adaptive());
            }),
          ],
        ),
      ),
    );
  }
}
