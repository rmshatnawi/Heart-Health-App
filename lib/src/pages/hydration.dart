// lib/src/pages/hydration.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class HydrationPage extends StatelessWidget {
  const HydrationPage({super.key});

  static const double _phoneWidth = 412.0;
  static const double _phoneHeight = 917.0;

  static const _blue = Color(0xFF2D7CFF);
  static const _teal = Color(0xFF21899C);

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
                child: const SimpleInfoPage(
                  title: 'Hydration',
                  headerIcon: Icons.water_drop_outlined,
                  gradient: [Color(0xFF2D7CFF), Color(0xFF1F66F2)],
                  sections: [
                    InfoSection(
                      title: 'Why Hydration Matters',
                      subtitle:
                      'Proper hydration is essential for children with Congenital Heart Disease (CHD).',
                      headerBg: Color(0xFF3173EC),
                      items: [
                        InfoItem(
                          icon: Icons.favorite_border,
                          iconColor: _blue,
                          title: 'Hydration supports the heart',
                          description:
                          'The heart works harder when the body is dehydrated, which can add strain on your child’s cardiovascular system.',
                        ),
                        InfoItem(
                          icon: Icons.water_drop_outlined,
                          iconColor: _blue,
                          title: 'Better circulation',
                          description:
                          'Maintaining good hydration helps blood flow smoothly and supports healthy circulation.',
                        ),
                        InfoItem(
                          icon: Icons.thermostat_outlined,
                          iconColor: _blue,
                          title: 'Temperature regulation',
                          description:
                          'Hydration helps regulate body temperature and supports overall body function.',
                        ),
                      ],
                    ),
                    InfoSection(
                      title: 'Fluid Intake Tips',
                      subtitle:
                      'Simple ways to help your child drink enough fluids.',
                      headerBg: Color(0xFF17423D),
                      items: [
                        InfoItem(
                          icon: Icons.local_drink_outlined,
                          iconColor: _teal,
                          title: 'Small sips, often',
                          description:
                          'Offer small, frequent sips throughout the day rather than large amounts at once.',
                        ),
                        InfoItem(
                          icon: Icons.visibility_outlined,
                          iconColor: _teal,
                          title: 'Keep water visible',
                          description:
                          'Keep a water bottle easily accessible and within sight to encourage drinking.',
                        ),
                        InfoItem(
                          icon: Icons.color_lens_outlined,
                          iconColor: _teal,
                          title: 'Make it fun',
                          description:
                          'Use colorful cups or straws to make drinking more engaging.',
                        ),
                        InfoItem(
                          icon: Icons.checklist_rounded,
                          iconColor: _teal,
                          title: 'Track intake',
                          description:
                          'Track daily intake using a simple chart or an app to build consistency.',
                        ),
                        InfoItem(
                          icon: Icons.apple_outlined,
                          iconColor: _teal,
                          title: 'Hydrating foods',
                          description:
                          'Offer hydrating foods like watermelon, cucumbers, and oranges.',
                        ),
                      ],
                    ),
                    InfoSection(
                      title: 'Important Warnings',
                      subtitle: 'Follow your care team’s guidance closely.',
                      headerBg: Color(0xFF8A6A12),
                      items: [
                        InfoItem(
                          icon: Icons.warning_amber_rounded,
                          iconColor: Color(0xFF8A6A12),
                          title: 'Follow the cardiologist’s plan',
                          description:
                          'Always follow your cardiologist’s specific fluid intake recommendations.',
                        ),
                        InfoItem(
                          icon: Icons.block_outlined,
                          iconColor: Color(0xFF8A6A12),
                          title: 'Fluid restrictions',
                          description:
                          'Some CHD conditions require fluid restrictions — never exceed prescribed limits.',
                        ),
                        InfoItem(
                          icon: Icons.local_cafe_outlined,
                          iconColor: Color(0xFF8A6A12),
                          title: 'Limit caffeine',
                          description:
                          'Limit caffeine-containing beverages (if applicable) as advised by your care team.',
                        ),
                        InfoItem(
                          icon: Icons.medication_outlined,
                          iconColor: Color(0xFF8A6A12),
                          title: 'Diuretics caution',
                          description:
                          'Monitor fluid balance carefully if your child takes diuretics.',
                        ),
                      ],
                    ),
                    InfoSection(
                      title: 'Signs of Dehydration',
                      subtitle: 'Watch for these signs and act early.',
                      headerBg: Color(0xFF8A1D3D),
                      items: [
                        InfoItem(
                          icon: Icons.sick_outlined,
                          iconColor: Color(0xFF8A1D3D),
                          title: 'Dry mouth / lips',
                          description: 'Dry mouth, lips, or tongue.',
                        ),
                        InfoItem(
                          icon: Icons.bathroom_outlined,
                          iconColor: Color(0xFF8A1D3D),
                          title: 'Less urination',
                          description:
                          'Decreased urination or dark-colored urine.',
                        ),
                        InfoItem(
                          icon: Icons.child_care_outlined,
                          iconColor: Color(0xFF8A1D3D),
                          title: 'No tears',
                          description: 'No tears when crying.',
                        ),
                        InfoItem(
                          icon: Icons.remove_red_eye_outlined,
                          iconColor: Color(0xFF8A1D3D),
                          title: 'Sunken eyes',
                          description: 'Sunken eyes or soft spot (in infants).',
                        ),
                        InfoItem(
                          icon: Icons.bedtime_outlined,
                          iconColor: Color(0xFF8A1D3D),
                          title: 'Fatigue',
                          description: 'Unusual fatigue or lethargy.',
                        ),
                        InfoItem(
                          icon: Icons.monitor_heart_outlined,
                          iconColor: Color(0xFF8A1D3D),
                          title: 'Breathing / heart rate',
                          description:
                          'Rapid breathing or increased heart rate.',
                        ),
                        InfoItem(
                          icon: Icons.health_and_safety_outlined,
                          iconColor: Color(0xFF8A1D3D),
                          title: 'Action required',
                          description:
                          'If you notice these signs, contact your healthcare provider immediately.',
                        ),
                      ],
                    ),
                    InfoSection(
                      title: 'Note',
                      subtitle: 'Educational use only',
                      headerBg: Color(0xFF1087E8),
                      items: [
                        InfoItem(
                          icon: Icons.info_outline,
                          iconColor: _blue,
                          title: 'Always confirm with your doctor',
                          description:
                          'This information is for educational purposes only. Always consult your child’s healthcare team for personalized advice.',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
