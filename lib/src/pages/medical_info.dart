// lib/src/pages/medical_info.dart
import 'package:flutter/material.dart';

class MedicalInfoPage extends StatelessWidget {
  const MedicalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                children: const [
                  Text(
                    'Access trusted medical information at your fingertips',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5B677A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 14),
                  _MedicalItem(
                    title: 'Symptoms',
                    subtitle: 'Track and understand your symptoms',
                    icon: Icons.monitor_heart_outlined,
                    iconBg: Color(0xFFEAF2FF),
                    iconColor: Color(0xFF2F73FF),
                  ),
                  _MedicalItem(
                    title: 'Diseases',
                    subtitle: 'Learn about common conditions',
                    icon: Icons.medical_services_outlined,
                    iconBg: Color(0xFFE9FBF6),
                    iconColor: Color(0xFF1BAA8B),
                  ),
                  _MedicalItem(
                    title: 'Medications',
                    subtitle: 'Medicine information and usage',
                    icon: Icons.local_pharmacy_outlined,
                    iconBg: Color(0xFFEFF0FF),
                    iconColor: Color(0xFF6D5AE6),
                  ),
                  _MedicalItem(
                    title: 'Prevention Tips',
                    subtitle: 'Stay healthy and safe',
                    icon: Icons.shield_outlined,
                    iconBg: Color(0xFFE8FFF8),
                    iconColor: Color(0xFF00A38A),
                  ),
                  _MedicalItem(
                    title: 'Heart Health',
                    subtitle: 'Cardiovascular care tips',
                    icon: Icons.favorite_border,
                    iconBg: Color(0xFFFFEFF2),
                    iconColor: Color(0xFFE53935),
                  ),
                  _MedicalItem(
                    title: 'Lab Tests',
                    subtitle: 'Understanding your test results',
                    icon: Icons.assignment_outlined,
                    iconBg: Color(0xFFEAF7FF),
                    iconColor: Color(0xFF0B84F3),
                  ),
                  _MedicalItem(
                    title: 'Hydration',
                    subtitle: 'Daily water intake guide',
                    icon: Icons.water_drop_outlined,
                    iconBg: Color(0xFFEEF5FF),
                    iconColor: Color(0xFF2D7CFF),
                  ),
                  _MedicalItem(
                    title: 'Health Info',
                    subtitle: 'General health knowledge',
                    icon: Icons.info_outline,
                    iconBg: Color(0xFFF2EAFF),
                    iconColor: Color(0xFF8E44FF),
                  ),
                ],
              ),
            ),
          ],
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
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2F73FF),
            Color(0xFF1F66F2),
          ],
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
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          const SizedBox(width: 6),
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
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 46),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.medical_services_outlined,
              color: Colors.white,
              size: 24,
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

  const _MedicalItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
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
        onTap: () {
          // TODO: navigate to each section later
        },
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
              const Icon(Icons.chevron_right_rounded, color: Color(0xFFB7BFCC)),
            ],
          ),
        ),
      ),
    );
  }
}
