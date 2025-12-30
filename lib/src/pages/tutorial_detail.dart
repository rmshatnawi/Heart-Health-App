// lib/src/pages/tutorial_detail.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/chd_scaffold.dart';

class TutorialDetailPage extends StatelessWidget {
  const TutorialDetailPage({
    super.key,
    required this.tutorialId,
    required this.titleEn,
    required this.titleAr,
    required this.type,
    required this.url,
    required this.descEn,
    required this.descAr,
  });

  final String tutorialId;
  final String titleEn;
  final String titleAr;
  final String type; // video | guide | link
  final String url;
  final String descEn;
  final String descAr;

  Future<void> _openUrl(BuildContext context, bool isArabic) async {
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
    final icon = switch (type) {
      'guide' => Icons.menu_book_outlined,
      'link' => Icons.link,
      _ => Icons.play_circle_outline,
    };

    return ChdScaffold(
      titleEn: titleEn.isEmpty ? 'Tutorial' : titleEn,
      titleAr: titleAr.isEmpty ? 'شرح' : titleAr,
      headerIcon: icon,
      child: (isArabic) {
        final desc = isArabic ? (descAr.isEmpty ? descEn : descAr) : (descEn.isEmpty ? descAr : descEn);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Box(
              title: isArabic ? 'الوصف' : 'Description',
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
            _Box(
              title: isArabic ? 'المحتوى' : 'Content',
              icon: icon,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    url.trim().isEmpty ? (isArabic ? 'لا يوجد رابط.' : 'No URL.') : url,
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
