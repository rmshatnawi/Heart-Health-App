import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class PreventionTipsPage extends StatelessWidget {
  const PreventionTipsPage({super.key});

  static const Color _green = Color(0xFF00A38A);
  static const Color _white = Colors.white;
  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Prevention Tips',
      headerIcon: Icons.shield_outlined,
      gradient: [_green, Color(0xFF008A75)],
      sections: [
        InfoSection(
          title: 'Daily Care',
          subtitle: '',
          headerBg: _green,
          items: [
            InfoItem(
              icon: Icons.monitor_heart_outlined,
              iconColor: _green,
              title: 'Monitor regularly',
              description: 'Monitor oxygen levels and heart rate regularly.',
            ),
            InfoItem(
              icon: Icons.schedule_rounded,
              iconColor: _green,
              title: 'Medication routine',
              description: 'Give medications at the same time each day.',
            ),
            InfoItem(
              icon: Icons.air_rounded,
              iconColor: _green,
              title: 'Watch breathing',
              description: 'Watch for signs of fatigue or breathing difficulty.',
            ),
            InfoItem(
              icon: Icons.note_alt_outlined,
              iconColor: _green,
              title: 'Daily log',
              description: 'Keep a daily log of symptoms and vital signs.',
            ),
            InfoItem(
              icon: Icons.bedtime_outlined,
              iconColor: _green,
              title: 'Rest',
              description: 'Ensure adequate rest and avoid overexertion.',
            ),
          ],
        ),

        InfoSection(
          title: 'Infection Prevention',
          subtitle: '',
          headerBg: _green,
          items: [
            InfoItem(
              icon: Icons.soap_outlined,
              iconColor: _green,
              title: 'Hand hygiene',
              description: 'Wash hands frequently with soap and water.',
            ),
            InfoItem(
              icon: Icons.person_off_outlined,
              iconColor: _green,
              title: 'Avoid sick contacts',
              description: 'Keep child away from people who are sick.',
            ),
            InfoItem(
              icon: Icons.vaccines_outlined,
              iconColor: _green,
              title: 'Vaccinations',
              description: 'Stay up to date with vaccinations.',
            ),
            InfoItem(
              icon: Icons.cleaning_services_outlined,
              iconColor: _green,
              title: 'Disinfect surfaces',
              description: 'Clean and disinfect frequently touched surfaces.',
            ),
            InfoItem(
              icon: Icons.groups_outlined,
              iconColor: _green,
              title: 'Avoid crowds',
              description: 'Avoid crowded places during flu season.',
            ),
          ],
        ),

        InfoSection(
          title: 'Lifestyle Tips',
          subtitle: '',
          headerBg: _green,
          items: [
            InfoItem(
              icon: Icons.restaurant_outlined,
              iconColor: _green,
              title: 'Balanced diet',
              description: 'Provide a balanced, heart-healthy diet.',
            ),
            InfoItem(
              icon: Icons.directions_walk_outlined,
              iconColor: _green,
              title: 'Gentle activity',
              description:
              'Encourage gentle physical activity as approved by doctor.',
            ),
            InfoItem(
              icon: Icons.nightlight_round,
              iconColor: _green,
              title: 'Consistent sleep',
              description: 'Maintain a consistent sleep schedule.',
            ),
            InfoItem(
              icon: Icons.spa_outlined,
              iconColor: _green,
              title: 'Calm environment',
              description: 'Create a calm, stress-free environment.',
            ),
            InfoItem(
              icon: Icons.event_available_outlined,
              iconColor: _green,
              title: 'Attend appointments',
              description: 'Attend all scheduled medical appointments.',
            ),
          ],
        ),
      ],
    );
  }
}
