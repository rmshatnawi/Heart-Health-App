// lib/src/components/content_blocks.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentBlocks extends StatelessWidget {
  const ContentBlocks({
    super.key,
    required this.blocks,
    required this.isArabic,
  });

  final List<dynamic> blocks;
  final bool isArabic;

  String _pick(Map<String, dynamic> b, String enKey, String arKey) {
    final en = (b[enKey] ?? '').toString();
    final ar = (b[arKey] ?? '').toString();
    return isArabic ? (ar.isEmpty ? en : ar) : (en.isEmpty ? ar : en);
  }

  Future<void> _openUrl(BuildContext context, String url) async {
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
    if (blocks.isEmpty) {
      return Center(
        child: Text(
          isArabic ? 'لا يوجد محتوى بعد.' : 'No content yet.',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5A6C96),
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: blocks.length,
      itemBuilder: (context, i) {
        final b = (blocks[i] as Map).cast<String, dynamic>();
        final type = (b['type'] ?? 'text').toString();

        final title = _pick(b, 'titleEn', 'titleAr');
        final body = _pick(b, 'bodyEn', 'bodyAr');
        final url = (b['url'] ?? '').toString().trim();

        if (type == 'link') {
          return _BlockBox(
            title: title.isEmpty ? (isArabic ? 'رابط' : 'Link') : title,
            icon: Icons.link,
            child: InkWell(
              onTap: url.isEmpty ? null : () => _openUrl(context, url),
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

        // default: text
        return _BlockBox(
          title: title.isEmpty ? (isArabic ? 'معلومة' : 'Info') : title,
          icon: Icons.info_outline,
          child: Text(
            body,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: const TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5A6C96),
              height: 1.4,
            ),
          ),
        );
      },
    );
  }
}

class _BlockBox extends StatelessWidget {
  const _BlockBox({
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
