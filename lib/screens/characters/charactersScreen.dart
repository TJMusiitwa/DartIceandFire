import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utilities/charactersPagination.dart';
import '../../widgets/archive.dart';
import 'characterDetails.dart';

class CharactersScreen extends ConsumerStatefulWidget {
  const CharactersScreen({super.key});
  @override
  ConsumerState<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends ConsumerState<CharactersScreen> {
  String? error;
  @override
  void initState() {
    super.initState();
    Future.microtask(load);
  }

  Future<void> load() async {
    try {
      await ref.read(characterPaginationController.notifier).getCharacters();
      if (mounted && error != null) setState(() => error = null);
    } catch (_) {
      if (mounted) setState(() => error = 'Unable to load characters.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final people = ref.watch(characterPaginationController).characters ?? [];
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(characterPaginationController);
            await load();
          },
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: ArchiveHeader(
                  title: 'Characters',
                  subtitle: 'The people, names and stories of the Seven Kingdoms and beyond.',
                  chapter: '01 / THE CHRONICLES',
                ),
              ),
              if (people.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: error == null
                        ? const CircularProgressIndicator()
                        : TextButton(
                            onPressed: load,
                            child: Text('$error Tap to retry'),
                          ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == people.length - 1) {
                      Future.microtask(load);
                    }
                    final person = people[index];
                    final aliases = person.aliases ?? [];
                    final name = (person.name ?? '').isNotEmpty
                        ? person.name!
                        : aliases.where((a) => a.isNotEmpty).firstOrNull ??
                              'Unknown';
                    return ArchiveEntry(
                      number: 'CHARACTER / ${index + 1}',
                      title: name,
                      subtitle: person.culture ?? '',
                      icon: Icons.person_outline,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CharacterDetails(details: person),
                        ),
                      ),
                    );
                  }, childCount: people.length),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
