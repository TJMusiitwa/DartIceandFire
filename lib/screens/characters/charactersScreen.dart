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
            IconButton(
                icon: Icon(Icons.search_sharp),
                onPressed: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                }),
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

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear_sharp),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: Text('Jon Snow'),
        ),
        ListTile(
          title: Text('Arya Stark'),
        ),
        ListTile(
          title: Text('Lord Baelish'),
        ),
      ],
    );
  }
}
