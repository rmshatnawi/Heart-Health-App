// lib/src/pages/prevention_tips.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class PreventionTipsPage extends StatelessWidget {
  const PreventionTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Prevention Tips',
      headerIcon: Icons.shield_outlined,
      gradient: [Color(0xFF00A38A), Color(0xFF008A75)],
    );
  }
}
