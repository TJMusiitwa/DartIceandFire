import 'package:dart_ice_and_fire/models/houses.dart';
import 'package:dart_ice_and_fire/utilities/charactersPagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HouseDetails extends StatelessWidget {
  final Houses details;

  const HouseDetails({Key key, this.details}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          details.name,
          overflow: TextOverflow.ellipsis,
        ),
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
                Text('Region'),
                Text(details.region == "" ? 'N/A' : details.region)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Words'),
                Text(details.words == "" ? 'N/A' : details.words)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Founded'),
                Text(details.founded == "" ? 'N/A' : details.founded)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Current Lord'),
            //     Text(details.currentLord == "" ? 'N/A' : details.currentLord)
            //   ],
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Titles'),
                Text(details.titles.first == "" || details.titles.isEmpty
                    ? 'N/A'
                    : details.titles.first)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Seats'),
                Text(details.seats.isEmpty && details.seats.first == ""
                    ? 'No Seats'
                    : details.seats.first)
              ],
            ),
            Divider(
              height: 1,
              color: Theme.of(context).primaryColorDark,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Sworn members to the house',
              style: Theme.of(context).textTheme.headline6,
            ),
            Consumer(
              builder: (context, watch, child) {
                var swornMembers =
                    watch(characterPaginationController.state).characters;
                final paginationController =
                    watch(characterPaginationController);
                return Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List<Widget>.generate(
                    details.swornMembers.length,
                    (index) {
                      paginationController.handleScrollWithIndex(index);
                      return Chip(
                          label: Text(swornMembers[index].name.isNotEmpty
                              ? swornMembers[index].name
                              : swornMembers[index].aliases.first.isNotEmpty
                                  ? swornMembers[index].aliases.first
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
