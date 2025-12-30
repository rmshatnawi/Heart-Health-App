// lib/src/pages/gcc_newborn_care_websites.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/chd_scaffold.dart';

class GccNewbornCareWebsitesPage extends StatelessWidget {
  const GccNewbornCareWebsitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Newborn Care Websites',
      titleAr: 'مواقع رعاية حديثي الولادة',
      headerIcon: Icons.public_outlined,
      child: (isArabic) => _StaticBlocksPage(
        isArabic: isArabic,
        blocks: const [
          {
            'type': 'section',
            'titleEn': 'Trusted websites',
            'titleAr': 'مواقع موثوقة',
            'items': [
              {
                'type': 'link',
                'titleEn': 'CDC — Child Development',
                'titleAr': 'CDC — نمو الطفل',
                'url': 'https://www.cdc.gov/ncbddd/childdevelopment/',
              },
              {
                'type': 'link',
                'titleEn': 'WHO — Infant and Young Child Feeding',
                'titleAr': 'WHO — تغذية الرضع وصغار الأطفال',
                'url': 'https://www.who.int/health-topics/infant-and-young-child-feeding',
              },
              {
                'type': 'link',
                'titleEn': 'KidsHealth — Newborn Care',
                'titleAr': 'KidsHealth — رعاية حديثي الولادة',
                'url': 'https://kidshealth.org/',
              },
            ],
          },
          {
            'type': 'note',
            'titleEn': 'Reminder',
            'titleAr': 'تنبيه',
            'bodyEn':
            'Websites are helpful, but your child’s doctor is the best source for advice tailored to CHD.',
            'bodyAr':
            'المواقع مفيدة، لكن طبيب طفلك هو أفضل مصدر لنصائح تناسب حالة القلب الخلقية.',
          },
        ],
      ),
    );
  }
}

class _StaticBlocksPage extends StatelessWidget {
  const _StaticBlocksPage({required this.isArabic, required this.blocks});
  final bool isArabic;
  final List<Map<String, dynamic>> blocks;

  String _pick(Map<String, dynamic> b, String enKey, String arKey) {
    final en = (b[enKey] ?? '').toString();
    final ar = (b[arKey] ?? '').toString();
    return isArabic ? (ar.isEmpty ? en : ar) : (en.isEmpty ? ar : en);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: blocks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final b = blocks[i];
        final type = (b['type'] ?? '').toString();

        if (type == 'section') {
          final title = _pick(b, 'titleEn', 'titleAr');
          final items = (b['items'] as List<dynamic>? ?? const []);
          return _Card(
            title: title,
            icon: Icons.collections_bookmark_outlined,
            child: Column(
              children: items.map((raw) {
                final it = (raw as Map).cast<String, dynamic>();
                final t = _pick(it, 'titleEn', 'titleAr');
                final url = (it['url'] ?? '').toString();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _LinkRow(title: t, url: url, isArabic: isArabic),
                );
              }).toList(),
            ),
          );
        }

        final title = _pick(b, 'titleEn', 'titleAr');
        final body = _pick(b, 'bodyEn', 'bodyAr');
        return _Card(
          title: title,
          icon: Icons.info_outline,
          child: Text(
            body,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: const TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5A6C96),
              height: 1.45,
            ),
          ),
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.icon, required this.child});
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 240),
        borderRadius: BorderRadius.circular(18),
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
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.title, required this.url, required this.isArabic});
  final String title;
  final String url;
  final bool isArabic;

  Future<void> _open(BuildContext context) async {
    final uri = Uri.tryParse(url.trim());
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
    final safeTitle = title.isEmpty ? (isArabic ? 'رابط' : 'Link') : title;

    return Material(
      color: const Color(0xFFF8FAFF),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: url.trim().isEmpty ? null : () => _open(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE3EBFF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                safeTitle,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: const TextStyle(
                  fontSize: 12.8,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1B2B55),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                url.trim().isEmpty ? (isArabic ? 'لا يوجد رابط' : 'No URL') : url.trim(),
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  fontSize: 12.6,
                  fontWeight: FontWeight.w800,
                  color: url.trim().isEmpty ? const Color(0xFF5A6C96) : const Color(0xFF2F73FF),
                  decoration: url.trim().isEmpty ? null : TextDecoration.underline,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
