import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utilities/housesPagination.dart';
import '../../widgets/archive.dart';
import 'houseDetails.dart';

class HousessScreen extends ConsumerStatefulWidget {
  const HousessScreen({super.key});
  @override
  ConsumerState<HousessScreen> createState() => _HousessScreenState();
}

class _HousessScreenState extends ConsumerState<HousessScreen> {
  String? error;
  @override
  void initState() {
    super.initState();
    Future.microtask(load);
  }

  Future<void> load() async {
    try {
      await ref.read(housesPaginationController.notifier).getHouses();
      if (mounted && error != null) setState(() => error = null);
    } catch (_) {
      if (mounted) setState(() => error = 'Unable to load houses.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final houses = ref.watch(housesPaginationController).houses ?? [];
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(housesPaginationController);
            await load();
          },
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: ArchiveHeader(
                  title: 'Houses',
                  subtitle: 'Great houses and lesser houses, their seats and their words.',
                  chapter: '02 / THE CHRONICLES',
                ),
              ),
              if (houses.isEmpty)
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
                    if (index == houses.length - 1) {
                      Future.microtask(load);
                    }
                    final house = houses[index];
                    return ArchiveEntry(
                      number: 'HOUSE / ${index + 1}',
                      title: house.name ?? 'Unknown',
                      subtitle: house.region ?? '',
                      icon: Icons.shield_outlined,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HouseDetails(details: house),
                        ),
                      ),
                    );
                  }, childCount: houses.length),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
