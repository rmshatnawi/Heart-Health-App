// lib/src/pages/health_info.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class HealthInfoPage extends StatelessWidget {
  const HealthInfoPage({super.key});

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
                child: const SimpleInfoPage(
                  title: 'Health Info',
                  headerIcon: Icons.info_outline,
                  gradient: [Color(0xFF7F6F9E), Color(0xFF7254A1)],
                  sections: [
                    InfoSection(
                      title: 'Nutrition Guidelines',
                      subtitle: '',
                      headerBg: Color(0xFF7C689C),
                      items: [
                        InfoItem(
                          icon: Icons.restaurant_outlined,
                          iconColor: Color(0xFF7C689C),
                          title: 'Nutrition Guidelines',
                          description:
                          '• Focus on nutrient-dense foods to support heart health and growth\n'
                              '• Smaller, more frequent meals may be easier for children with CHD\n'
                              '• Ensure adequate calorie intake — children with CHD often need more calories\n'
                              '• Limit sodium intake to reduce fluid retention and heart workload\n'
                              '• Include iron-rich foods to prevent anemia, common in CHD patients',
                        ),
                      ],
                    ),
                    InfoSection(
                      title: 'Sleep & Rest',
                      subtitle: '',
                      headerBg: Color(0xFF7C689C),
                      items: [
                        InfoItem(
                          icon: Icons.nightlight_round,
                          iconColor: Color(0xFF7C689C),
                          title: 'Sleep & Rest',
                          description:
                          '• Maintain consistent sleep schedules to support heart health\n'
                              '• Elevate head during sleep if recommended by cardiologist\n'
                              '• Watch for signs of sleep disturbance or breathing difficulties\n'
                              '• Allow adequate rest periods throughout the day\n'
                              '• Create a calm, comfortable sleep environment',
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
