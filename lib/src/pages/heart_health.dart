import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class HeartHealthPage extends StatelessWidget {
  const HeartHealthPage({super.key});

  static const _blue = Color(0xFF2F73FF);
  static const _green = Color(0xFF1DBA6F);
  static const _lightGreen = Color(0xFFEAF8F1);

  @override
  Widget build(BuildContext context) {
    return SimpleInfoPage(
      title: 'Heart Health',
      headerIcon: Icons.favorite_border,
      gradient: const [Color(0xFF7393E3), Color(0xFF5F7FE0)],
      sections: const [
        /// HOW YOUR HEART WORKS
        InfoSection(
          title: 'How Your Heart Works',
          subtitle: 'Simple explanation',
          headerBg: Color(0xFF5F7FE0),
          items: [
            InfoItem(
              icon: Icons.favorite,
              iconColor: _blue,
              title: 'How it works',
              description:
              'Your heart is a powerful muscle that pumps blood through your body. '
                  'It has four chambers working together to deliver oxygen and nutrients.',
            ),
            InfoItem(
              icon: Icons.sync,
              iconColor: _blue,
              title: 'Daily work',
              description:
              'Your heart beats about 100,000 times each day, pumping nearly 2,000 gallons of blood.',
            ),
          ],
        ),

        /// TIPS FOR A HEALTHY HEART
        InfoSection(
          title: 'Tips for a Healthy Heart',
          subtitle: 'Daily habits',
          headerBg: Color(0xFF56B68C),
          items: [
            InfoItem(
              icon: Icons.looks_one_rounded,
              iconColor: _green,
              title: 'Stay Active',
              description:
              'Play, swim, dance, or bike! Aim for at least 60 minutes of fun activity daily.',
            ),
            InfoItem(
              icon: Icons.looks_two_rounded,
              iconColor: _green,
              title: 'Eat Healthy Foods',
              description:
              'Eat fruits, vegetables, whole grains, and lean proteins to keep your heart strong.',
            ),
            InfoItem(
              icon: Icons.looks_3_rounded,
              iconColor: _green,
              title: 'Get Enough Sleep',
              description:
              'Children need 9–12 hours of sleep. Sleep helps your heart rest and repair.',
            ),
            InfoItem(
              icon: Icons.looks_4_rounded,
              iconColor: _green,
              title: 'Take Your Medicine',
              description:
              'If prescribed, take your medicine exactly as your doctor advises.',
            ),
            InfoItem(
              icon: Icons.looks_5_rounded,
              iconColor: _green,
              title: 'Regular Check-ups',
              description:
              'Visit your heart doctor regularly to keep your heart healthy.',
            ),
            InfoItem(
              icon: Icons.looks_6_rounded,
              iconColor: _green,
              title: 'Manage Stress',
              description:
              'Relax with breathing, reading, drawing, or talking with family.',
            ),
          ],
        ),

        /// REMINDER
        InfoSection(
          title: 'Remember',
          subtitle: '',
          headerBg: _blue,
          items: [
            InfoItem(
              icon: Icons.favorite,
              iconColor: Colors.white,
              title: 'You are strong',
              description:
              'Your heart is special and strong. With good care and healthy habits, '
                  'you help it work its best every day.',
            ),
          ],
        ),
      ],
    );
  }
}
