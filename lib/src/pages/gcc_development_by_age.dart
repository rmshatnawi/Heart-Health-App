import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance
        .collection('content_pages')
        .doc('general_childcare_development_by_age');

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
          return Center(
            child: Text(
              _t('No content yet.', 'لا يوجد محتوى بعد.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        final data = snap.data!.data();
        if (data == null) {
          return Center(
            child: Text(
              _t('Data is empty.', 'البيانات فارغة.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        final ranges = (data['ageRanges'] as List<dynamic>? ?? const []).cast<dynamic>();

        if (ranges.isEmpty) {
          return Center(
            child: Text(
              _t('Age ranges are empty.', 'فئات العمر فارغة.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        ranges.sort((a, b) {
          final am = (a as Map)['order'] ?? 9999;
          final bm = (b as Map)['order'] ?? 9999;
          return (am as int).compareTo(bm as int);
        });

        return ListView.separated(
          itemCount: ranges.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final r = (ranges[i] as Map).cast<String, dynamic>();
            final titleEn = (r['titleEn'] ?? '').toString();
            final titleAr = (r['titleAr'] ?? '').toString();
            final items = (r['items'] as List<dynamic>? ?? const []).cast<dynamic>();

            return _AgeRangeCard(
              title: _t(titleEn, titleAr),
              items: items,
              isArabic: isArabic,
            );
          },
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

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isArabic ? 'رابط غير صالح' : 'Invalid URL')),
      );
      return;
    }

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isArabic ? 'تعذر فتح الرابط' : 'Could not open link')),
      );
    }
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
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1B2B55),
            ),
          ),
          const SizedBox(height: 12),
          if (items.isEmpty)
            Text(
              isArabic ? 'لا يوجد محتوى داخل هذا العمر بعد.' : 'No items for this age range yet.',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            )
          else
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
                      child: InkWell(
                        onTap: url.trim().isEmpty ? null : () => _openUrl(context, url.trim()),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE3EBFF)),
                          ),
                          child: Text(
                            url.trim().isEmpty
                                ? (isArabic ? 'لا يوجد رابط' : 'No URL')
                                : url.trim(),
                            textAlign: isArabic ? TextAlign.right : TextAlign.left,
                            style: TextStyle(
                              fontSize: 12.8,
                              fontWeight: FontWeight.w800,
                              color: url.trim().isEmpty
                                  ? const Color(0xFF5A6C96)
                                  : const Color(0xFF2F73FF),
                              height: 1.35,
                              decoration: url.trim().isEmpty ? null : TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // default: text
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