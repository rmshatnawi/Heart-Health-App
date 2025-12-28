// lib/src/pages/caregiver_support.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

class CaregiverSupportPage extends StatelessWidget {
  const CaregiverSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Caregiver Support',
      titleAr: 'دعم مقدّم الرعاية',
      headerIcon: Icons.volunteer_activism_outlined,
      child: (isArabic) => Center(
        child: Text(
          isArabic ? 'سيتم إضافة المحتوى لاحقاً.' : 'Content will be added later.',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5A6C96),
          ),
        ),
      ),
    );
  }
}
