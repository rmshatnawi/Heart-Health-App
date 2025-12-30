// lib/src/pages/caregiver_support.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

import 'caregiver_patient_stories.dart';
import 'caregiver_support_groups.dart';
import 'caregiver_contacts.dart';
import 'caregiver_personal_contacts.dart';

class CaregiverSupportPage extends StatelessWidget {
  const CaregiverSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Caregiver Support',
      titleAr: 'دعم مقدّم الرعاية',
      headerIcon: Icons.volunteer_activism_outlined,
      child: (isArabic) => _CaregiverSupportBody(isArabic: isArabic),
    );
  }
}

class _CaregiverSupportBody extends StatelessWidget {
  const _CaregiverSupportBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final items = [
      _Entry(
        titleEn: 'Patient Stories',
        titleAr: 'قصص المرضى',
        subtitleEn: 'Read, watch, and write your own story.',
        subtitleAr: 'اقرأ، شاهد، واكتب قصتك.',
        icon: Icons.auto_stories_outlined,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const PatientStoriesPage()),
        ),
      ),
      _Entry(
        titleEn: 'Support Groups',
        titleAr: 'مجموعات الدعم',
        subtitleEn: 'Trusted communities and meeting info.',
        subtitleAr: 'مجتمعات موثوقة ومعلومات اللقاءات.',
        icon: Icons.groups_2_outlined,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SupportGroupsPage()),
        ),
      ),
      _Entry(
        titleEn: 'Contacts',
        titleAr: 'جهات الاتصال',
        subtitleEn: 'Hospital and local resources.',
        subtitleAr: 'المستشفى وموارد محلية.',
        icon: Icons.contact_phone_outlined,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CaregiverContactsPage()),
        ),
      ),
      _Entry(
        titleEn: 'Personal Contacts',
        titleAr: 'جهات اتصال شخصية',
        subtitleEn: 'Emergency, short break, and extra hand.',
        subtitleAr: 'طوارئ، استراحة قصيرة، ومساعدة إضافية.',
        icon: Icons.person_add_alt_1_outlined,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const PersonalContactsPage()),
        ),
      ),
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        final e = items[i];
        return _CardButton(
          title: _t(e.titleEn, e.titleAr),
          subtitle: _t(e.subtitleEn, e.subtitleAr),
          icon: e.icon,
          onTap: e.onTap,
        );
      },
    );
  }
}

class _Entry {
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String subtitleAr;
  final IconData icon;
  final VoidCallback onTap;

  _Entry({
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
    required this.icon,
    required this.onTap,
  });
}

class _CardButton extends StatelessWidget {
  const _CardButton({
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
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
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
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _tileBlue,
                  borderRadius: BorderRadius.circular(14),
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    if (subtitle.trim().isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5A6C96),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right, color: Color(0xFF5A6C96)),
            ],
          ),
        ),
      ),
    );
  }
}
