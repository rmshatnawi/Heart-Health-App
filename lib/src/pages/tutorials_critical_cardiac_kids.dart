// lib/src/pages/tutorials_critical_cardiac_kids.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

class CriticalCardiacKidsPage extends StatelessWidget {
  const CriticalCardiacKidsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Critical Cardiac Kids',
      titleAr: 'الأطفال ذوو الحالات القلبية الحرجة',
      headerIcon: Icons.monitor_heart_outlined,
      child: (isArabic) {
        final urgent = isArabic
            ? const [
          'صعوبة تنفس أو ازرقاق الشفاه.',
          'خمول شديد أو إغماء.',
          'تعرّق شديد مع الرضاعة أو صعوبة بالرضاعة.',
          'قيء متكرر أو عدم تحمل السوائل.',
        ]
            : const [
          'Trouble breathing or blue lips.',
          'Extreme sleepiness or fainting.',
          'Sweating with feeds or poor feeding.',
          'Repeated vomiting or unable to keep fluids down.',
        ];

        final call = isArabic
            ? const [
          'حرارة عالية مستمرة.',
          'تورم في القدمين أو البطن.',
          'انخفاض واضح في عدد الحفاضات المبللة.',
        ]
            : const [
          'Persistent high fever.',
          'Swelling in feet or belly.',
          'Noticeably fewer wet diapers.',
        ];

        final note = isArabic
            ? 'اتبع تعليمات فريق القلب لطفلك دائماً.'
            : 'Always follow your child’s cardiology team instructions.';

        return ListView(
          children: [
            _Box(
              title: isArabic ? 'اتصل بالإسعاف فوراً' : 'Call emergency now',
              icon: Icons.emergency_outlined,
              child: _Bullets(bullets: urgent, isArabic: isArabic),
            ),
            _Box(
              title: isArabic ? 'اتصل بالطبيب اليوم' : 'Call the doctor today',
              icon: Icons.phone_in_talk_outlined,
              child: _Bullets(bullets: call, isArabic: isArabic),
            ),
            _Box(
              title: isArabic ? 'ملاحظة' : 'Note',
              icon: Icons.info_outline,
              child: Text(
                note,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: const TextStyle(
                  fontSize: 12.8,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A6C96),
                  height: 1.45,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({required this.title, required this.icon, required this.child});
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF2F73FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1B2B55),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _Bullets extends StatelessWidget {
  const _Bullets({required this.bullets, required this.isArabic});
  final List<String> bullets;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bullets
          .map(
            (b) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '•  ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5A6C96),
                ),
              ),
              Expanded(
                child: Text(
                  b,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12.8,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A6C96),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}
