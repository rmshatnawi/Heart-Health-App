// lib/src/pages/spiritual_category.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/chd_scaffold.dart';
import 'spiritual_item_detail.dart';

class SpiritualCategoryPage extends StatelessWidget {
  const SpiritualCategoryPage({
    super.key,
    required this.categoryId,
    required this.titleEn,
    required this.titleAr,
  });

  final String categoryId;
  final String titleEn;
  final String titleAr;

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: titleEn.isEmpty ? 'Spiritual Category' : titleEn,
      titleAr: titleAr.isEmpty ? 'قسم روحي' : titleAr,
      headerIcon: Icons.auto_stories_outlined,
      child: (isArabic) => _CategoryBody(isArabic: isArabic, categoryId: categoryId),
    );
  }
}

class _CategoryBody extends StatelessWidget {
  const _CategoryBody({required this.isArabic, required this.categoryId});
  final bool isArabic;
  final String categoryId;

  String _t(String en, String ar) => isArabic ? ar : en;

  String _fallbackTitle() {
    switch (categoryId) {
      case 'devotionals':
        return _t('Devotionals', 'تأملات وعبادات');
      case 'resources':
        return _t('Resources', 'موارد');
      default:
        return _t('Category', 'قسم');
    }
  }

  List<Map<String, dynamic>> _staticItems() {
    // Used when Firestore doc doesn't exist yet.
    if (categoryId == 'devotionals') {
      return [
        {
          'id': 'dev_hope',
          'type': 'text',
          'titleEn': 'Hope in Hard Days',
          'titleAr': 'الرجاء في الأيام الصعبة',
          'descEn': 'A short reflection for parents and caregivers.',
          'descAr': 'تأمل قصير للوالدين ومقدّمي الرعاية.',
          'bodyEn':
          'When the days feel heavy, focus on the next small step. Breathe slowly, ask for support, and remember: progress can be quiet and still real.',
          'bodyAr':
          'عندما تشعر بثقل الأيام، ركّز على الخطوة الصغيرة التالية. تنفّس ببطء، واطلب الدعم، وتذكّر: التقدّم قد يكون هادئاً لكنه حقيقي.',
          'url': '',
        },
        {
          'id': 'dev_patience',
          'type': 'text',
          'titleEn': 'Finding Patience',
          'titleAr': 'إيجاد الصبر',
          'descEn': 'Encouragement for waiting rooms and long journeys.',
          'descAr': 'تشجيع لوقت الانتظار والرحلات الطويلة.',
          'bodyEn':
          'Patience is not pretending everything is fine. It is choosing calm actions while your heart is loud. One gentle decision at a time.',
          'bodyAr':
          'الصبر ليس تظاهرًا بأن كل شيء بخير. الصبر هو اختيار أفعال هادئة بينما القلب مضطرب. قرار لطيف في كل مرة.',
          'url': '',
        },
        {
          'id': 'dev_video_search',
          'type': 'video',
          'titleEn': 'Short devotional videos',
          'titleAr': 'فيديوهات تأمل قصيرة',
          'descEn': 'Open a curated search of short devotionals.',
          'descAr': 'فتح بحث مُنسّق لفيديوهات تأمل قصيرة.',
          'url': 'https://www.youtube.com/results?search_query=short+devotional+for+caregivers+hope+strength',
          'bodyEn': '',
          'bodyAr': '',
        },
      ];
    }

    if (categoryId == 'resources') {
      return [
        {
          'id': 'res_reading',
          'type': 'link',
          'titleEn': 'Outside readings (search)',
          'titleAr': 'قراءات خارجية (بحث)',
          'descEn': 'Open a reading list search for caregiver spiritual support.',
          'descAr': 'فتح بحث لقراءات داعمة روحياً لمقدمي الرعاية.',
          'url': 'https://www.google.com/search?q=spiritual+support+for+parents+of+sick+child+chaplain+resources',
          'bodyEn': '',
          'bodyAr': '',
        },
        {
          'id': 'res_chaplain_sites',
          'type': 'link',
          'titleEn': 'Chaplain websites (search)',
          'titleAr': 'مواقع المرشد الروحي (بحث)',
          'descEn': 'Open chaplain support resources.',
          'descAr': 'فتح موارد دعم المرشد الروحي.',
          'url': 'https://www.google.com/search?q=hospital+chaplain+support+resources+family+caregiver',
          'bodyEn': '',
          'bodyAr': '',
        },
        {
          'id': 'res_email',
          'type': 'link',
          'titleEn': 'Contact by Email',
          'titleAr': 'التواصل عبر البريد',
          'descEn': 'Send an email to a support contact.',
          'descAr': 'إرسال بريد إلى جهة دعم.',
          'url': 'mailto:spiritual.support@hospital.example',
          'bodyEn': '',
          'bodyAr': '',
        },
      ];
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance
        .collection('content_pages')
        .doc('spiritual_needs')
        .collection('categories')
        .doc(categoryId);

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ref.snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text(
              _t('Failed to load category.', 'فشل تحميل القسم.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF9A2A2A),
              ),
            ),
          );
        }

        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        List<dynamic> itemsDyn = const [];
        if (!snap.hasData || !snap.data!.exists) {
          itemsDyn = _staticItems();
        } else {
          final data = snap.data!.data() ?? {};
          itemsDyn = (data['items'] as List<dynamic>? ?? const []);
          if (itemsDyn.isEmpty) {
            itemsDyn = _staticItems();
          }
        }

        if (itemsDyn.isEmpty) {
          return Center(
            child: Text(
              _t('No items yet.', 'لا توجد عناصر بعد.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: itemsDyn.length,
          itemBuilder: (context, i) {
            final it = (itemsDyn[i] as Map).cast<String, dynamic>();

            final id = (it['id'] ?? 'i_$i').toString();
            final type = (it['type'] ?? 'text').toString(); // text | video | link
            final titleEn = (it['titleEn'] ?? '').toString();
            final titleAr = (it['titleAr'] ?? '').toString();
            final descEn = (it['descEn'] ?? '').toString();
            final descAr = (it['descAr'] ?? '').toString();
            final url = (it['url'] ?? '').toString();
            final bodyEn = (it['bodyEn'] ?? '').toString();
            final bodyAr = (it['bodyAr'] ?? '').toString();

            final title = isArabic ? (titleAr.isEmpty ? titleEn : titleAr) : (titleEn.isEmpty ? titleAr : titleEn);
            final desc = isArabic ? (descAr.isEmpty ? descEn : descAr) : (descEn.isEmpty ? descAr : descEn);

            final icon = switch (type) {
              'video' => Icons.play_circle_outline,
              'link' => Icons.link,
              _ => Icons.article_outlined,
            };

            return _ItemCard(
              title: title.isEmpty ? _fallbackTitle() : title,
              subtitle: desc,
              icon: icon,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SpiritualItemDetailPage(
                      itemId: id,
                      titleEn: titleEn,
                      titleAr: titleAr,
                      type: type,
                      url: url,
                      bodyEn: bodyEn,
                      bodyAr: bodyAr,
                      descEn: descEn,
                      descAr: descAr,
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
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
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
