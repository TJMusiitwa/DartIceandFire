import 'package:dart_ice_and_fire/utilities/housesPagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../moreScreen.dart';
import 'houseDetails.dart';

class HousessScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final paginationController = watch(housesPaginationController);
    final paginationState = watch(housesPaginationController.state);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Houses'),
        actions: [
          //IconButton(icon: Icon(Icons.search_sharp), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.settings_sharp),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MoreScreen()))),
        ],
      ),
      body: Consumer(
        builder: (context, watch, child) {
          if (paginationState.houses.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                context.refresh(housesPaginationController).getHouses(),
            child: ListView.builder(
              itemCount: paginationState.houses.length,
              itemBuilder: (BuildContext context, int index) {
                paginationController.handleScrollWithIndex(index);
                var house = paginationState.houses[index];
                return Card(
                  child: ListTile(
                    title: Text(house.name),
                    subtitle: Text(house.region ?? ''),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HouseDetails(
                                  details: house,
                                ),
                            fullscreenDialog: true)),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
