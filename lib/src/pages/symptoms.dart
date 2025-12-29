// lib/src/pages/symptoms.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class SymptomsPage extends StatelessWidget {
  const SymptomsPage({super.key});

  static const double _phoneWidth = 412.0;
  static const double _phoneHeight = 917.0;

  static const _blue = Color(0xFF2F73FF);
  static const _warn = Color(0xFFF2994A);
  static const _danger = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // outside background (web)
      backgroundColor: const Color(0xFFEEF2FA),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: _phoneWidth,
            height: _phoneHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: const SimpleInfoPage(
                title: 'Symptoms',
                headerIcon: Icons.monitor_heart_outlined,
                gradient: [Color(0xFF3A7AF4), Color(0xFF5F92FD)],
                sections: [
                  InfoSection(
                    title: 'Common Symptoms',
                    subtitle: 'These symptoms may occur regularly with CHD',
                    headerBg: Color(0xFF5F92FD),
                    items: [
                      InfoItem(
                        icon: Icons.monitor_heart_outlined,
                        iconColor: _blue,
                        title: 'Fatigue & Tiredness',
                        description:
                        'Feeling unusually tired during normal activities or needing frequent rest periods throughout the day.',
                      ),
                      InfoItem(
                        icon: Icons.air_rounded,
                        iconColor: _blue,
                        title: 'Shortness of Breath',
                        description:
                        'Difficulty breathing during activities like playing, walking, or feeding. May breathe faster than normal.',
                      ),
                      InfoItem(
                        icon: Icons.favorite_border,
                        iconColor: _blue,
                        title: 'Poor Growth',
                        description:
                        'Not gaining weight as expected or growing slower than peers. May have decreased appetite.',
                      ),
                      InfoItem(
                        icon: Icons.water_drop_outlined,
                        iconColor: _blue,
                        title: 'Excessive Sweating',
                        description:
                        'Sweating more than usual, especially during feeding or light activity. May feel clammy.',
                      ),
                    ],
                  ),
                  InfoSection(
                    title: 'Warning Signs',
                    subtitle: 'Contact your healthcare provider if you notice these',
                    headerBg: Color(0xFFFBBE86),
                    items: [
                      InfoItem(
                        icon: Icons.error_outline_rounded,
                        iconColor: _warn,
                        title: 'Blue Tinge to Skin',
                        description:
                        'Cyanosis — bluish color around lips, fingernails, or skin, indicating low oxygen levels.',
                      ),
                      InfoItem(
                        icon: Icons.opacity_outlined,
                        iconColor: _warn,
                        title: 'Swelling (Edema)',
                        description:
                        'Fluid buildup causing swelling in legs, ankles, feet, or around the eyes.',
                      ),
                      InfoItem(
                        icon: Icons.favorite_outline_rounded,
                        iconColor: _warn,
                        title: 'Rapid Heartbeat',
                        description:
                        'Heart racing or pounding, irregular rhythm, or palpitations that persist.',
                      ),
                      InfoItem(
                        icon: Icons.monitor_heart_outlined,
                        iconColor: _warn,
                        title: 'Dizziness or Fainting',
                        description:
                        'Feeling lightheaded, dizzy, or episodes of fainting, especially during activity.',
                      ),
                    ],
                  ),
                  InfoSection(
                    title: 'Emergency Symptoms',
                    subtitle: 'Call 911 or go to the ER immediately',
                    headerBg: Color(0xFFEA6260),
                    items: [
                      InfoItem(
                        icon: Icons.warning_amber_rounded,
                        iconColor: _danger,
                        title: 'Severe Breathing Difficulty',
                        description:
                        'Gasping for air, unable to complete sentences, or extreme difficulty breathing.',
                      ),
                      InfoItem(
                        icon: Icons.warning_amber_rounded,
                        iconColor: _danger,
                        title: 'Chest Pain',
                        description:
                        "Sharp or crushing pain in the chest, pressure, or discomfort that doesn't go away.",
                      ),
                      InfoItem(
                        icon: Icons.warning_amber_rounded,
                        iconColor: _danger,
                        title: 'Loss of Consciousness',
                        description:
                        'Fainting, unresponsive, or cannot be awakened. This requires immediate emergency care.',
                      ),
                      InfoItem(
                        icon: Icons.warning_amber_rounded,
                        iconColor: _danger,
                        title: 'Severe Cyanosis',
                        description:
                        'Deep blue or purple coloring of the lips, face, or extremities indicating critical oxygen levels.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
