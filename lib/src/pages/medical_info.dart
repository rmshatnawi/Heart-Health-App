// lib/src/pages/medical_info.dart
import 'package:flutter/material.dart';
import '../components/app_menu.dart';

import 'symptoms.dart';
import 'diseases.dart';
import 'medications.dart';
import 'prevention_tips.dart';
import 'heart_health.dart';
import 'lab_tests.dart';
import 'hydration.dart';
import 'health_info.dart';

class MedicalInfoPage extends StatelessWidget {
  const MedicalInfoPage({super.key});

  // Fixed frame size (phone frame) as requested.
  static const double _phoneWidth = 412.0;
  static const double _phoneHeight = 917.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Outside-of-phone background (web background)
      backgroundColor: const Color(0xFFEEF2FA),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: _phoneWidth,
            height: _phoneHeight,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 22,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  color: const Color(0xFFF3F6FF),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const _Header(),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 230),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(22),
                              bottomRight: Radius.circular(22),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 14,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 14),
                              _MedicalItem(
                                title: 'Symptoms',
                                subtitle: 'Track and understand your symptoms',
                                icon: Icons.monitor_heart_outlined,
                                iconBg: const Color(0xFFEAF2FF),
                                iconColor: const Color(0xFF2F73FF),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const SymptomsPage(),
                                  ),
                                ),
                              ),
                              _MedicalItem(
                                title: 'Diseases',
                                subtitle: 'Learn about common conditions',
                                icon: Icons.medical_services_outlined,
                                iconBg: const Color(0xFFE9FBF6),
                                iconColor: const Color(0xFF1BAA8B),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const DiseasesPage(),
                                  ),
                                ),
                              ),
                              _MedicalItem(
                                title: 'Medications',
                                subtitle: 'Medicine information and usage',
                                icon: Icons.local_pharmacy_outlined,
                                iconBg: const Color(0xFFEFF0FF),
                                iconColor: const Color(0xFF6D5AE6),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const MedicationsPage(),
                                  ),
                                ),
                              ),
                              _MedicalItem(
                                title: 'Prevention Tips',
                                subtitle: 'Stay healthy and safe',
                                icon: Icons.shield_outlined,
                                iconBg: const Color(0xFFE8FFF8),
                                iconColor: const Color(0xFF00A38A),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const PreventionTipsPage(),
                                  ),
                                ),
                              ),
                              _MedicalItem(
                                title: 'Heart Health',
                                subtitle: 'Cardiovascular care tips',
                                icon: Icons.favorite_border,
                                iconBg: const Color(0xFFFFEFF2),
                                iconColor: const Color(0xFFE53935),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const HeartHealthPage(),
                                  ),
                                ),
                              ),
                              _MedicalItem(
                                title: 'Lab Tests',
                                subtitle: 'Understanding your test results',
                                icon: Icons.assignment_outlined,
                                iconBg: const Color(0xFFEAF7FF),
                                iconColor: const Color(0xFF0B84F3),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const LabTestsPage(),
                                  ),
                                ),
                              ),
                              _MedicalItem(
                                title: 'Hydration',
                                subtitle: 'Daily water intake guide',
                                icon: Icons.water_drop_outlined,
                                iconBg: const Color(0xFFEEF5FF),
                                iconColor: const Color(0xFF2D7CFF),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const HydrationPage(),
                                  ),
                                ),
                              ),
                              _MedicalItem(
                                title: 'Health Info',
                                subtitle: 'General health knowledge',
                                icon: Icons.info_outline,
                                iconBg: const Color(0xFFF2EAFF),
                                iconColor: const Color(0xFF8E44FF),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const HealthInfoPage(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2F73FF), Color(0xFF1F66F2)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
          ),
          const SizedBox(width: 2),
          const Expanded(
            child: Text(
              'Medical Info',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const AppMenuButton(iconColor: Colors.white),
          const SizedBox(width: 8),
          SizedBox(
            width: 44,
            height: 44,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/logonly.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicalItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback? onTap;

  const _MedicalItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.8,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B768A),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right_rounded,
                  color: Color(0xFFB7BFCC)),
            ],
          ),
        ),
      ),
    );
  }
}
