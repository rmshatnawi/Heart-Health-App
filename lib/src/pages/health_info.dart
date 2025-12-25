// lib/src/pages/health_info.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class HealthInfoPage extends StatelessWidget {
  const HealthInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Health Info',
      headerIcon: Icons.info_outline,
      gradient: [Color(0xFF8E44FF), Color(0xFF6E2EDB)],
    );
  }
}
