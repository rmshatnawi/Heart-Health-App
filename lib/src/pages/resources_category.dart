import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/chd_scaffold.dart';

class ResourcesCategoryPage extends StatelessWidget {
  const ResourcesCategoryPage({
    super.key,
    required this.categoryId,
    required this.titleEn,
    required this.titleAr,
    required this.icon,
  });

  final String categoryId;
  final String titleEn;
  final String titleAr;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: titleEn,
      titleAr: titleAr,
      headerIcon: icon,
      child: (isArabic) => _CategoryBody(
        isArabic: isArabic,
        categoryId: categoryId,
      ),
    );
  }
}

class _CategoryBody extends StatelessWidget {
  const _CategoryBody({
    required this.isArabic,
    required this.categoryId,
  });

  final bool isArabic;
  final String categoryId;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance
        .collection('content_pages')
        .doc('resources')
        .collection('categories')
        .doc(categoryId);

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ref.snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || !snap.data!.exists) {
          return Center(
            child: Text(
              _t('No resources yet.', 'لا توجد موارد بعد.'),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        final items =
        (snap.data!.data()!['items'] as List<dynamic>? ?? []).cast<Map>();

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, i) {
            final it = items[i];
            final type = it['type'];

            final title = _t(it['titleEn'], it['titleAr']);
            final desc = _t(it['descEn'], it['descAr']);

            return _ResourceBox(
              title: title,
              desc: desc,
              onTap: () async {
                if (type == 'link') {
                  final uri = Uri.parse(it['url']);
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
                if (type == 'phone') {
                  final uri = Uri.parse('tel:${it['phone']}');
                  await launchUrl(uri);
                }
              },
            );
          },
        );
      },
    );
  }
}

class _ResourceBox extends StatelessWidget {
  const _ResourceBox({
    required this.title,
    required this.desc,
    required this.onTap,
  });

  final String title;
  final String desc;
  final VoidCallback onTap;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1B2B55),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              desc,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
