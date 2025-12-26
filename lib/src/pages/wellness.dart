// lib/src/pages/wellness.dart
import 'dart:math';
import 'package:flutter/material.dart';

class WellnessPage extends StatelessWidget {
  const WellnessPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F2FF);
    const blue = Color(0xFF2F73FF);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430), // phone-fit
            child: Column(
              children: [
                _TopHeader(
                  title: 'Outlook on Wellness',
                  subtitle: 'Wellness dashboard',
                  icon: Icons.auto_awesome_rounded,
                  headerColor: blue, // header background = icon theme (blue)
                  onBack: () => Navigator.of(context).pop(),
                  trailing: const _Pill(
                    text: 'Healthy & Active',
                    icon: Icons.circle,
                    iconColor: Color(0xFF23B26D),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeroCard(
                          dateText: 'Friday, December 19, 2025',
                          title: 'Great Day for Wellness!',
                          subtitle:
                          "You're on track with your health goals. Keep up the amazing work!",
                          goalLabel: 'Daily Goal',
                          goalValue: '84%',
                          streakLabel: 'Streak',
                          streakValue: '7 Days',
                        ),
                        const SizedBox(height: 14),

                        // Summary mini cards row (phone: 2 columns)
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final itemWidth = (constraints.maxWidth - 12) / 2;
                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _MetricCard(
                                  width: itemWidth,
                                  icon: Icons.directions_walk_rounded,
                                  iconBg: const Color(0xFFEFE9FF),
                                  iconColor: const Color(0xFF7B61FF),
                                  title: 'Steps Today',
                                  value: '8,547',
                                  sub: 'Goal: 10,000 steps',
                                  badge: '+12%',
                                  badgeColor: const Color(0xFF23B26D),
                                ),
                                _MetricCard(
                                  width: itemWidth,
                                  icon: Icons.favorite_rounded,
                                  iconBg: const Color(0xFFFFE8F0),
                                  iconColor: const Color(0xFFFF4D7D),
                                  title: 'Heart Rate',
                                  value: '72',
                                  sub: 'BPM • Normal',
                                  badge: 'Stable',
                                  badgeColor: const Color(0xFF7A8AA6),
                                ),
                                _MetricCard(
                                  width: itemWidth,
                                  icon: Icons.local_fire_department_rounded,
                                  iconBg: const Color(0xFFFFEFE3),
                                  iconColor: const Color(0xFFFF8A2A),
                                  title: 'Calories',
                                  value: '1,847',
                                  sub: 'Burned today',
                                  badge: '+8%',
                                  badgeColor: const Color(0xFF23B26D),
                                ),
                                _MetricCard(
                                  width: itemWidth,
                                  icon: Icons.bedtime_rounded,
                                  iconBg: const Color(0xFFEAF2FF),
                                  iconColor: const Color(0xFF2F73FF),
                                  title: 'Sleep',
                                  value: '7.5h',
                                  sub: 'Last night',
                                  badge: '+15 min',
                                  badgeColor: const Color(0xFF23B26D),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 14),

                        // Charts (static UI) - phone: stacked
                        const _ChartCard(
                          title: 'Weekly Activity',
                          subtitle: 'Your steps and calories burned this week',
                          type: _ChartType.area,
                        ),
                        const SizedBox(height: 14),
                        const _ChartCard(
                          title: 'Heart Rate Trend',
                          subtitle: "Today's heart rate monitoring",
                          type: _ChartType.line,
                        ),

                        const SizedBox(height: 14),

                        // Goals ring row (phone: 2 columns)
                        const _SectionHeader(title: "Today's Goals"),
                        const SizedBox(height: 10),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final itemWidth = (constraints.maxWidth - 12) / 2;
                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _GoalRing(
                                  width: itemWidth,
                                  label: 'Steps',
                                  valueTop: '8.5K',
                                  valueBottom: 'of 10K',
                                  progress: 0.85,
                                ),
                                _GoalRing(
                                  width: itemWidth,
                                  label: 'Active Minutes',
                                  valueTop: '46',
                                  valueBottom: 'of 50',
                                  progress: 0.92,
                                ),
                                _GoalRing(
                                  width: itemWidth,
                                  label: 'Calories',
                                  valueTop: '1847',
                                  valueBottom: 'of 2500',
                                  progress: 0.74,
                                ),
                                _GoalRing(
                                  width: itemWidth,
                                  label: 'Water Intake',
                                  valueTop: '8',
                                  valueBottom: 'of 8',
                                  progress: 1.0,
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Tips grid (phone: 2 columns)
                        const _SectionHeader(
                          title: 'Wellness Tips',
                          subtitle:
                          'Personalized recommendations for your health journey',
                        ),
                        const SizedBox(height: 10),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final tileWidth = (constraints.maxWidth - 12) / 2;
                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _TipCard(
                                  width: tileWidth,
                                  icon: Icons.water_drop_rounded,
                                  title: 'Stay Hydrated',
                                  body:
                                  "Great job! You've reached your water intake goal for today. Hydration is key to maintaining energy and focus throughout the day.",
                                  tint: const Color(0xFFEAF2FF),
                                  border: const Color(0xFFBFD6FF),
                                  iconColor: const Color(0xFF2F73FF),
                                ),
                                _TipCard(
                                  width: tileWidth,
                                  icon: Icons.spa_rounded,
                                  title: 'Mindful Breathing',
                                  body:
                                  "Take 5 minutes for deep breathing exercises. It helps reduce stress and improves mental clarity and overall well-being.",
                                  tint: const Color(0xFFF0E6FF),
                                  border: const Color(0xFFD8C7FF),
                                  iconColor: const Color(0xFF8C4DFF),
                                ),
                                _TipCard(
                                  width: tileWidth,
                                  icon: Icons.restaurant_rounded,
                                  title: 'Balanced Nutrition',
                                  body:
                                  "Include colorful fruits and vegetables in your meals. A rainbow plate ensures you're getting diverse nutrients and vitamins.",
                                  tint: const Color(0xFFE8FFF3),
                                  border: const Color(0xFFBFEFD6),
                                  iconColor: const Color(0xFF23B26D),
                                ),
                                _TipCard(
                                  width: tileWidth,
                                  icon: Icons.directions_run_rounded,
                                  title: 'Move More',
                                  body:
                                  "You're close to your step goal! A short evening walk can help you reach it while enjoying fresh air and nature.",
                                  tint: const Color(0xFFFFF2E6),
                                  border: const Color(0xFFFFD4AE),
                                  iconColor: const Color(0xFFFF8A2A),
                                ),
                                _TipCard(
                                  width: tileWidth,
                                  icon: Icons.bedtime_rounded,
                                  title: 'Quality Sleep',
                                  body:
                                  "Aim for 7–9 hours of sleep tonight. Good sleep is essential for recovery, mental health, and overall wellness.",
                                  tint: const Color(0xFFEAF2FF),
                                  border: const Color(0xFFBFD6FF),
                                  iconColor: const Color(0xFF2F73FF),
                                ),
                                _TipCard(
                                  width: tileWidth,
                                  icon: Icons.wb_sunny_rounded,
                                  title: 'Morning Sunlight',
                                  body:
                                  "Get 10–15 minutes of morning sunlight. It helps regulate your circadian rhythm and boosts vitamin D levels naturally.",
                                  tint: const Color(0xFFFFF2E6),
                                  border: const Color(0xFFFFD4AE),
                                  iconColor: const Color(0xFFFF8A2A),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 14),

                        // Big gradient cards (phone: stacked)
                        _BigGradientCard(
                          width: double.infinity,
                          icon: Icons.monitor_heart_rounded,
                          title: '7-Day Streak!',
                          body:
                          "You've been consistently active for a whole week. This is amazing progress toward building lasting healthy habits!",
                          colors: const [Color(0xFF2DD36F), Color(0xFF12C2E9)],
                        ),
                        const SizedBox(height: 14),
                        _BigGradientCard(
                          width: double.infinity,
                          icon: Icons.apple_rounded,
                          title: 'Nutrition Goal',
                          body:
                          "You're maintaining a balanced diet with plenty of fruits and vegetables. Your body thanks you for the nutrients!",
                          colors: const [Color(0xFFFF8A2A), Color(0xFFFF4D7D)],
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
    );
  }
}

class _TopHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color headerColor;
  final VoidCallback onBack;
  final Widget trailing;

  const _TopHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.headerColor,
    required this.onBack,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: headerColor,
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
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // left aligned
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
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xE6FFFFFF),
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;

  const _Pill({
    required this.text,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 210),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE6EEFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: iconColor),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2A3B5F),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String dateText;
  final String title;
  final String subtitle;
  final String goalLabel;
  final String goalValue;
  final String streakLabel;
  final String streakValue;

  const _HeroCard({
    required this.dateText,
    required this.title,
    required this.subtitle,
    required this.goalLabel,
    required this.goalValue,
    required this.streakLabel,
    required this.streakValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF8C4DFF), Color(0xFFFF4D7D), Color(0xFFFF8A2A)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 18,
            offset: Offset(0, 12),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.wb_sunny_rounded,
                        size: 16, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      dateText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF4F6FF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF6F2FF),
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    _HeroMiniPill(
                      label: goalLabel,
                      value: goalValue,
                      icon: Icons.flag_rounded,
                    ),
                    _HeroMiniPill(
                      label: streakLabel,
                      value: streakValue,
                      icon: Icons.local_fire_department_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMiniPill extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _HeroMiniPill({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 40),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 70)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFF6F2FF),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String value;
  final String sub;
  final String badge;
  final Color badgeColor;

  const _MetricCard({
    required this.width,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.sub,
    required this.badge,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 235),
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
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const Spacer(),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 28),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: badgeColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7A8AA6),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1B2B55),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sub,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF7A8AA6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SectionHeader({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7A8AA6),
            ),
          ),
        ]
      ],
    );
  }
}

