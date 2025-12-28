// lib/src/pages/tutorials_for_child_care_needs.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

class TutorialsForChildCareNeedsPage extends StatelessWidget {
  const TutorialsForChildCareNeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Tutorials for Child Care Needs',
      titleAr: 'شروحات لاحتياجات رعاية الطفل',
      headerIcon: Icons.ondemand_video_outlined,
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
