import 'package:dart_ice_and_fire/screens/characters/characterDetails.dart';
import 'package:dart_ice_and_fire/utilities/charactersPagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../moreScreen.dart';

class CharactersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final paginationController = watch(characterPaginationController);
    final paginationState = watch(characterPaginationController.state);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Characters'),
          actions: [
            // IconButton(
            //     icon: Icon(Icons.search_sharp),
            //     onPressed: () {
            //       showSearch(
            //           context: context,
            //           delegate: SearchPage(
            //             builder: (character) => ListTile(
            //               title: Text(character.name),
            //             ),
            //             itemStartsWith: true,
            //             filter: (character) =>
            //                 [character.name, character.aliases],
            //             items: paginationState.characters.,
            //             searchLabel: 'Search for your favourite characters',
            //             suggestion: Center(
            //               child: Text('Search by name or alias'),
            //             ),
            //             failure: Center(
            //               child: Text('No character found'),
            //             ),
            //           ));
            //     }),
            IconButton(
                icon: Icon(Icons.settings_sharp),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MoreScreen()))),
          ],
        ),
        body: Consumer(builder: (context, watch, child) {
          return RefreshIndicator(
            onRefresh: () =>
                context.refresh(characterPaginationController).getCharacters(),
            child: ListView.builder(
              itemCount: paginationState.characters.length,
              itemBuilder: (BuildContext context, int index) {
                paginationController.handleScrollWithIndex(index);
                var character = paginationState.characters[index];
                return Card(
                  child: ListTile(
                    title: Text(character.name.isNotEmpty
                        ? character.name
                        : character.aliases.first),
                    subtitle: Text(character.culture ?? ''),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CharacterDetails(
                                  details: character,
                                ),
                            fullscreenDialog: true)),
                  ),
                );
              },
            ),
          );
        }));
  }
}
