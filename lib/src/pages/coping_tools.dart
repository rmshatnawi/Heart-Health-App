// lib/src/pages/coping_tools.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';
import 'coping_tools_category.dart';

class CopingToolsPage extends StatelessWidget {
  const CopingToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Coping Tools',
      titleAr: 'أدوات للتكيف',
      headerIcon: Icons.psychology_alt_outlined,
      child: (isArabic) => _CopingToolsBody(isArabic: isArabic),
    );
  }
}

class _CopingToolsBody extends StatelessWidget {
  const _CopingToolsBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance
        .collection('content_pages')
        .doc('coping_tools');

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ref.snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text(
              _t('Failed to load content.', 'فشل تحميل المحتوى.'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF9A2A2A),
              ),
            ),
          );
        }

        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If admin hasn't added anything yet, show safe fallback categories.
        final data = snap.data?.data() ?? {};
        final raw = (data['categories'] as List<dynamic>?);

        final categories = (raw == null || raw.isEmpty)
            ? _fallbackCategories()
            : raw.map((e) => (e as Map).cast<String, dynamic>()).toList();

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, i) {
            final c = categories[i];

            final id = (c['id'] ?? 'cat_$i').toString();
            final titleEn = (c['titleEn'] ?? '').toString();
            final titleAr = (c['titleAr'] ?? '').toString();
            final subtitleEn = (c['subtitleEn'] ?? '').toString();
            final subtitleAr = (c['subtitleAr'] ?? '').toString();

            final title = isArabic ? (titleAr.isEmpty ? titleEn : titleAr) : (titleEn.isEmpty ? titleAr : titleEn);
            final subtitle =
            isArabic ? (subtitleAr.isEmpty ? subtitleEn : subtitleAr) : (subtitleEn.isEmpty ? subtitleAr : subtitleEn);

            return _SectionCard(
              title: title.isEmpty ? _t('Category', 'تصنيف') : title,
              subtitle: subtitle,
              icon: _iconFor(id),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CopingToolsCategoryPage(
                      categoryId: id,
                      titleEn: titleEn,
                      titleAr: titleAr,
                      icon: _iconFor(id),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  IconData _iconFor(String id) {
    switch (id) {
      case 'anxiety':
        return Icons.air_outlined; // breathing
      case 'stress':
        return Icons.favorite_border; // self-care
      case 'hopelessness':
        return Icons.wb_sunny_outlined; // hope
      case 'sleep':
        return Icons.bedtime_outlined;
      case 'children':
        return Icons.child_care_outlined;
      case 'therapy':
        return Icons.support_agent_outlined;
      default:
        return Icons.psychology_alt_outlined;
    }
  }

  List<Map<String, dynamic>> _fallbackCategories() => const [
    {
      'id': 'anxiety',
      'titleEn': 'Anxiety & Panic',
      'titleAr': 'القلق ونوبات الهلع',
      'subtitleEn': 'Breathing, grounding, and quick calm routines.',
      'subtitleAr': 'تمارين تنفس وتهدئة سريعة.',
    },
    {
      'id': 'stress',
      'titleEn': 'Stress & Burnout',
      'titleAr': 'التوتر والإرهاق',
      'subtitleEn': 'Caregiver self-care, breaks, and realistic planning.',
      'subtitleAr': 'عناية بالنفس وتنظيم واقعي.',
    },
    {
      'id': 'hopelessness',
      'titleEn': 'Sadness & Hopelessness',
      'titleAr': 'الحزن وفقدان الأمل',
      'subtitleEn': 'Cognitive reframing and social support tools.',
      'subtitleAr': 'إعادة صياغة الأفكار ودعم اجتماعي.',
    },
    {
      'id': 'sleep',
      'titleEn': 'Sleep & Fatigue',
      'titleAr': 'النوم والإجهاد',
      'subtitleEn': 'Simple routines to improve sleep quality.',
      'subtitleAr': 'روتين بسيط لتحسين جودة النوم.',
    },
    {
      'id': 'children',
      'titleEn': 'For Children with CHD',
      'titleAr': 'للأطفال المصابين بمرض القلب',
      'subtitleEn': 'Comfort, preparation, and emotional reassurance.',
      'subtitleAr': 'الطمأنة والتحضير والدعم العاطفي.',
    },
    {
      'id': 'therapy',
      'titleEn': 'Professional Help & Therapy',
      'titleAr': 'المساعدة المهنية والعلاج',
      'subtitleEn': 'When to seek help and how to find support.',
      'subtitleAr': 'متى نطلب المساعدة وكيف نجد الدعم.',
    },
  ];
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
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
            color: Colors.white.withValues(alpha: 235),
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
                        maxLines: 3,
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
