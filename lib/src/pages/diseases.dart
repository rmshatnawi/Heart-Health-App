// lib/src/pages/diseases.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class DiseasesPage extends StatelessWidget {
  const DiseasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Diseases',
      headerIcon: Icons.medical_services_outlined,
      gradient: [Color(0xFF1BAA8B), Color(0xFF138C73)],
    );
  }
}
