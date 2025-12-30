// lib/src/pages/tutorials_wound_care.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/chd_scaffold.dart';

class WoundCarePage extends StatelessWidget {
  const WoundCarePage({super.key});

  Future<void> _openUrl(BuildContext context, bool isArabic, String url) async {
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
    return ChdScaffold(
      titleEn: 'Wound Care',
      titleAr: 'العناية بالجرح',
      headerIcon: Icons.healing_outlined,
      child: (isArabic) {
        final clean = isArabic
            ? const [
          'اغسل يديك قبل وبعد العناية بالجرح.',
          'حافظ على الجرح جافاً ونظيفاً.',
          'غيّر الضماد حسب تعليمات الطبيب.',
          'تجنب وضع كريمات أو بودرة دون وصفة طبية.',
        ]
            : const [
          'Wash hands before and after wound care.',
          'Keep the wound clean and dry.',
          'Change dressing as instructed.',
          'Avoid creams/powders unless prescribed.',
        ];

        final signs = isArabic
            ? const [
          'احمرار متزايد أو تورم.',
          'إفرازات صفراء/خضراء أو رائحة.',
          'ارتفاع الحرارة أو قشعريرة.',
          'ألم يزداد بدل أن يتحسن.',
        ]
            : const [
          'Increasing redness or swelling.',
          'Yellow/green drainage or odor.',
          'Fever or chills.',
          'Pain getting worse instead of better.',
        ];

        final refUrl = 'https://www.cdc.gov/hai/patientsafety/patient_woundcare.html';

        return ListView(
          children: [
            _Box(
              title: isArabic ? 'تنظيف الجرح' : 'Cleaning',
              icon: Icons.cleaning_services_outlined,
              child: _Bullets(bullets: clean, isArabic: isArabic),
            ),
            _Box(
              title: isArabic ? 'علامات العدوى' : 'Signs of infection',
              icon: Icons.warning_amber_outlined,
              child: _Bullets(bullets: signs, isArabic: isArabic),
            ),
            _Box(
              title: isArabic ? 'مرجع (تجريبي)' : 'Reference',
              icon: Icons.link,
              child: _LinkButton(
                label: isArabic ? 'فتح' : 'Open',
                url: refUrl,
                isArabic: isArabic,
                onOpen: (u) => _openUrl(context, isArabic, u),
              ),
            ),
          ],
        );
      },
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

class _Bullets extends StatelessWidget {
  const _Bullets({required this.bullets, required this.isArabic});
  final List<String> bullets;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bullets
          .map(
            (b) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '•  ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF5A6C96),
                ),
              ),
              Expanded(
                child: Text(
                  b,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12.8,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A6C96),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.label,
    required this.url,
    required this.isArabic,
    required this.onOpen,
  });

  final String label;
  final String url;
  final bool isArabic;
  final void Function(String url) onOpen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          url,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: const TextStyle(
            fontSize: 12.6,
            fontWeight: FontWeight.w800,
            color: Color(0xFF2F73FF),
            decoration: TextDecoration.underline,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 44,
          child: ElevatedButton(
            onPressed: url.trim().isEmpty ? null : () => onOpen(url),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F73FF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