enum _ChartType { area, line }

class _ChartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final _ChartType type;

  const _ChartCard({
    required this.title,
    required this.subtitle,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 235),
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1B2B55),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF7A8AA6),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _FakeChartPainter(type: type),
              child: const SizedBox.expand(),
            ),
          ),
          if (type == _ChartType.line) ...[
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SmallStat(label: 'Resting', value: '62 BPM'),
                _SmallStat(label: 'Average', value: '72 BPM'),
                _SmallStat(label: 'Peak', value: '82 BPM'),
              ],
            ),
          ] else ...[
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendDot(color: Color(0xFF7B61FF), label: 'Steps'),
                SizedBox(width: 18),
                _LegendDot(color: Color(0xFFFF4D7D), label: 'Calories'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SmallStat extends StatelessWidget {
  final String label;
  final String value;

  const _SmallStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF7A8AA6),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1B2B55),
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF7A8AA6),
          ),
        ),
      ],
    );
  }
}

class _FakeChartPainter extends CustomPainter {
  final _ChartType type;

  _FakeChartPainter({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFEAF0FF)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (int i = 0; i <= 6; i++) {
      final x = size.width * (i / 6);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    if (type == _ChartType.area) {
      final purple = Paint()
        ..color = const Color(0xFF7B61FF).withValues(alpha: 75)
        ..style = PaintingStyle.fill;

      final purpleLine = Paint()
        ..color = const Color(0xFF7B61FF)
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke;

      final p = Path();
      p.moveTo(0, size.height * 0.70);
      p.cubicTo(size.width * 0.20, size.height * 0.45, size.width * 0.35,
          size.height * 0.55, size.width * 0.50, size.height * 0.45);
      p.cubicTo(size.width * 0.65, size.height * 0.35, size.width * 0.78,
          size.height * 0.55, size.width, size.height * 0.40);
      final fill = Path.from(p)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
      canvas.drawPath(fill, purple);
      canvas.drawPath(p, purpleLine);

      final pinkLine = Paint()
        ..color = const Color(0xFFFF4D7D)
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      final p2 = Path();
      p2.moveTo(0, size.height * 0.92);
      p2.cubicTo(size.width * 0.25, size.height * 0.88, size.width * 0.45,
          size.height * 0.93, size.width * 0.60, size.height * 0.90);
      p2.cubicTo(size.width * 0.80, size.height * 0.86, size.width * 0.90,
          size.height * 0.94, size.width, size.height * 0.92);
      canvas.drawPath(p2, pinkLine);
    } else {
      final line = Paint()
        ..color = const Color(0xFFFF4D7D)
        ..strokeWidth = 2.6
        ..style = PaintingStyle.stroke;

      final path = Path();
      path.moveTo(0, size.height * 0.65);
      path.lineTo(size.width * 0.15, size.height * 0.55);
      path.lineTo(size.width * 0.30, size.height * 0.42);
      path.lineTo(size.width * 0.45, size.height * 0.48);
      path.lineTo(size.width * 0.60, size.height * 0.35);
      path.lineTo(size.width * 0.75, size.height * 0.25);
      path.lineTo(size.width * 0.88, size.height * 0.40);
      path.lineTo(size.width, size.height * 0.55);
      canvas.drawPath(path, line);

      final dotPaint = Paint()..color = const Color(0xFFFF4D7D);
      for (final p in [
        Offset(0, size.height * 0.65),
        Offset(size.width * 0.15, size.height * 0.55),
        Offset(size.width * 0.30, size.height * 0.42),
        Offset(size.width * 0.45, size.height * 0.48),
        Offset(size.width * 0.60, size.height * 0.35),
        Offset(size.width * 0.75, size.height * 0.25),
        Offset(size.width * 0.88, size.height * 0.40),
        Offset(size.width, size.height * 0.55),
      ]) {
        canvas.drawCircle(p, 3.2, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _FakeChartPainter oldDelegate) =>
      oldDelegate.type != type;
}

class _GoalRing extends StatelessWidget {
  final double width;
  final String label;
  final String valueTop;
  final String valueBottom;
  final double progress;

  const _GoalRing({
    required this.width,
    required this.label,
    required this.valueTop,
    required this.valueBottom,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 235),
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
          children: [
            SizedBox(
              width: 78,
              height: 78,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    strokeWidth: 8,
                    backgroundColor: const Color(0xFFEAF0FF),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        valueTop,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B2B55),
                        ),
                      ),
                      Text(
                        valueBottom,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF7A8AA6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1B2B55),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String title;
  final String body;
  final Color tint;
  final Color border;
  final Color iconColor;

  const _TipCard({
    required this.width,
    required this.icon,
    required this.title,
    required this.body,
    required this.tint,
    required this.border,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 210),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1B2B55),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6D8A),
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BigGradientCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String title;
  final String body;
  final List<Color> colors;

  const _BigGradientCard({
    required this.width,
    required this.icon,
    required this.title,
    required this.body,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: colors,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 18,
              offset: Offset(0, 12),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 35),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 60)),
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
                      fontSize: 14.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF6F2FF),
                      height: 1.25,
                    ),
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
