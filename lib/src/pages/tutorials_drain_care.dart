// lib/src/pages/tutorials_drain_care.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/chd_scaffold.dart';

class DrainCarePage extends StatelessWidget {
  const DrainCarePage({super.key});

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
      titleEn: 'Drain Care',
      titleAr: 'العناية بالتصريف (الدرنقة)',
      headerIcon: Icons.water_drop_outlined,
      child: (isArabic) {
        final steps = isArabic
            ? const [
          'اغسل يديك جيداً قبل لمس الأنبوب أو الكيس.',
          'أفرغ الكيس في كوب قياس وسجّل الكمية واللون.',
          'نظّف فتحة الدخول بلطف حسب تعليمات المستشفى.',
          'تأكد من عدم وجود شدّ على الأنبوب وثبّت الكيس بالملابس.',
        ]
            : const [
          'Wash hands before touching the tube or bulb.',
          'Empty into a measuring cup and record amount/color.',
          'Clean the insertion site gently as instructed.',
          'Ensure there is no pulling on the tube; secure it to clothing.',
        ];

        final warning = isArabic
            ? 'اتصل بالطبيب إذا ظهر احمرار شديد، أو حرارة موضعية، أو صديد، أو رائحة كريهة، أو ألم متزايد، أو توقف التصريف فجأة.'
            : 'Call the doctor if there is increasing redness/warmth, pus, foul smell, increasing pain, or drainage suddenly stops.';

        final demoVideo = 'https://youtu.be/xDv1D2c8eLY?si=k_oGmB1TbEMpynD8';

        return ListView(
          children: [
            _Box(
              title: isArabic ? 'خطوات سريعة' : 'Quick steps',
              icon: Icons.checklist_outlined,
              child: _Bullets(bullets: steps, isArabic: isArabic),
            ),
            _Box(
              title: isArabic ? 'علامات الخطر' : 'Warning signs',
              icon: Icons.warning_amber_outlined,
              child: Text(
                warning,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: const TextStyle(
                  fontSize: 12.8,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A6C96),
                  height: 1.45,
                ),
              ),
            ),
            _Box(
              title: isArabic ? 'فيديو توضيحي ' : ' video',
              icon: Icons.play_circle_outline,
              child: _LinkButton(
                label: isArabic ? 'فتح الفيديو' : 'Open video',
                url: demoVideo,
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
