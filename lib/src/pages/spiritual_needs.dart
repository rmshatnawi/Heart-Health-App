// lib/src/pages/spiritual_needs.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/chd_scaffold.dart';
import 'spiritual_category.dart';

class SpiritualNeedsPage extends StatelessWidget {
  const SpiritualNeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Spiritual Needs',
      titleAr: 'الاحتياجات الروحية',
      headerIcon: Icons.self_improvement_outlined,
      child: (isArabic) => _SpiritualNeedsBody(isArabic: isArabic),
    );
  }
}

class _SpiritualNeedsBody extends StatelessWidget {
  const _SpiritualNeedsBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection('content_pages').doc('spiritual_needs');

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ref.snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          final msg = snap.error.toString();
          return Center(
            child: Text(
              isArabic ? 'خطأ في تحميل البيانات:\n$msg' : 'Failed to load data:\n$msg',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF9A2A2A),
              ),
            ),
          );
        }

        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snap.hasData || !snap.data!.exists) {
          // SRS sections required even if DB is empty.
          return _StaticTopSections(isArabic: isArabic);
        }

        final data = snap.data!.data() ?? {};
        final categories = (data['categories'] as List<dynamic>? ?? const []);

        return ListView(
          children: [
            _StaticTopSections(isArabic: isArabic),
            const SizedBox(height: 10),
            if (categories.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  _t('No categories yet.', 'لا توجد أقسام بعد.'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5A6C96),
                  ),
                ),
              )
            else
              ...List.generate(categories.length, (i) {
                final c = (categories[i] as Map).cast<String, dynamic>();

                final id = (c['id'] ?? 'c_$i').toString();
                final titleEn = (c['titleEn'] ?? '').toString();
                final titleAr = (c['titleAr'] ?? '').toString();
                final subtitleEn = (c['subtitleEn'] ?? '').toString();
                final subtitleAr = (c['subtitleAr'] ?? '').toString();

                final title = isArabic ? (titleAr.isEmpty ? titleEn : titleAr) : (titleEn.isEmpty ? titleAr : titleEn);
                final subtitle =
                isArabic ? (subtitleAr.isEmpty ? subtitleEn : subtitleAr) : (subtitleEn.isEmpty ? subtitleAr : subtitleEn);

                return _CategoryCard(
                  title: title.isEmpty ? _t('Category', 'قسم') : title,
                  subtitle: subtitle,
                  icon: Icons.auto_stories_outlined,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SpiritualCategoryPage(
                          categoryId: id,
                          titleEn: titleEn,
                          titleAr: titleAr,
                        ),
                      ),
                    );
                  },
                );
              }),
          ],
        );
      },
    );
  }
}

class _StaticTopSections extends StatelessWidget {
  const _StaticTopSections({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final sections = <_TopSection>[
      _TopSection(
        id: 'devotionals',
        titleEn: 'Devotionals',
        titleAr: 'تأملات وعبادات',
        subtitleEn: 'Written devotionals and short videos for strength and hope.',
        subtitleAr: 'تأملات مكتوبة وفيديوهات قصيرة للقوة والرجاء.',
        icon: Icons.menu_book_outlined,
      ),
      _TopSection(
        id: 'resources',
        titleEn: 'Resources',
        titleAr: 'موارد',
        subtitleEn: 'Outside readings, chaplain websites, and contact email.',
        subtitleAr: 'قراءات خارجية، مواقع المرشد الروحي، وبريد للتواصل.',
        icon: Icons.volunteer_activism_outlined,
      ),
    ];

    return Column(
      children: sections
          .map(
            (s) => _CategoryCard(
          title: _t(s.titleEn, s.titleAr),
          subtitle: _t(s.subtitleEn, s.subtitleAr),
          icon: s.icon,
          onTap: () {
            // These are required SRS levels and map to category docs in Firestore.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SpiritualCategoryPage(
                  categoryId: s.id,
                  titleEn: s.titleEn,
                  titleAr: s.titleAr,
                ),
              ),
            );
          },
        ),
      )
          .toList(),
    );
  }
}

class _TopSection {
  final String id;
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String subtitleAr;
  final IconData icon;

  _TopSection({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
    required this.icon,
  });
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
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
