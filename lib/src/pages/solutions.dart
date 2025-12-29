// lib/src/pages/solutions.dart
import 'package:flutter/material.dart';

class SolutionsPage extends StatelessWidget {
  const SolutionsPage({super.key});

  // FIX: exact frame size
  static const double _frameW = 412.0;
  static const double _frameH = 917.0;

  // FIX: rounder edges like the rest
  static const double _frameRadius = 22.0;

  @override
  Widget build(BuildContext context) {
    const bgTop = Color(0xFFD9E9FF);
    const bgBottom = Color(0xFFCFE2FF);
    const blue = Color(0xFF2F73FF);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: Center(
        child: Container(
          width: _frameW,
          height: _frameH,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_frameRadius),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 18,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_frameRadius),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [bgTop, bgBottom],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    _TopHeader(
                      title: 'Medical Solutions',
                      subtitle: 'General guidance',
                      icon: Icons.medical_information_outlined,
                      color: blue,
                      onBack: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your comprehensive guide to common health issues and their solutions',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF5A6D8A),
                              ),
                            ),
                            const SizedBox(height: 14),
                            _InfoBanner(
                              title: 'Important Information',
                              message:
                              'These solutions are general guidelines and are not a substitute for professional medical consultation.\n'
                                  'If symptoms persist or worsen, consult a doctor immediately.',
                              icon: Icons.info_outline_rounded,
                            ),
                            const SizedBox(height: 16),

                            // Keep it 1-column on phone, 2-column only on wide screens
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final isWide = constraints.maxWidth >= 700;
                                return Wrap(
                                  spacing: 16,
                                  runSpacing: 16,
                                  children: [
                                    _SolutionCard(
                                      width: isWide
                                          ? (constraints.maxWidth - 16) / 2
                                          : constraints.maxWidth,
                                      title: 'Insomnia and Sleep Difficulty',
                                      severity: 'Medium',
                                      severityColor: const Color(0xFFFFDDA8),
                                      icon: Icons.nights_stay_outlined,
                                      iconBg: const Color(0xFFFFF2D9),
                                      symptoms: const [
                                        'Difficulty falling asleep',
                                        'Frequent waking during the night',
                                        'Daytime fatigue',
                                      ],
                                      solutions: const [
                                        'Maintain a regular sleep schedule',
                                        'Avoid caffeine after 2 PM',
                                        'Turn off screens before bedtime',
                                        'Exercise in the morning or afternoon',
                                        'Create a dark and quiet sleep environment',
                                      ],
                                    ),
                                    _SolutionCard(
                                      width: isWide
                                          ? (constraints.maxWidth - 16) / 2
                                          : constraints.maxWidth,
                                      title: 'Recurrent Headaches',
                                      severity: 'Low',
                                      severityColor: const Color(0xFFCFF7DC),
                                      icon: Icons.favorite_border_rounded,
                                      iconBg: const Color(0xFFE9FFF1),
                                      symptoms: const [
                                        'Head pain',
                                        'Sensitivity to light',
                                        'General fatigue',
                                      ],
                                      solutions: const [
                                        'Drink enough water (8–10 cups daily)',
                                        'Get sufficient sleep (7–8 hours)',
                                        'Avoid stress and overexertion',
                                        'Practice relaxation and meditation',
                                        'Consult a doctor if headaches persist',
                                      ],
                                    ),
                                    _SolutionCard(
                                      width: isWide
                                          ? (constraints.maxWidth - 16) / 2
                                          : constraints.maxWidth,
                                      title: 'Dehydration and Low Fluid Intake',
                                      severity: 'Low',
                                      severityColor: const Color(0xFFCFF7DC),
                                      icon: Icons.water_drop_outlined,
                                      iconBg: const Color(0xFFEAF2FF),
                                      symptoms: const [
                                        'Dry mouth',
                                        'Reduced urination',
                                        'Mild dizziness',
                                      ],
                                      solutions: const [
                                        'Drink 8–10 cups of water daily',
                                        'Eat fruits and vegetables rich in water',
                                        'Avoid sugary and carbonated drinks',
                                        'Increase fluid intake during exercise',
                                        'Monitor urine color (should be light)',
                                      ],
                                    ),
                                    _SolutionCard(
                                      width: isWide
                                          ? (constraints.maxWidth - 16) / 2
                                          : constraints.maxWidth,
                                      title: 'Muscle and Joint Pain',
                                      severity: 'Medium',
                                      severityColor: const Color(0xFFFFDDA8),
                                      icon: Icons.monitor_heart_outlined,
                                      iconBg: const Color(0xFFFFF2D9),
                                      symptoms: const [
                                        'Pain during movement',
                                        'Morning stiffness',
                                        'Mild swelling',
                                      ],
                                      solutions: const [
                                        'Warm up before physical activity',
                                        'Apply warm or cold compresses',
                                        'Perform stretching exercises regularly',
                                        'Maintain a healthy weight',
                                        'Consult a physical therapist if needed',
                                      ],
                                    ),
                                    _SolutionCard(
                                      width: isWide
                                          ? (constraints.maxWidth - 16) / 2
                                          : constraints.maxWidth,
                                      title: 'Digestive Problems',
                                      severity: 'Low',
                                      severityColor: const Color(0xFFCFF7DC),
                                      icon: Icons.menu_book_outlined,
                                      iconBg: const Color(0xFFEAF2FF),
                                      symptoms: const [
                                        'Bloating',
                                        'Gas',
                                        'Indigestion',
                                      ],
                                      solutions: const [
                                        'Eat slowly and chew well',
                                        'Avoid fatty and spicy foods',
                                        'Drink water between meals, not during',
                                        'Increase dietary fiber intake',
                                        'Walk after meals',
                                      ],
                                    ),
                                    _SolutionCard(
                                      width: isWide
                                          ? (constraints.maxWidth - 16) / 2
                                          : constraints.maxWidth,
                                      title: 'Weak Immunity and Frequent Illness',
                                      severity: 'Medium',
                                      severityColor: const Color(0xFFFFDDA8),
                                      icon: Icons.shield_outlined,
                                      iconBg: const Color(0xFFFFF2D9),
                                      symptoms: const [
                                        'Frequent colds',
                                        'Persistent fatigue',
                                        'Slow recovery',
                                      ],
                                      solutions: const [
                                        'Eat a balanced diet rich in vitamins',
                                        'Get enough sleep',
                                        'Exercise regularly',
                                        'Reduce stress and anxiety',
                                        'Take vitamin D and C supplements after consulting a doctor',
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 18),
                          ],
                        ),
                      ),
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

class _TopHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onBack;

