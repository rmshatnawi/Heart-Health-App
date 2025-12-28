// lib/src/pages/track_your_child.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

class TrackYourChildPage extends StatelessWidget {
  const TrackYourChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Track Your Child',
      titleAr: 'تتبّع طفلك',
      headerIcon: Icons.monitor_heart_outlined,
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
