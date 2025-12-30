import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';
import 'resources_category.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Resources',
      titleAr: 'الموارد',
      headerIcon: Icons.support_agent_outlined,
      child: (isArabic) => _ResourcesBody(isArabic: isArabic),
    );
  }
}

class _ResourcesBody extends StatelessWidget {
  const _ResourcesBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final ref =
    FirebaseFirestore.instance.collection('content_pages').doc('resources');

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ref.snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snap.data?.data() ?? {};
        final raw = (data['categories'] as List<dynamic>?);

        final categories = (raw == null || raw.isEmpty)
            ? _fallbackCategories()
            : raw.map((e) => (e as Map).cast<String, dynamic>()).toList();

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, i) {
            final c = categories[i];

            final id = c['id'] as String;
            final title = _t(c['titleEn'], c['titleAr']);
            final subtitle = _t(c['subtitleEn'], c['subtitleAr']);

            return _SectionCard(
              icon: _iconFor(id),
              title: title,
              subtitle: subtitle,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ResourcesCategoryPage(
                      categoryId: id,
                      titleEn: c['titleEn'],
                      titleAr: c['titleAr'],
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
      case 'support_groups':
        return Icons.groups_outlined;
      case 'hotlines':
        return Icons.phone_in_talk_outlined;
      case 'therapy':
        return Icons.psychology_alt_outlined;
      case 'education':
        return Icons.menu_book_outlined;
      default:
        return Icons.support_agent_outlined;
    }
  }

  List<Map<String, dynamic>> _fallbackCategories() => const [
    {
      'id': 'support_groups',
      'titleEn': 'Support Groups',
      'titleAr': 'مجموعات الدعم',
      'subtitleEn': 'Connect with other caregivers and families.',
      'subtitleAr': 'التواصل مع عائلات ومقدمي رعاية آخرين.',
    },
    {
      'id': 'hotlines',
      'titleEn': 'Hotlines',
      'titleAr': 'خطوط المساعدة',
      'subtitleEn': 'Immediate emotional support when needed.',
      'subtitleAr': 'دعم فوري عند الحاجة.',
    },
    {
      'id': 'therapy',
      'titleEn': 'Therapy & Counseling',
      'titleAr': 'العلاج والإرشاد',
      'subtitleEn': 'Professional psychological support services.',
      'subtitleAr': 'خدمات دعم نفسي متخصصة.',
    },
    {
      'id': 'education',
      'titleEn': 'Education & Guidance',
      'titleAr': 'التثقيف والإرشاد',
      'subtitleEn': 'Guidance for long-term caregiving.',
      'subtitleAr': 'إرشادات للرعاية طويلة الأمد.',
    },
  ];
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  static const _blue = Color(0xFF2F73FF);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 235),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE3EBFF)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _blue,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B2B55),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5A6C96),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF5A6C96)),
          ],
        ),
      ),
    );
  }
}
