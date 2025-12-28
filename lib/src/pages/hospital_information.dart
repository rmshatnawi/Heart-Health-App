// lib/src/pages/hospital_information.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

class HospitalInformationPage extends StatelessWidget {
  const HospitalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Hospital Information',
      titleAr: 'معلومات المستشفى',
      headerIcon: Icons.local_hospital_outlined,
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
