import 'package:flutter/material.dart';

import '../../models/houses.dart';
import '../../widgets/archive.dart';
import '../characters/characterDetails.dart';

class HouseDetails extends StatelessWidget {
  final Houses? details;
  const HouseDetails({super.key, this.details});
  @override
  Widget build(BuildContext context) {
    final h = details!;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailHeader(
              category: 'House',
              title: h.name ?? 'Unknown',
              subtitle: h.words ?? '',
            ),
            DetailRow('Region', h.region ?? ''),
            DetailRow('Seat', firstValue(h.seats)),
            DetailRow('Founded', h.founded ?? ''),
            DetailRow('Titles', firstValue(h.titles)),
            DetailRow('Arms', h.coatOfArms ?? ''),
            const SizedBox(height: 24),
            Text(
              '${h.swornMembers?.length ?? 0} sworn members recorded',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
