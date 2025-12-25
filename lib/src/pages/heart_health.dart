// lib/src/pages/heart_health.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class HeartHealthPage extends StatelessWidget {
  const HeartHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Heart Health',
      headerIcon: Icons.favorite_border,
      gradient: [Color(0xFFE53935), Color(0xFFD32F2F)],
    );
  }
}
