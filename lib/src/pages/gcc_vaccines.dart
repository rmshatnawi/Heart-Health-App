// lib/src/pages/gcc_vaccines.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/chd_scaffold.dart';

class GccVaccinesPage extends StatelessWidget {
  const GccVaccinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Vaccines',
      titleAr: 'اللقاحات',
      headerIcon: Icons.vaccines_outlined,
      child: (isArabic) => _VaccinesBody(isArabic: isArabic),
    );
  }
}

class _VaccinesBody extends StatelessWidget {
  const _VaccinesBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

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
    final blocks = [
      _Block.section(
        titleEn: 'Why vaccines matter',
        titleAr: 'لماذا اللقاحات مهمة؟',
        bulletsEn: [
          'Protects infants from serious infections.',
          'Helps reduce spread in the community.',
          'Important for children with medical conditions, with doctor guidance.',
        ],
        bulletsAr: [
          'تحمي الرضع من العدوى الخطيرة.',
          'تقلل انتشار الأمراض في المجتمع.',
          'مهمة للأطفال ذوي الحالات الطبية مع إرشاد الطبيب.',
        ],
      ),
      _Block.section(
        titleEn: 'General schedule (example)',
        titleAr: 'الجدول العام (مثال)',
        bulletsEn: [
          'Birth: HepB (as advised).',
          '2 months: routine infant vaccines.',
          '4 months: routine infant vaccines.',
          '6 months: routine infant vaccines.',
          '12 months: routine toddler vaccines.',
        ],
        bulletsAr: [
          'عند الولادة: التهاب الكبد B (حسب الإرشاد).',
          'عمر شهرين: لقاحات الرضع الروتينية.',
          'عمر ٤ أشهر: لقاحات الرضع الروتينية.',
          'عمر ٦ أشهر: لقاحات الرضع الروتينية.',
          'عمر ١٢ شهراً: لقاحات الأطفال الروتينية.',
        ],
      ),
      _Block.note(
        titleEn: 'CHD note',
        titleAr: 'ملاحظة لمرضى القلب الخلقي',
        bodyEn:
        'Always confirm the best vaccine timing with your child’s cardiologist/pediatrician, especially around surgeries or hospital stays.',
        bodyAr:
        'أكد دائماً توقيت اللقاحات المناسب مع طبيب القلب/الأطفال، خصوصاً قبل أو بعد العمليات أو فترات التنويم.',
      ),
      _Block.link(
        titleEn: 'Trusted reference',
        titleAr: 'مرجع موثوق',
        url: 'https://www.cdc.gov/vaccines/schedules/',
      ),
    ];

    return ListView.separated(
      itemCount: blocks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final b = blocks[i];
        return _BlockCard(
          block: b,
          isArabic: isArabic,
          onOpen: (url) => _openUrl(context, url),
        );
      },
    );
  }
}

class _Block {
  final String kind; // section | note | link
  final String titleEn;
  final String titleAr;

  final List<String> bulletsEn;
  final List<String> bulletsAr;

  final String bodyEn;
  final String bodyAr;

  final String url;

  const _Block._({
    required this.kind,
    required this.titleEn,
    required this.titleAr,
    this.bulletsEn = const [],
    this.bulletsAr = const [],
    this.bodyEn = '',
    this.bodyAr = '',
    this.url = '',
  });

  factory _Block.section({
    required String titleEn,
    required String titleAr,
    required List<String> bulletsEn,
    required List<String> bulletsAr,
  }) =>
      _Block._(
        kind: 'section',
        titleEn: titleEn,
        titleAr: titleAr,
        bulletsEn: bulletsEn,
        bulletsAr: bulletsAr,
      );

  factory _Block.note({
    required String titleEn,
    required String titleAr,
    required String bodyEn,
    required String bodyAr,
  }) =>
      _Block._(
        kind: 'note',
        titleEn: titleEn,
        titleAr: titleAr,
        bodyEn: bodyEn,
        bodyAr: bodyAr,
      );

  factory _Block.link({
    required String titleEn,
    required String titleAr,
    required String url,
  }) =>
      _Block._(
        kind: 'link',
        titleEn: titleEn,
        titleAr: titleAr,
        url: url,
      );
}

class _BlockCard extends StatelessWidget {
  const _BlockCard({
    required this.block,
    required this.isArabic,
    required this.onOpen,
  });

  final _Block block;
  final bool isArabic;
  final void Function(String url) onOpen;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final title = _t(block.titleEn, block.titleAr);

    IconData icon = Icons.info_outline;
    if (block.kind == 'section') icon = Icons.list_alt_outlined;
    if (block.kind == 'link') icon = Icons.link;

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
          if (block.kind == 'section')
            _Bullets(
              bullets: isArabic ? block.bulletsAr : block.bulletsEn,
              isArabic: isArabic,
            )
          else if (block.kind == 'link')
            Material(
              color: const Color(0xFFF8FAFF),
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: block.url.trim().isEmpty ? null : () => onOpen(block.url),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE3EBFF)),
                  ),
                  child: Text(
                    block.url,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(
                      fontSize: 12.6,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2F73FF),
                      decoration: TextDecoration.underline,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            )
          else
            Text(
              _t(block.bodyEn, block.bodyAr),
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                fontSize: 12.8,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
                height: 1.45,
              ),
            ),
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
      children: bullets.map((b) {
        return Padding(
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
        );
      }).toList(),
    );
  }
}
