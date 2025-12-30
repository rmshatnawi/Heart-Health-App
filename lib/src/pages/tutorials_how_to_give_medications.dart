// lib/src/pages/tutorials_how_to_give_medications.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

class HowToGiveMedicationsPage extends StatelessWidget {
  const HowToGiveMedicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'How to Give Medications',
      titleAr: 'كيفية إعطاء الأدوية',
      headerIcon: Icons.medication_outlined,
      child: (isArabic) {
        final tips = isArabic
            ? const [
          'استخدم سرنجة قياس للجرعات السائلة.',
          'التزم بالوقت نفسه كل يوم عند الإمكان.',
          'لا توقف الدواء دون استشارة الطبيب.',
          'احتفظ بقائمة الأدوية مع الجرعات وأوقاتها.',
        ]
            : const [
          'Use an oral syringe for liquid doses.',
          'Keep a consistent schedule when possible.',
          'Do not stop medicines without medical advice.',
          'Keep a medication list with doses and times.',
        ];

        final missed = isArabic
            ? 'إذا نسيت جرعة، اتبع تعليمات الطبيب أو النشرة. لا تضاعف الجرعة دون توجيه.'
            : 'If a dose is missed, follow your clinician’s instructions. Do not double-dose unless advised.';

        return ListView(
          children: [
            _Box(
              title: isArabic ? 'نصائح' : 'Tips',
              icon: Icons.checklist_outlined,
              child: _Bullets(bullets: tips, isArabic: isArabic),
            ),
            _Box(
              title: isArabic ? 'جرعة فائتة' : 'Missed dose',
              icon: Icons.schedule_outlined,
              child: Text(
                missed,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: const TextStyle(
                  fontSize: 12.8,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A6C96),
                  height: 1.45,
                ),
              ),
            ),
            _Box(
              title: isArabic ? 'مثال جدول (تجريبي)' : 'Example schedule ',
              icon: Icons.table_chart_outlined,
              child: _MiniTable(isArabic: isArabic),
            ),
          ],
        );
      },
    );
  }
}

class _MiniTable extends StatelessWidget {
  const _MiniTable({required this.isArabic});
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final rows = isArabic
        ? const [
      ['فوروسيميد', '08:00', 'حسب الوصفة'],
      ['أسبرين', '20:00', 'حسب الوصفة'],
    ]
        : const [
      ['Furosemide', '08:00', 'As prescribed'],
      ['Aspirin', '20:00', 'As prescribed'],
    ];

    final headers = isArabic ? const ['الدواء', 'الوقت', 'ملاحظة'] : const ['Medication', 'Time', 'Note'];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Column(
        children: [
          _Row(headers, isHeader: true),
          for (final r in rows) _Row(r),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.cells, {this.isHeader = false});
  final List<String> cells;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: isHeader ? const Color(0xFFE3EBFF) : const Color(0xFFF0F4FF)),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              cells[0],
              style: TextStyle(
                fontSize: 12.6,
                fontWeight: isHeader ? FontWeight.w900 : FontWeight.w700,
                color: isHeader ? const Color(0xFF1B2B55) : const Color(0xFF5A6C96),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              cells[1],
              style: TextStyle(
                fontSize: 12.6,
                fontWeight: isHeader ? FontWeight.w900 : FontWeight.w700,
                color: isHeader ? const Color(0xFF1B2B55) : const Color(0xFF5A6C96),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              cells[2],
              style: TextStyle(
                fontSize: 12.6,
                fontWeight: isHeader ? FontWeight.w900 : FontWeight.w700,
                color: isHeader ? const Color(0xFF1B2B55) : const Color(0xFF5A6C96),
              ),
            ),
          ),
        ],
      ),
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
