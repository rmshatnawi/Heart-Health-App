// lib/src/pages/hospital_info_section.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/chd_scaffold.dart';

class HospitalInfoSectionPage extends StatelessWidget {
  const HospitalInfoSectionPage({
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
      titleEn: titleEn.isEmpty ? 'Hospital Info' : titleEn,
      titleAr: titleAr.isEmpty ? 'معلومات المستشفى' : titleAr,
      headerIcon: Icons.info_outline,
      child: (isArabic) => _SectionBody(isArabic: isArabic, sectionId: sectionId),
    );
  }
}

class _SectionBody extends StatelessWidget {
  const _SectionBody({required this.isArabic, required this.sectionId});
  final bool isArabic;
  final String sectionId;

  String _t(String en, String ar) => isArabic ? ar : en;

  List<_Item> _items() {
    // KAUH official website + contact email (from KAUH Contacts page).
    const kauhHome = 'https://www.kauh.edu.jo/Home';
    const kauhContacts = 'https://www.kauh.edu.jo/Contacts';
    const kauhEmail = 'KAUH@JUST.EDU.JO';

    // Google Maps deep link (works on Android).
    const mapsUrl = 'https://www.google.com/maps/search/?api=1&query=King+Abdullah+University+Hospital+KAUH';

    // Follow-ups: link to calendar (generic calendar app via web).
    const calendarUrl = 'https://calendar.google.com';

    switch (sectionId) {
      case 'contact':
        return [
          _Item.text(
            titleEn: 'Email',
            titleAr: 'البريد الإلكتروني',
            bodyEn: kauhEmail,
            bodyAr: kauhEmail,
          ),
          _Item.link(
            titleEn: 'Send an Email',
            titleAr: 'إرسال بريد',
            url: 'mailto:$kauhEmail',
          ),
          _Item.link(
            titleEn: 'Hospital Website',
            titleAr: 'موقع المستشفى',
            url: kauhHome,
          ),
          _Item.link(
            titleEn: 'Contact Page',
            titleAr: 'صفحة التواصل',
            url: kauhContacts,
          ),
        ];

      case 'followups':
        return [
          _Item.text(
            titleEn: 'Follow-up Scheduling',
            titleAr: 'جدولة المتابعات',
            bodyEn:
            'Use your calendar to record clinic visits, doctor notes, and next follow-up dates. Keep reminders enabled to avoid missed appointments.',
            bodyAr:
            'استخدم التقويم لتسجيل مواعيد العيادات وملاحظات الطبيب وتاريخ المتابعة القادمة. فعّل التذكير لتجنب نسيان المواعيد.',
          ),
          _Item.link(
            titleEn: 'Open Calendar',
            titleAr: 'فتح التقويم',
            url: calendarUrl,
          ),
        ];

      case 'dining':
        return [
          _Item.text(
            titleEn: 'Hospital Cafeteria',
            titleAr: 'كافتيريا المستشفى',
            bodyEn:
            'Meals and snacks are available inside the hospital. For updated daily options, check hospital announcements and visitor services.',
            bodyAr:
            'تتوفر وجبات خفيفة ووجبات داخل المستشفى. لمعرفة الخيارات اليومية المحدّثة، راجع إعلانات المستشفى وخدمات الزوار.',
          ),
          _Item.link(
            titleEn: 'Hospital Website (Updates)',
            titleAr: 'موقع المستشفى (تحديثات)',
            url: 'https://www.kauh.edu.jo/Home',
          ),
          _Item.link(
            titleEn: 'Contact Visitor Services',
            titleAr: 'التواصل مع خدمات الزوار',
            url: 'https://www.kauh.edu.jo/Contacts',
          ),
        ];

      case 'showers':
        return [
          _Item.text(
            titleEn: 'Showers',
            titleAr: 'الحمّامات',
            bodyEn:
            'Inpatient wards typically have bathroom/shower facilities. Ask the nursing station in your ward about the nearest family shower and access rules.',
            bodyAr:
            'عادةً تحتوي أجنحة التنويم على مرافق حمّام/دش. اسأل محطة التمريض في جناحك عن أقرب دش للعائلة وتعليمات الاستخدام.',
          ),
          _Item.text(
            titleEn: 'What to bring',
            titleAr: 'ماذا تحضر',
            bodyEn: 'Towel, slippers, personal toiletries, and a change of clothes.',
            bodyAr: 'منشفة، شبشب، أدوات نظافة شخصية، وملابس بديلة.',
          ),
        ];

      case 'map':
        return [
          _Item.text(
            titleEn: 'Location',
            titleAr: 'الموقع',
            bodyEn: 'King Abdullah University Hospital (KAUH) — Irbid / Ar Ramtha area, Jordan.',
            bodyAr: 'مستشفى الملك المؤسس عبد الله الجامعي — منطقة إربد / الرمثا، الأردن.',
          ),
          _Item.map(
            titleEn: 'Open Map',
            titleAr: 'فتح الخريطة',
            url: mapsUrl,
          ),
        ];

      default:
        return [
          _Item.text(
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
    final items = _items();

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        final it = items[i];

        final title = isArabic ? (it.titleAr.isEmpty ? it.titleEn : it.titleAr) : (it.titleEn.isEmpty ? it.titleAr : it.titleEn);
        final body = isArabic ? (it.bodyAr.isEmpty ? it.bodyEn : it.bodyAr) : (it.bodyEn.isEmpty ? it.bodyAr : it.bodyEn);

        if (it.type == _ItemType.link || it.type == _ItemType.map) {
          return _Box(
            title: title.isEmpty ? _t('Link', 'رابط') : title,
            icon: it.type == _ItemType.map ? Icons.map_outlined : Icons.link,
            child: _LinkRow(url: it.url, isArabic: isArabic),
          );
        }

        return _Box(
          title: title.isEmpty ? _t('Info', 'معلومة') : title,
          icon: Icons.article_outlined,
          child: Text(
            body.trim().isEmpty ? _t('No text.', 'لا يوجد نص.') : body,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: const TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5A6C96),
              height: 1.5,
            ),
          ),
        );
      },
    );
  }
}

