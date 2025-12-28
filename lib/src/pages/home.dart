// lib/src/pages/home.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

import 'general_childcare_information.dart';
import 'tutorials_for_child_care_needs.dart';
import 'spiritual_needs.dart';
import 'hospital_information.dart';
import 'caregiver_support.dart';
import 'track_your_child.dart';
import 'about_your_childs_chd.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _t(bool isArabic, String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Home',
      titleAr: 'الرئيسية',
      headerIcon: Icons.home_outlined,
      showBack: false,
      child: (isArabic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _t(isArabic, 'CHD Caregiver Hub', 'مركز دعم مقدّمي رعاية CHD'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5A6C96),
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _HomeTile(
                          title: _t(isArabic, 'General Childcare\nInformation', 'معلومات الرعاية\nالعامة للطفل'),
                          icon: Icons.child_care_outlined,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const GeneralChildcareInformationPage()),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _HomeTile(
                          title: _t(isArabic, 'Tutorials for\nChild Care Needs', 'شروحات\nلاحتياجات رعاية الطفل'),
                          icon: Icons.ondemand_video_outlined,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const TutorialsForChildCareNeedsPage()),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _HomeTile(
                          title: _t(isArabic, 'Spiritual\nNeeds', 'الاحتياجات\nالروحية'),
                          icon: Icons.self_improvement_outlined,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SpiritualNeedsPage()),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _HomeTile(
                          title: _t(isArabic, 'Hospital\nInformation', 'معلومات\nالمستشفى'),
                          icon: Icons.local_hospital_outlined,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const HospitalInformationPage()),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _HomeTile(
                          title: _t(isArabic, 'Caregiver\nSupport', 'دعم\nمقدّم الرعاية'),
                          icon: Icons.volunteer_activism_outlined,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const CaregiverSupportPage()),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _HomeTile(
                          title: _t(isArabic, 'Track\nYour Child', 'تتبّع\nطفلك'),
                          icon: Icons.monitor_heart_outlined,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const TrackYourChildPage()),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _HomeTileWide(
                    title: _t(isArabic, 'About Your Child’s CHD', 'عن مرض القلب الخِلقي لطفلك'),
                    subtitle: _t(isArabic, 'Education and reliable references', 'تثقيف ومراجع موثوقة'),
                    icon: Icons.favorite_outline,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AboutYourChildsChdPage()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HomeTile extends StatelessWidget {
  const _HomeTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  static const _tileBlue = Color(0xFF2F73FF);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 160),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: _tileBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B2B55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeTileWide extends StatelessWidget {
  const _HomeTileWide({
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
      color: Colors.white.withValues(alpha: 160),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: _tileBlue,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
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
                        fontWeight: FontWeight.w800,
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
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right, color: Color(0xFF5A6C96)),
            ],
          ),
        ),
      ),
    );
  }
}
