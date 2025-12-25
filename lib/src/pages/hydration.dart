// lib/src/pages/hydration.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class HydrationPage extends StatelessWidget {
  const HydrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Hydration',
      headerIcon: Icons.water_drop_outlined,
      gradient: [Color(0xFF2D7CFF), Color(0xFF1F66F2)],
    );
  }
}