enum _ItemType { text, link, map }

class _Item {
  final _ItemType type;
  final String titleEn;
  final String titleAr;
  final String bodyEn;
  final String bodyAr;
  final String url;

  const _Item._({
    required this.type,
    required this.titleEn,
    required this.titleAr,
    required this.bodyEn,
    required this.bodyAr,
    required this.url,
  });

  factory _Item.text({
    required String titleEn,
    required String titleAr,
    required String bodyEn,
    required String bodyAr,
  }) {
    return _Item._(
      type: _ItemType.text,
      titleEn: titleEn,
      titleAr: titleAr,
      bodyEn: bodyEn,
      bodyAr: bodyAr,
      url: '',
    );
  }

  factory _Item.link({
    required String titleEn,
    required String titleAr,
    required String url,
  }) {
    return _Item._(
      type: _ItemType.link,
      titleEn: titleEn,
      titleAr: titleAr,
      bodyEn: '',
      bodyAr: '',
      url: url,
    );
  }

  factory _Item.map({
    required String titleEn,
    required String titleAr,
    required String url,
  }) {
    return _Item._(
      type: _ItemType.map,
      titleEn: titleEn,
      titleAr: titleAr,
      bodyEn: '',
      bodyAr: '',
      url: url,
    );
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
          shown.isEmpty ? (isArabic ? 'لا يوجد رابط.' : 'No link.') : shown,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            fontSize: 12.6,
            fontWeight: FontWeight.w800,
            color: shown.isEmpty ? const Color(0xFF5A6C96) : const Color(0xFF2F73FF),
            decoration: shown.isEmpty ? null : TextDecoration.underline,
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
