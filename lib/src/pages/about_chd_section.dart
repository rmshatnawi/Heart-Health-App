// lib/src/pages/about_chd_section.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/chd_scaffold.dart';

class AboutChdSectionPage extends StatelessWidget {
  const AboutChdSectionPage({
    super.key,
    required this.sectionId,
    required this.titleEn,
    required this.titleAr,
  });

  final String sectionId;
  final String titleEn;
  final String titleAr;

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: titleEn.isEmpty ? 'About CHD' : titleEn,
      titleAr: titleAr.isEmpty ? 'عن CHD' : titleAr,
      headerIcon: Icons.favorite_outline,
      child: (isArabic) => _SectionBody(isArabic: isArabic, sectionId: sectionId),
    );
  }
}

class _SectionBody extends StatelessWidget {
  const _SectionBody({required this.isArabic, required this.sectionId});
  final bool isArabic;
  final String sectionId;

  String _t(String en, String ar) => isArabic ? ar : en;

  List<_Block> _blocks() {
    // NOTE: static content now; later replace with Firestore (same structure you used elsewhere).
    switch (sectionId) {
      case 'medications':
        return [
          _Block.text(
            titleEn: 'Why medications may be needed',
            titleAr: 'لماذا قد يحتاج الطفل إلى أدوية',
            bodyEn:
            'Some children with CHD need medicines to support the heart’s pumping, control fluid buildup, manage blood pressure, prevent clots, or maintain a stable rhythm. The exact medication depends on the defect and the treatment plan.',
            bodyAr:
            'بعض الأطفال المصابين بعيوب قلبية خِلقية قد يحتاجون أدوية لدعم ضخ القلب، تقليل احتباس السوائل، ضبط الضغط، الوقاية من الجلطات، أو تنظيم النبض. نوع الدواء يعتمد على العيب وخطة العلاج.',
          ),
          _Block.text(
            titleEn: 'Common medication groups (examples)',
            titleAr: 'مجموعات أدوية شائعة (أمثلة)',
            bodyEn:
            '• Diuretics: reduce extra fluid and ease breathing.\n'
                '• ACE inhibitors: reduce workload on the heart and lower blood pressure.\n'
                '• Beta-blockers: slow heart rate and help rhythm control.\n'
                '• Anticoagulants/antiplatelets: reduce clot risk when recommended.\n'
                '• Antibiotic prophylaxis: sometimes used for certain procedures if advised.',
            bodyAr:
            '• مُدرّات البول: تقلل السوائل الزائدة وتساعد على التنفس.\n'
                '• مثبطات ACE: تقلل عبء العمل على القلب وتخفض الضغط.\n'
                '• حاصرات بيتا: تبطئ النبض وتساعد على تنظيم الإيقاع.\n'
                '• مميّعات/مضادات الصفائح: تقلل خطر الجلطات عند الحاجة.\n'
                '• وقاية بالمضادات الحيوية: أحياناً لإجراءات معينة حسب توجيه الطبيب.',
          ),
          _Block.text(
            titleEn: 'Safety reminders',
            titleAr: 'تنبيهات مهمة',
            bodyEn:
            'Always follow the cardiologist’s instructions. Do not change dose or stop a medication without medical advice. Keep a list of medications and allergies.',
            bodyAr:
            'اتبع تعليمات طبيب القلب دائماً. لا تغيّر الجرعة ولا توقف الدواء دون استشارة. احتفظ بقائمة الأدوية والحساسية.',
          ),
        ];

      case 'trusted_links':
        return [
          _Block.text(
            titleEn: 'Use trusted sources',
            titleAr: 'استخدم مصادر موثوقة',
            bodyEn:
            'For accurate information about congenital heart defects, prefer recognized medical organizations and public health agencies.',
            bodyAr:
            'للحصول على معلومات دقيقة عن عيوب القلب الخِلقية، اعتمد على الجهات الطبية الرسمية ومنظمات الصحة العامة.',
          ),
          _Block.link(
            titleEn: 'CDC — Congenital Heart Defects',
            titleAr: 'CDC — عيوب القلب الخِلقية',
            url: 'https://www.cdc.gov/ncbddd/heartdefects/index.html',
          ),
          _Block.link(
            titleEn: 'American Heart Association — Congenital Heart Defects',
            titleAr: 'جمعية القلب الأمريكية — عيوب القلب الخِلقية',
            url: 'https://www.heart.org/en/health-topics/congenital-heart-defects',
          ),
          _Block.link(
            titleEn: 'NHLBI — Congenital Heart Defects',
            titleAr: 'NHLBI — عيوب القلب الخِلقية',
            url: 'https://www.nhlbi.nih.gov/health/congenital-heart-defects',
          ),
        ];

      case 'defects_treatments':
        return [
          _Block.text(
            titleEn: 'Library overview',
            titleAr: 'نظرة عامة على المكتبة',
            bodyEn:
            'This section lists common congenital heart defects and typical treatments. Details vary per child; use this for learning and discuss specifics with your cardiology team.',
            bodyAr:
            'هذا القسم يعرض عيوباً قلبية خِلقية شائعة وعلاجاتها المعتادة. التفاصيل تختلف حسب حالة الطفل؛ استخدمه للتعلّم وناقش التفاصيل مع فريق القلب.',
          ),
          _Block.group(
            titleEn: 'Common defects',
            titleAr: 'عيوب شائعة',
            children: [
              _Block.text(
                titleEn: 'VSD (Ventricular Septal Defect)',
                titleAr: 'ثقب بين البطينين (VSD)',
                bodyEn:
                'A hole between the lower chambers. Small VSDs may close; larger ones can cause extra blood flow to the lungs.',
                bodyAr:
                'فتحة بين الحجرتين السفليتين. الثقوب الصغيرة قد تُغلق، والكبيرة قد تسبب زيادة تدفق الدم للرئتين.',
              ),
              _Block.text(
                titleEn: 'ASD (Atrial Septal Defect)',
                titleAr: 'ثقب بين الأذينين (ASD)',
                bodyEn:
                'A hole between the upper chambers. Some ASDs close; others may need closure to reduce strain on the heart and lungs.',
                bodyAr:
                'فتحة بين الحجرتين العلويتين. بعض الثقوب تُغلق، وأخرى قد تحتاج إغلاقاً لتقليل العبء على القلب والرئتين.',
              ),
              _Block.text(
                titleEn: 'TOF (Tetralogy of Fallot)',
                titleAr: 'رباعية فالو (TOF)',
                bodyEn:
                'A combination of defects that can reduce oxygen levels. Usually treated with surgery.',
                bodyAr:
                'مجموعة عيوب قد تقلل الأكسجين في الدم. غالباً تُعالج بالجراحة.',
              ),
              _Block.text(
                titleEn: 'Coarctation of the Aorta',
                titleAr: 'تضيّق الشريان الأورطي',
                bodyEn:
                'A narrowing of the aorta that can raise blood pressure and reduce flow to the body. Treated with surgery or catheter procedures.',
                bodyAr:
                'تضيّق في الأورطي قد يرفع الضغط ويقلل التروية. يُعالج بالجراحة أو القسطرة.',
              ),
            ],
          ),
          _Block.group(
            titleEn: 'Treatments',
            titleAr: 'العلاجات',
            children: [
              _Block.text(
                titleEn: 'Medications',
                titleAr: 'الأدوية',
                bodyEn:
                'Used to support heart function, manage symptoms, and reduce complications when needed.',
                bodyAr:
                'تُستخدم لدعم وظيفة القلب وتخفيف الأعراض وتقليل المضاعفات عند الحاجة.',
              ),
              _Block.text(
                titleEn: 'Cardiac catheterization',
                titleAr: 'قسطرة القلب',
                bodyEn:
                'A minimally invasive procedure that may diagnose or treat certain defects (for example, closing some holes or widening narrowed areas).',
                bodyAr:
                'إجراء تدخلّي بسيط للتشخيص أو العلاج (مثل إغلاق بعض الثقوب أو توسيع مناطق التضيق).',
              ),
              _Block.text(
                titleEn: 'Surgery',
                titleAr: 'الجراحة',
                bodyEn:
                'Repairs or reconstructs heart structures. Timing depends on the defect and the child’s condition.',
                bodyAr:
                'إصلاح أو إعادة بناء أجزاء من القلب. التوقيت يعتمد على العيب وحالة الطفل.',
              ),
            ],
          ),
          _Block.group(
            titleEn: 'Videos (links)',
            titleAr: 'فيديوهات (روابط)',
            children: [
              _Block.link(
                titleEn: 'CHD overview video',
                titleAr: 'فيديو نظرة عامة عن CHD',
                url: 'https://www.youtube.com/results?search_query=congenital+heart+disease+overview',
              ),
              _Block.link(
                titleEn: 'VSD explained',
                titleAr: 'شرح VSD',
                url: 'https://www.youtube.com/results?search_query=ventricular+septal+defect+explained',
              ),
              _Block.link(
                titleEn: 'Tetralogy of Fallot explained',
                titleAr: 'شرح رباعية فالو',
                url: 'https://www.youtube.com/results?search_query=tetralogy+of+fallot+explained',
              ),
              _Block.link(
                titleEn: 'Cardiac catheterization explained',
                titleAr: 'شرح قسطرة القلب',
                url: 'https://www.youtube.com/results?search_query=cardiac+catheterization+explained',
              ),
            ],
          ),
        ];

      default:
        return [
          _Block.text(
            titleEn: 'No content',
            titleAr: 'لا يوجد محتوى',
            bodyEn: 'This section is not configured.',
            bodyAr: 'هذا القسم غير مُعد.',
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final blocks = _blocks();

    return ListView(
      children: blocks.map((b) => _BlockView(block: b, isArabic: isArabic)).toList(),
    );
  }
}

/* ===========================
   BLOCK MODEL + UI
=========================== */

enum _BlockType { text, link, group }

class _Block {
  final _BlockType type;
  final String titleEn;
  final String titleAr;
  final String bodyEn;
  final String bodyAr;
  final String url;
  final List<_Block> children;

  const _Block._({
    required this.type,
    required this.titleEn,
    required this.titleAr,
    required this.bodyEn,
    required this.bodyAr,
    required this.url,
    required this.children,
  });

  factory _Block.text({
    required String titleEn,
    required String titleAr,
    required String bodyEn,
    required String bodyAr,
  }) {
    return _Block._(
      type: _BlockType.text,
      titleEn: titleEn,
      titleAr: titleAr,
      bodyEn: bodyEn,
      bodyAr: bodyAr,
      url: '',
      children: const [],
    );
  }

  factory _Block.link({
    required String titleEn,
    required String titleAr,
    required String url,
  }) {
    return _Block._(
      type: _BlockType.link,
      titleEn: titleEn,
      titleAr: titleAr,
      bodyEn: '',
      bodyAr: '',
      url: url,
      children: const [],
    );
  }

  factory _Block.group({
    required String titleEn,
    required String titleAr,
    required List<_Block> children,
  }) {
    return _Block._(
      type: _BlockType.group,
      titleEn: titleEn,
      titleAr: titleAr,
      bodyEn: '',
      bodyAr: '',
      url: '',
      children: children,
    );
  }
}

class _BlockView extends StatelessWidget {
  const _BlockView({required this.block, required this.isArabic});
  final _Block block;
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final title = _t(block.titleEn, block.titleAr);

    switch (block.type) {
      case _BlockType.group:
        return _Box(
          title: title,
          icon: Icons.folder_open_outlined,
          child: Column(
            children: block.children
                .map((c) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _BlockView(block: c, isArabic: isArabic),
            ))
                .toList(),
          ),
        );

      case _BlockType.link:
        return _Box(
          title: title,
          icon: Icons.link,
          child: _LinkRow(url: block.url, isArabic: isArabic),
        );

      case _BlockType.text:
      default:
        final body = _t(block.bodyEn, block.bodyAr);
        return _Box(
          title: title,
          icon: Icons.article_outlined,
          child: Text(
            body,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: const TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5A6C96),
              height: 1.5,
            ),
          ),
        );
    }
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.url, required this.isArabic});
  final String url;
  final bool isArabic;

  Future<void> _open(BuildContext context) async {
    final uri = Uri.tryParse(url.trim());
    if (uri == null || uri.scheme.isEmpty) {
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
    final shown = url.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          shown,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
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
            onPressed: shown.isEmpty ? null : () => _open(context),
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
