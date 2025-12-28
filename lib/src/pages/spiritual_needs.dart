// lib/src/pages/spiritual_needs.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

class SpiritualNeedsPage extends StatelessWidget {
  const SpiritualNeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Spiritual Needs',
      titleAr: 'الاحتياجات الروحية',
      headerIcon: Icons.self_improvement_outlined,
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