  const _TopHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xE6FFFFFF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const _InfoBanner({
    required this.title,
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 245),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EEFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFF2F73FF)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1B2B55),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A6D8A),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.check_circle_outline_rounded,
              color: Color(0xFF2F73FF)),
        ],
      ),
    );
  }
}

class _SolutionCard extends StatelessWidget {
  final double width;
  final String title;
  final String severity;
  final Color severityColor;
  final IconData icon;
  final Color iconBg;
  final List<String> symptoms;
  final List<String> solutions;

  const _SolutionCard({
    required this.width,
    required this.title,
    required this.severity,
    required this.severityColor,
    required this.icon,
    required this.iconBg,
    required this.symptoms,
    required this.solutions,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 245),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE6EEFF)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 14,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B2B55),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: severityColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          'Severity Level: $severity',
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1B2B55),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: const Color(0xFF2F73FF)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFE6EEFF), height: 18),
            Row(
              children: const [
                Icon(Icons.error_outline_rounded,
                    size: 18, color: Color(0xFFEE7A4A)),
                SizedBox(width: 8),
                Text(
                  'Common Symptoms:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1B2B55),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...symptoms.map((s) => _Bullet(text: s)),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.check_circle_outline_rounded,
                    size: 18, color: Color(0xFF2AAE84)),
                SizedBox(width: 8),
                Text(
                  'Recommended Solutions:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1B2B55),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...solutions.map((s) => _CheckItem(text: s)),
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: SizedBox(
              width: 6,
              height: 6,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFF1B2B55),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334C74),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  final String text;
  const _CheckItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded,
              size: 18, color: Color(0xFF2AAE84)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334C74),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
