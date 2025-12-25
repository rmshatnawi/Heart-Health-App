// lib/src/pages/lab_tests.dart
import 'package:flutter/material.dart';
import '_simple_info_page.dart';

class LabTestsPage extends StatelessWidget {
  const LabTestsPage({super.key});

  // app theme accent for icons inside content
  static const _accent = Color(0xFF21899C);

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Lab Tests',
      headerIcon: Icons.assignment_outlined,
      gradient: [Color(0xFF3EA0B1), Color(0xFF21899C)],
      sections: [
        InfoSection(
          title: 'Blood Tests',
          subtitle: 'Common lab checks used to monitor heart and overall health.',
          headerBg: Color(0xFF21899C),
          items: [
            InfoItem(
              icon: Icons.bloodtype_outlined,
              iconColor: _accent,
              title: 'Complete Blood Count (CBC)',
              description:
              'Measures red blood cells, white blood cells, and platelets to check for anemia or infection.',
            ),
            InfoItem(
              icon: Icons.monitor_heart_outlined,
              iconColor: _accent,
              title: 'Oxygen Saturation (O2 Sat)',
              description:
              'Measures the amount of oxygen in the blood to assess heart and lung function.',
            ),
            InfoItem(
              icon: Icons.favorite_outline,
              iconColor: _accent,
              title: 'BNP (Brain Natriuretic Peptide)',
              description:
              'Helps evaluate heart failure and monitor how well the heart is pumping.',
            ),
            InfoItem(
              icon: Icons.science_outlined,
              iconColor: _accent,
              title: 'Electrolytes',
              description:
              'Checks sodium, potassium, and other minerals that affect heart rhythm and function.',
            ),
            InfoItem(
              icon: Icons.health_and_safety_outlined,
              iconColor: _accent,
              title: 'Liver & Kidney Function',
              description:
              'Monitors organ health, especially important when taking heart medications.',
            ),
          ],
        ),

        InfoSection(
          title: 'Imaging Tests',
          subtitle: 'Tests that create images of the heart and chest.',
          headerBg: Color(0xFF21899C),
          items: [
            InfoItem(
              icon: Icons.waves_outlined,
              iconColor: _accent,
              title: 'Echocardiogram (Echo)',
              description:
              'Uses sound waves to create images of the heart structure and blood flow.',
            ),
            InfoItem(
              icon: Icons.image_outlined,
              iconColor: _accent,
              title: 'Chest X-Ray',
              description:
              'Shows the size and shape of the heart and checks for fluid in the lungs.',
            ),
            InfoItem(
              icon: Icons.view_in_ar_outlined,
              iconColor: _accent,
              title: 'Cardiac MRI',
              description:
              'Provides detailed 3D images of heart structure and function.',
            ),
            InfoItem(
              icon: Icons.center_focus_strong_outlined,
              iconColor: _accent,
              title: 'Cardiac CT Scan',
              description:
              'Creates detailed images of blood vessels and heart anatomy.',
            ),
            InfoItem(
              icon: Icons.medical_services_outlined,
              iconColor: _accent,
              title: 'Cardiac Catheterization',
              description:
              'Uses a thin tube to measure pressures and oxygen levels inside the heart.',
            ),
          ],
        ),

        InfoSection(
          title: 'Monitoring Tests',
          subtitle: 'Ongoing checks for rhythm, oxygen, and blood pressure.',
          headerBg: Color(0xFF21899C),
          items: [
            InfoItem(
              icon: Icons.electrical_services_outlined,
              iconColor: _accent,
              title: 'Electrocardiogram (ECG/EKG)',
              description:
              'Records the electrical activity of the heart to detect rhythm problems.',
            ),
            InfoItem(
              icon: Icons.watch_outlined,
              iconColor: _accent,
              title: 'Holter Monitor',
              description:
              '24–48 hour recording of heart rhythm during normal daily activities.',
            ),
            InfoItem(
              icon: Icons.sensors_outlined,
              iconColor: _accent,
              title: 'Pulse Oximetry',
              description:
              'Non-invasive test that measures oxygen levels in the blood continuously.',
            ),
            InfoItem(
              icon: Icons.directions_run_outlined,
              iconColor: _accent,
              title: 'Exercise Stress Test',
              description:
              'Evaluates how the heart performs during physical activity.',
            ),
            InfoItem(
              icon: Icons.speed_outlined,
              iconColor: _accent,
              title: 'Blood Pressure Monitoring',
              description:
              'Regular checks to ensure blood pressure is within safe ranges.',
            ),
          ],
        ),

        // Note box (modeled as a final section)
        InfoSection(
          title: 'Note',
          subtitle: 'Important reminder',
          headerBg: Color(0xFF21899C),
          items: [
            InfoItem(
              icon: Icons.info_outline,
              iconColor: _accent,
              title: 'Talk to your healthcare team',
              description:
              "Your healthcare team will determine which tests are needed based on your child's specific condition. Always discuss test results and their meaning with your doctor.",
            ),
          ],
        ),
      ],
    );
  }
}
