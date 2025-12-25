// lib/src/pages/medications.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class MedicationsPage extends StatelessWidget {
  const MedicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Medications',
      headerIcon: Icons.local_pharmacy_outlined,
      gradient: [Color(0xFF6D5AE6), Color(0xFF5646D8)],
    );
  }
}
