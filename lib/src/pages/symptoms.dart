// lib/src/pages/symptoms.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class SymptomsPage extends StatelessWidget {
  const SymptomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Symptoms',
      headerIcon: Icons.monitor_heart_outlined,
      gradient: [Color(0xFF2F73FF), Color(0xFF1F66F2)],
    );
  }
}
