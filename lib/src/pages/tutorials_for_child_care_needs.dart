// lib/src/pages/tutorials_for_child_care_needs.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

import 'tutorials_drain_care.dart';
import 'tutorials_wound_care.dart';
import 'tutorials_how_to_give_medications.dart';
import 'tutorials_critical_cardiac_kids.dart';
import 'tutorials_discharge_information.dart';

class TutorialsForChildCareNeedsPage extends StatelessWidget {
  const TutorialsForChildCareNeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Tutorials for Child Care Needs',
      titleAr: 'شروحات لاحتياجات رعاية الطفل',
      headerIcon: Icons.ondemand_video_outlined,
      child: (isArabic) => _TutorialsBody(isArabic: isArabic),
    );
  }
}

class _TutorialsBody extends StatelessWidget {
  const _TutorialsBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final items = <_TutorialNavItem>[
      _TutorialNavItem(
        titleEn: 'Drain Care',
        titleAr: 'العناية بالتصريف (الدرنقة)',
        descEn: 'How to empty, measure, and keep the drain area clean.',
        descAr: 'كيفية تفريغ التصريف وقياسه والحفاظ على نظافة المنطقة.',
        icon: Icons.water_drop_outlined,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const DrainCarePage()),
        ),
      ),
      _TutorialNavItem(
        titleEn: 'Wound Care',
        titleAr: 'العناية بالجرح',
        descEn: 'Cleaning instructions and signs of infection to watch for.',
        descAr: 'تعليمات التنظيف وعلامات العدوى التي يجب مراقبتها.',
        icon: Icons.healing_outlined,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const WoundCarePage()),
        ),
      ),
      _TutorialNavItem(
        titleEn: 'How to Give Medications',
        titleAr: 'كيفية إعطاء الأدوية',
        descEn: 'Safe dosing, schedules, and tips for caregivers.',
        descAr: 'الجرعات الآمنة والجداول ونصائح لمقدمي الرعاية.',
        icon: Icons.medication_outlined,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const HowToGiveMedicationsPage()),
        ),
      ),
      _TutorialNavItem(
        titleEn: 'Critical Cardiac Kids',
        titleAr: 'الأطفال ذوو الحالات القلبية الحرجة',
        descEn: 'When to call the doctor and emergency warning signs.',
        descAr: 'متى تتصل بالطبيب وعلامات الخطر الطارئة.',
        icon: Icons.monitor_heart_outlined,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CriticalCardiacKidsPage()),
        ),
      ),
      _TutorialNavItem(
        titleEn: 'Discharge Information',
        titleAr: 'معلومات الخروج من المستشفى',
        descEn: 'Discharge steps + videos: pectus discharge and head-to-check.',
        descAr: 'خطوات الخروج + فيديوهات: خروج البيكتس وفحص الرأس.',
        icon: Icons.assignment_outlined,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const DischargeInformationPage()),
        ),
      ),
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        final it = items[i];
        final title = _t(it.titleEn, it.titleAr);
        final desc = _t(it.descEn, it.descAr);

        return _TutorialCard(
          title: title,
          subtitle: desc,
          icon: it.icon,
          onTap: it.onTap,
        );
      },
    );
  }
}

class _TutorialNavItem {
  final String titleEn, titleAr;
  final String descEn, descAr;
  final IconData icon;
  final VoidCallback onTap;

  _TutorialNavItem({
    required this.titleEn,
    required this.titleAr,
    required this.descEn,
    required this.descAr,
    required this.icon,
    required this.onTap,
  });
}

class _TutorialCard extends StatelessWidget {
  const _TutorialCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  static const _tileBlue = Color(0xFF2F73FF);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 230),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE3EBFF)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _tileBlue,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    if (subtitle.trim().isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5A6C96),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right, color: Color(0xFF5A6C96)),
            ],
          ),
        ),
      ),
    );
  }
}
