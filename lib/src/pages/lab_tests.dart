// lib/src/pages/lab_tests.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class LabTestsPage extends StatelessWidget {
  const LabTestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Lab Tests',
      headerIcon: Icons.assignment_outlined,
      gradient: [Color(0xFF0B84F3), Color(0xFF0969C2)],
    );
  }
}
