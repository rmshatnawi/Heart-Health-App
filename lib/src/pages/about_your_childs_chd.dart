// lib/src/pages/about_your_childs_chd.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

class AboutYourChildsChdPage extends StatelessWidget {
  const AboutYourChildsChdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'About Your Child’s CHD',
      titleAr: 'عن مرض القلب الخِلقي لطفلك',
      headerIcon: Icons.favorite_outline,
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
