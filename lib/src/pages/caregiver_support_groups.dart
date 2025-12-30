// lib/src/pages/caregiver_support_groups.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/chd_scaffold.dart';

class SupportGroupsPage extends StatelessWidget {
  const SupportGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Support Groups',
      titleAr: 'مجموعات الدعم',
      headerIcon: Icons.groups_2_outlined,
      child: (isArabic) => _SupportGroupsBody(isArabic: isArabic),
    );
  }
}

class _SupportGroupsBody extends StatelessWidget {
  const _SupportGroupsBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  Future<void> _open(BuildContext context, String url) async {
    final uri = Uri.tryParse(url.trim());
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t('Invalid link', 'رابط غير صالح'))),
      );
      return;
    }
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t('Could not open link', 'تعذر فتح الرابط'))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _Box(
          title: _t('Mended Hearts', 'Mended Hearts'),
          icon: Icons.link,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'https://mendedhearts.org',
                style: const TextStyle(
                  fontSize: 12.6,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2F73FF),
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () => _open(context, 'https://mendedhearts.org'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F73FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text(
                    _t('Open Website', 'فتح الموقع'),
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
        _Box(
          title: _t('Little Heart Warrior', 'Little Heart Warrior'),
          icon: Icons.groups_2_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _t(
                  'Meeting information: community updates and scheduled sessions are shared online.',
                  'معلومات اللقاءات: يتم نشر التحديثات والجلسات المجدولة عبر الإنترنت.',
                ),
                style: const TextStyle(
                  fontSize: 12.8,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A6C96),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 12),
              _LinkButton(
                labelEn: 'Website',
                labelAr: 'الموقع',
                url: 'https://www.google.com/search?q=Little+Heart+Warrior+support+group',
                open: _open,
                isArabic: isArabic,
              ),
              const SizedBox(height: 10),
              _LinkButton(
                labelEn: 'Facebook',
                labelAr: 'فيسبوك',
                url: 'https://www.facebook.com/search/top/?q=little%20heart%20warrior',
                open: _open,
                isArabic: isArabic,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.labelEn,
    required this.labelAr,
    required this.url,
    required this.open,
    required this.isArabic,
  });

  final String labelEn;
  final String labelAr;
  final String url;
  final Future<void> Function(BuildContext, String) open;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: () => open(context, url),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F73FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(
          isArabic ? labelAr : labelEn,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({required this.title, required this.icon, required this.child});
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
          BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 4)),
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
