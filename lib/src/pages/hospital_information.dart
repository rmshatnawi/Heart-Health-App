// lib/src/pages/hospital_information.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';
import 'hospital_info_section.dart';

class HospitalInformationPage extends StatelessWidget {
  const HospitalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Hospital Information',
      titleAr: 'معلومات المستشفى',
      headerIcon: Icons.local_hospital_outlined,
      child: (isArabic) => _HospitalInfoBody(isArabic: isArabic),
    );
  }
}

class _HospitalInfoBody extends StatelessWidget {
  const _HospitalInfoBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final sections = <_Section>[
      _Section(
        id: 'contact',
        titleEn: 'Hospital Email & Website',
        titleAr: 'بريد المستشفى والموقع الإلكتروني',
        icon: Icons.email_outlined,
      ),
      _Section(
        id: 'followups',
        titleEn: 'Follow-ups',
        titleAr: 'المتابعات',
        icon: Icons.event_outlined,
      ),
      _Section(
        id: 'dining',
        titleEn: 'Dining',
        titleAr: 'الطعام',
        icon: Icons.restaurant_outlined,
      ),
      _Section(
        id: 'showers',
        titleEn: 'Hospital Showers',
        titleAr: 'حمّامات المستشفى',
        icon: Icons.shower_outlined,
      ),
      _Section(
        id: 'map',
        titleEn: 'Area Map',
        titleAr: 'خريطة المكان',
        icon: Icons.map_outlined,
      ),
    ];

    return ListView(
      children: [
        Text(
          _t('King Abdullah University Hospital (KAUH) — Irbid, Jordan', 'مستشفى الملك المؤسس عبد الله الجامعي — إربد، الأردن'),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1B2B55),
          ),
        ),
        const SizedBox(height: 12),
        ...sections.map((s) {
          return _NavCard(
            title: _t(s.titleEn, s.titleAr),
            icon: s.icon,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HospitalInfoSectionPage(
                    sectionId: s.id,
                    titleEn: s.titleEn,
                    titleAr: s.titleAr,
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

class _Section {
  final String id;
  final String titleEn;
  final String titleAr;
  final IconData icon;

  _Section({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.icon,
  });
}

class _NavCard extends StatelessWidget {
  const _NavCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white.withValues(alpha: 230),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
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
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2F73FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
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
                const Icon(Icons.chevron_right_rounded, color: Color(0xFF5A6C96)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
