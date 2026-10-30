import 'package:flutter/material.dart';

import '../iceTheme.dart';
import '../screens/moreScreen.dart';

class ArchiveHeader extends StatelessWidget {
  final String title, subtitle, chapter;
  const ArchiveHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.chapter,
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'THE WORLD OF ICE & FIRE',
                style: TextStyle(
                  fontFamily: 'sans-serif',
                  color: frost,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ),
            IconButton(
              tooltip: 'About',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MoreScreen()),
              ),
              icon: const Icon(Icons.info_outline, size: 20),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          chapter,
          style: const TextStyle(
            fontFamily: 'sans-serif',
            color: ember,
            fontSize: 11,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 38,
            height: 1.05,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'sans-serif',
            color: frost,
            height: 1.5,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.ac_unit, color: frost, size: 14),
            ),
            Expanded(child: Divider()),
          ],
        ),
      ],
    ),
  );
}

class ArchiveEntry extends StatelessWidget {
  final String number, title, subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const ArchiveEntry({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 60,
            decoration: BoxDecoration(
              color: panel,
              border: Border.all(color: const Color(0xff34434a)),
            ),
            child: Icon(icon, color: frost, size: 23),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: const TextStyle(
                    fontFamily: 'sans-serif',
                    color: ember,
                    fontSize: 10,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(title, style: const TextStyle(fontSize: 19, height: 1.2)),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'sans-serif',
                      color: frost,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.arrow_forward_ios, size: 13, color: frost),
        ],
      ),
    ),
  );
}

class DetailHeader extends StatelessWidget {
  final String category, title, subtitle;
  const DetailHeader({
    super.key,
    required this.category,
    required this.title,
    this.subtitle = '',
  });
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        category.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'sans-serif',
          color: ember,
          letterSpacing: 2,
          fontSize: 11,
        ),
      ),
      const SizedBox(height: 12),
      Text(title, style: const TextStyle(fontSize: 34, height: 1.1)),
      if (subtitle.isNotEmpty) ...[
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: const TextStyle(color: frost, fontSize: 16, height: 1.4),
        ),
      ],
      const SizedBox(height: 24),
      const Divider(),
      const SizedBox(height: 12),
    ],
  );
}

class DetailRow extends StatelessWidget {
  final String label, value;
  const DetailRow(this.label, this.value, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 95,
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'sans-serif',
              color: frost,
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value.trim().isEmpty ? 'Unknown' : value,
            style: const TextStyle(fontSize: 16, height: 1.35),
          ),
        ),
      ],
    ),
  );
}
