// lib/src/pages/general_childcare_information.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

import 'gcc_development_by_age.dart';
import 'gcc_newborn_care_websites.dart';
import 'gcc_vaccines.dart';

class GeneralChildcareInformationPage extends StatelessWidget {
  const GeneralChildcareInformationPage({super.key});

  String _t(bool isArabic, String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'General Childcare Information',
      titleAr: 'معلومات الرعاية العامة للطفل',
      headerIcon: Icons.child_care_outlined,
      child: (isArabic) => ListView(
        children: [
          _HubTile(
            title: _t(isArabic, 'Development by Age', 'التطور حسب العمر'),
            subtitle: _t(
              isArabic,
              'Library broken down by age ranges',
              'مكتبة معلومات حسب الفئات العمرية',
            ),
            icon: Icons.stacked_line_chart_outlined,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const GccDevelopmentByAgePage()),
            ),
          ),
          const SizedBox(height: 12),
          _HubTile(
            title: _t(isArabic, 'Newborn Care Websites', 'مواقع رعاية حديثي الولادة'),
            subtitle: _t(
              isArabic,
              'Trusted newborn care resources',
              'مصادر موثوقة لرعاية حديثي الولادة',
            ),
            icon: Icons.public_outlined,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const GccNewbornCareWebsitesPage()),
            ),
          ),
          const SizedBox(height: 12),
          _HubTile(
            title: _t(isArabic, 'Vaccines', 'اللقاحات'),
            subtitle: _t(
              isArabic,
              'Vaccines schedule and guidance',
              'جدول اللقاحات وإرشاداتها',
            ),
            icon: Icons.vaccines_outlined,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const GccVaccinesPage()),
            ),
          ),
        ],
      ),
    );
  }
}

class _HubTile extends StatelessWidget {
  const _HubTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  static const _tileBlue = Color(0xFF2F73FF);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 240),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _tileBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5A6C96),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Color(0xFF5A6C96)),
            ],
          ),
        ),
      ),
    );
  }
}
