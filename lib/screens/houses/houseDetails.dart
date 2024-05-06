import 'package:dart_ice_and_fire/models/houses.dart';
import 'package:dart_ice_and_fire/utilities/charactersPagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HouseDetails extends StatelessWidget {
  final Houses? details;

  const HouseDetails({super.key, this.details});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          details!.name!,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Region'),
                Text(details!.region == '' ? 'N/A' : details!.region!)
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Words'),
                Text(details!.words == '' ? 'N/A' : details!.words!)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Founded'),
                Text(details!.founded == '' ? 'N/A' : details!.founded!)
              ],
            ),
            const SizedBox(height: 10),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Current Lord'),
            //     Text(details.currentLord == '' ? 'N/A' : details.currentLord)
            //   ],
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Titles'),
                Text(details!.titles!.first == '' || details!.titles!.isEmpty
                    ? 'N/A'
                    : details!.titles!.first)
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Seats'),
                Text(details!.seats!.isEmpty && details!.seats!.first == ''
                    ? 'No Seats'
                    : details!.seats!.first)
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Sworn members to ${details!.name!}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Consumer(
              builder: (context, ref, child) {
                var swornMembers =
                    ref.watch(characterPaginationController).characters;
                final paginationController =
                    ref.watch(characterPaginationController.notifier);
                return Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: List<Widget>.generate(
                    details!.swornMembers!.length,
                    (index) {
                      paginationController.handleScrollWithIndex(index);
                      return Chip(
                          label: Text(swornMembers![index].name!.isNotEmpty
                              ? swornMembers[index].name!
                              : swornMembers[index].aliases!.first.isNotEmpty
                                  ? swornMembers[index].aliases!.first
                                  : ''));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
