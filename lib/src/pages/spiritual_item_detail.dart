// lib/src/pages/spiritual_item_detail.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/chd_scaffold.dart';

class SpiritualItemDetailPage extends StatelessWidget {
  const SpiritualItemDetailPage({
    super.key,
    required this.itemId,
    required this.titleEn,
    required this.titleAr,
    required this.type,
    required this.url,
    required this.bodyEn,
    required this.bodyAr,
    required this.descEn,
    required this.descAr,
  });

  final String itemId;
  final String titleEn;
  final String titleAr;
  final String type; // text | video | link
  final String url;
  final String bodyEn;
  final String bodyAr;
  final String descEn;
  final String descAr;

  Future<void> _openUrl(BuildContext context, bool isArabic) async {
    final raw = url.trim();
    if (raw.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isArabic ? 'لا يوجد رابط' : 'No link')),
      );
      return;
    }

    Uri? uri = Uri.tryParse(raw);
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isArabic ? 'رابط غير صالح' : 'Invalid link')),
      );
      return;
    }

    // Support mailto: plus http/https
    final scheme = uri.scheme.toLowerCase();
    final okScheme = scheme == 'http' || scheme == 'https' || scheme == 'mailto';
    if (!okScheme) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isArabic ? 'رابط غير صالح' : 'Invalid link')),
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
    final icon = switch (type) {
      'video' => Icons.play_circle_outline,
      'link' => Icons.link,
      _ => Icons.article_outlined,
    };

    return ChdScaffold(
      titleEn: titleEn.isEmpty ? 'Spiritual Item' : titleEn,
      titleAr: titleAr.isEmpty ? 'محتوى روحي' : titleAr,
      headerIcon: icon,
      child: (isArabic) {
        final desc = isArabic ? (descAr.isEmpty ? descEn : descAr) : (descEn.isEmpty ? descAr : descEn);
        final body = isArabic ? (bodyAr.isEmpty ? bodyEn : bodyAr) : (bodyEn.isEmpty ? bodyAr : bodyEn);

        return ListView(
          children: [
            _Box(
              title: isArabic ? 'وصف' : 'Description',
              icon: Icons.info_outline,
              child: Text(
                desc.trim().isEmpty ? (isArabic ? 'لا يوجد وصف.' : 'No description.') : desc,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: const TextStyle(
                  fontSize: 12.8,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A6C96),
                  height: 1.4,
                ),
              ),
            ),
            if (type == 'text')
              _Box(
                title: isArabic ? 'النص' : 'Text',
                icon: Icons.article_outlined,
                child: Text(
                  body.trim().isEmpty ? (isArabic ? 'لا يوجد نص.' : 'No text.') : body,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12.8,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A6C96),
                    height: 1.5,
                  ),
                ),
              )
            else
              _Box(
                title: isArabic ? 'الرابط' : 'Link',
                icon: Icons.link,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      url.trim().isEmpty ? (isArabic ? 'لا يوجد رابط.' : 'No link.') : url,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: TextStyle(
                        fontSize: 12.6,
                        fontWeight: FontWeight.w800,
                        color: url.trim().isEmpty ? const Color(0xFF5A6C96) : const Color(0xFF2F73FF),
                        decoration: url.trim().isEmpty ? null : TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: url.trim().isEmpty ? null : () => _openUrl(context, isArabic),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F73FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        child: Text(
                          isArabic ? 'فتح' : 'Open',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({
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
