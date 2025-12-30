// lib/src/pages/gcc_development_by_age.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

class GccDevelopmentByAgePage extends StatelessWidget {
  const GccDevelopmentByAgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Development by Age',
      titleAr: 'التطور حسب العمر',
      headerIcon: Icons.stacked_line_chart_outlined,
      child: (isArabic) => _DevelopmentByAgeBody(isArabic: isArabic),
    );
  }
}

class _DevelopmentByAgeBody extends StatelessWidget {
  const _DevelopmentByAgeBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  // Static demo data (replace later with Firestore).
  List<Map<String, dynamic>> get _ranges => [
    {
      'order': 1,
      'titleEn': '0–3 months',
      'titleAr': '٠–٣ أشهر',
      'items': [
        {
          'type': 'text',
          'titleEn': 'Typical development',
          'titleAr': 'التطور الطبيعي',
          'bodyEn':
          'Lifts head briefly, follows objects with eyes, responds to sounds.',
          'bodyAr':
          'يرفع الرأس لفترة قصيرة، يتابع الأشياء بعينيه، يستجيب للأصوات.',
        },
        {
          'type': 'text',
          'titleEn': 'Safety tips',
          'titleAr': 'نصائح السلامة',
          'bodyEn': 'Always place baby on their back to sleep.',
          'bodyAr': 'ضع الطفل دائماً على ظهره عند النوم.',
        },
        {
          'type': 'link',
          'titleEn': 'Trusted reference',
          'titleAr': 'مرجع موثوق',
          'url': 'https://www.cdc.gov/ncbddd/actearly/milestones/',
        },
      ],
    },
    {
      'order': 2,
      'titleEn': '4–6 months',
      'titleAr': '٤–٦ أشهر',
      'items': [
        {
          'type': 'text',
          'titleEn': 'Typical development',
          'titleAr': 'التطور الطبيعي',
          'bodyEn':
          'Rolls over, reaches for toys, begins babbling and social smiling.',
          'bodyAr':
          'يتقلب، يمسك الألعاب، يبدأ بالمناغاة والابتسام الاجتماعي.',
        },
        {
          'type': 'text',
          'titleEn': 'Feeding notes',
          'titleAr': 'ملاحظات التغذية',
          'bodyEn':
          'Discuss timing of solids with your pediatrician; continue breast/formula as main nutrition.',
          'bodyAr':
          'ناقش موعد إدخال الطعام الصلب مع الطبيب؛ واستمر بالحليب كمصدر أساسي.',
        },
      ],
    },
    {
      'order': 3,
      'titleEn': '7–12 months',
      'titleAr': '٧–١٢ شهراً',
      'items': [
        {
          'type': 'text',
          'titleEn': 'Typical development',
          'titleAr': 'التطور الطبيعي',
          'bodyEn':
          'Sits without support, may crawl, responds to name, starts simple gestures.',
          'bodyAr':
          'يجلس دون دعم، قد يبدأ بالحبو، يستجيب لاسمه، يبدأ بإيماءات بسيطة.',
        },
        {
          'type': 'text',
          'titleEn': 'Safety tips',
          'titleAr': 'نصائح السلامة',
          'bodyEn':
          'Baby-proof sharp edges, cover outlets, and keep small objects out of reach.',
          'bodyAr':
          'قم بتأمين المنزل: غطِّ المقابس وأبعد الأشياء الصغيرة واحمِ الحواف الحادة.',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final ranges = [..._ranges]..sort((a, b) {
      final am = (a['order'] ?? 9999) as int;
      final bm = (b['order'] ?? 9999) as int;
      return am.compareTo(bm);
    });

    return ListView.separated(
      itemCount: ranges.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final r = ranges[i];
        final titleEn = (r['titleEn'] ?? '').toString();
        final titleAr = (r['titleAr'] ?? '').toString();
        final items = (r['items'] as List<dynamic>? ?? const []);

        return _AgeRangeCard(
          title: _t(titleEn, titleAr),
          items: items,
          isArabic: isArabic,
        );
      },
    );
  }
}

class _AgeRangeCard extends StatelessWidget {
  const _AgeRangeCard({
    required this.title,
    required this.items,
    required this.isArabic,
  });

  final String title;
  final List<dynamic> items;
  final bool isArabic;

  String _pick(Map<String, dynamic> b, String enKey, String arKey) {
    final en = (b[enKey] ?? '').toString();
    final ar = (b[arKey] ?? '').toString();
    return isArabic ? (ar.isEmpty ? en : ar) : (en.isEmpty ? ar : en);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 240),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1B2B55),
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: items.map((raw) {
              final b = (raw as Map).cast<String, dynamic>();
              final type = (b['type'] ?? 'text').toString();

              final t = _pick(b, 'titleEn', 'titleAr');
              final body = _pick(b, 'bodyEn', 'bodyAr');
              final url = (b['url'] ?? '').toString();

              if (type == 'link') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _SectionBox(
                    title: t.isEmpty ? (isArabic ? 'رابط' : 'Link') : t,
                    icon: Icons.link,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFF),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE3EBFF)),
                      ),
                      child: Text(
                        url.isEmpty ? (isArabic ? 'لا يوجد رابط' : 'No URL') : url,
                        textAlign: isArabic ? TextAlign.right : TextAlign.left,
                        style: TextStyle(
                          fontSize: 12.8,
                          fontWeight: FontWeight.w800,
                          color: url.isEmpty ? const Color(0xFF5A6C96) : const Color(0xFF2F73FF),
                          height: 1.35,
                          decoration: url.isEmpty ? null : TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SectionBox(
                  title: t.isEmpty ? (isArabic ? 'معلومة' : 'Info') : t,
                  icon: Icons.notes_rounded,
                  child: Text(
                    body,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(
                      fontSize: 12.8,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5A6C96),
                      height: 1.35,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SectionBox extends StatelessWidget {
  const _SectionBox({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 220),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3EBFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFF2F73FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
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
