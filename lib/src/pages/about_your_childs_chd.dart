// lib/src/pages/about_your_childs_chd.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';
import 'about_chd_section.dart';

class AboutYourChildsChdPage extends StatelessWidget {
  const AboutYourChildsChdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'About Your Child’s CHD',
      titleAr: 'عن مرض القلب الخِلقي لطفلك',
      headerIcon: Icons.favorite_outline,
      child: (isArabic) => _AboutChdBody(isArabic: isArabic),
    );
  }
}

class _AboutChdBody extends StatelessWidget {
  const _AboutChdBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final sections = <_Section>[
      _Section(
        id: 'medications',
        titleEn: 'Medications',
        titleAr: 'الأدوية',
        icon: Icons.medication_outlined,
        subtitleEn: 'What they are for and how they relate to CHD care.',
        subtitleAr: 'لماذا تُستخدم وكيف ترتبط برعاية أمراض القلب الخِلقية.',
      ),
      _Section(
        id: 'trusted_links',
        titleEn: 'Trusted CHD Websites',
        titleAr: 'مواقع موثوقة عن CHD',
        icon: Icons.verified_outlined,
        subtitleEn: 'Reliable sources like CDC and AHA.',
        subtitleAr: 'مصادر موثوقة مثل CDC و AHA.',
      ),
      _Section(
        id: 'defects_treatments',
        titleEn: 'Defects & Treatments Library',
        titleAr: 'مكتبة العيوب والعلاجات',
        icon: Icons.library_books_outlined,
        subtitleEn: 'Common defects, treatments, and learning videos.',
        subtitleAr: 'عيوب شائعة وعلاجات وروابط فيديو تعليمية.',
      ),
    ];

    return ListView(
      children: [
        Text(
          _t(
            'Learn the basics of congenital heart disease (CHD) and common care topics.',
            'تعرّف على أساسيات أمراض القلب الخِلقية ومواضيع الرعاية الشائعة.',
          ),
          style: const TextStyle(
            fontSize: 12.8,
            fontWeight: FontWeight.w700,
            color: Color(0xFF5A6C96),
            height: 1.5,
          ),
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
        ),
        const SizedBox(height: 12),
        ...sections.map((s) {
          return _NavCard(
            title: _t(s.titleEn, s.titleAr),
            subtitle: _t(s.subtitleEn, s.subtitleAr),
            icon: s.icon,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AboutChdSectionPage(
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
  final String subtitleEn;
  final String subtitleAr;
  final IconData icon;

  _Section({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
    required this.icon,
  });
}

class _NavCard extends StatelessWidget {
  const _NavCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B2B55),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12.2,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF5A6C96),
                          height: 1.35,
                        ),
                      ),
                    ],
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
