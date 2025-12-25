// lib/src/pages/health_info.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class HealthInfoPage extends StatelessWidget {
  const HealthInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
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
    );
  }
}
