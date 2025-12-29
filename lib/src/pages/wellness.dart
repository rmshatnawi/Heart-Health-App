// lib/src/pages/wellness.dart
import 'dart:math';
import 'package:flutter/material.dart';

class WellnessPage extends StatefulWidget {
  const WellnessPage({super.key});

  @override
  State<WellnessPage> createState() => _WellnessPageState();
}

class _WellnessPageState extends State<WellnessPage> {
  // Frame
  static const double _frameW = 412.0;
  static const double _frameH = 917.0;
  static const double _frameRadius = 22.0;

  // User-entered current values
  int stepsToday = 0;
  int heartRate = 0; // bpm
  int caloriesBurned = 0;
  double sleepHours = 0.0;
  int activeMinutes = 0;
  int waterCups = 0;

  // User-entered goals
  int goalSteps = 10000;
  int goalCalories = 2500;
  double goalSleepHours = 8.0;
  int goalActiveMinutes = 50;
  int goalWaterCups = 8;

  // Streak (resettable)
  int streakDays = 0;

  // Static status pill (kept)
  String statusText = 'Healthy & Active';

  void _resetAll() {
    setState(() {
      stepsToday = 0;
      heartRate = 0;
      caloriesBurned = 0;
      sleepHours = 0.0;
      activeMinutes = 0;
      waterCups = 0;

      streakDays = 0;
    });
  }

  double _safeProgress(num v, num g) {
    if (g <= 0) return 0.0;
    return (v / g).clamp(0.0, 1.0).toDouble();
  }

  int _goalPercent() {
    final p1 = _safeProgress(stepsToday, goalSteps);
    final p2 = _safeProgress(activeMinutes, goalActiveMinutes);
    final p3 = _safeProgress(caloriesBurned, goalCalories);
    final p4 = _safeProgress(waterCups, goalWaterCups);
    final avg = (p1 + p2 + p3 + p4) / 4.0;
    return (avg * 100).round().clamp(0, 100);
  }

  Future<void> _openEditDialog() async {
    final stepsTodayCtrl = TextEditingController(text: stepsToday.toString());
    final heartRateCtrl = TextEditingController(text: heartRate.toString());
    final caloriesCtrl = TextEditingController(text: caloriesBurned.toString());
    final sleepCtrl = TextEditingController(text: sleepHours.toStringAsFixed(1));
    final activeCtrl = TextEditingController(text: activeMinutes.toString());
    final waterCtrl = TextEditingController(text: waterCups.toString());

    final goalStepsCtrl = TextEditingController(text: goalSteps.toString());
    final goalCaloriesCtrl = TextEditingController(text: goalCalories.toString());
    final goalSleepCtrl =
    TextEditingController(text: goalSleepHours.toStringAsFixed(1));
    final goalActiveCtrl =
    TextEditingController(text: goalActiveMinutes.toString());
    final goalWaterCtrl = TextEditingController(text: goalWaterCups.toString());

    int toInt(TextEditingController c) => int.tryParse(c.text.trim()) ?? 0;
    double toDouble(TextEditingController c) => double.tryParse(c.text.trim()) ?? 0.0;

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Your Data'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _DialogSectionTitle('Today'),
                _DialogField(label: 'Steps Today', controller: stepsTodayCtrl),
                _DialogField(label: 'Heart Rate (BPM)', controller: heartRateCtrl),
                _DialogField(label: 'Calories Burned', controller: caloriesCtrl),
                _DialogField(label: 'Sleep Hours', controller: sleepCtrl),
                _DialogField(label: 'Active Minutes', controller: activeCtrl),
                _DialogField(label: 'Water Cups', controller: waterCtrl),
                const SizedBox(height: 12),
                const _DialogSectionTitle('Goals'),
                _DialogField(label: 'Goal Steps', controller: goalStepsCtrl),
                _DialogField(label: 'Goal Calories', controller: goalCaloriesCtrl),
                _DialogField(label: 'Goal Sleep Hours', controller: goalSleepCtrl),
                _DialogField(label: 'Goal Active Minutes', controller: goalActiveCtrl),
                _DialogField(label: 'Goal Water Cups', controller: goalWaterCtrl),
                const SizedBox(height: 8),
                const Text(
                  'Streak is reset by Reset button.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7A8AA6),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  stepsToday = toInt(stepsTodayCtrl);
                  heartRate = toInt(heartRateCtrl);
                  caloriesBurned = toInt(caloriesCtrl);
                  sleepHours = toDouble(sleepCtrl);
                  activeMinutes = toInt(activeCtrl);
                  waterCups = toInt(waterCtrl);

                  goalSteps = max(0, toInt(goalStepsCtrl));
                  goalCalories = max(0, toInt(goalCaloriesCtrl));
                  goalSleepHours = max(0.0, toDouble(goalSleepCtrl));
                  goalActiveMinutes = max(0, toInt(goalActiveCtrl));
                  goalWaterCups = max(0, toInt(goalWaterCtrl));
                });
                Navigator.of(ctx).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    stepsTodayCtrl.dispose();
    heartRateCtrl.dispose();
    caloriesCtrl.dispose();
    sleepCtrl.dispose();
    activeCtrl.dispose();
    waterCtrl.dispose();

    goalStepsCtrl.dispose();
    goalCaloriesCtrl.dispose();
    goalSleepCtrl.dispose();
    goalActiveCtrl.dispose();
    goalWaterCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F2FF);
    const blue = Color(0xFF2F73FF);

    final stepsProg = _safeProgress(stepsToday, goalSteps);
    final sleepProg = _safeProgress(sleepHours, goalSleepHours);
    final calProg = _safeProgress(caloriesBurned, goalCalories);

    return Scaffold(
      backgroundColor: bg,
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
            child: SafeArea(
              child: Column(
                children: [
                  // FIX: keep header clean. Only status pill stays in header.
                  _TopHeader(
                    title: 'Outlook on Wellness',
                    subtitle: 'Wellness dashboard',
                    icon: Icons.auto_awesome_rounded,
                    headerColor: blue,
                    onBack: () => Navigator.of(context).pop(),
                    trailing: _Pill(
                      text: statusText,
                      icon: Icons.circle,
                      iconColor: const Color(0xFF23B26D),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // NEW: actions row below header, so title never wraps
                          Row(
                            children: [
                              Expanded(
                                child: _ActionTile(
                                  icon: Icons.edit_rounded,
                                  title: 'Edit Data',
                                  subtitle: 'Enter today + goals',
                                  onTap: _openEditDialog,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _ActionTile(
                                  icon: Icons.refresh_rounded,
                                  title: 'Reset',
                                  subtitle: 'Clear today + streak',
                                  onTap: _resetAll,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          _HeroCard(
                            dateText: _simpleDateString(),
                            title: 'Wellness Snapshot',
                            subtitle:
                            'This page updates from your entries.',
                            goalLabel: 'Daily Goal',
                            goalValue: '${_goalPercent()}%',
                            streakLabel: 'Streak',
                            streakValue: '$streakDays Days',
                          ),
                          const SizedBox(height: 14),

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
                                    value: _fmtInt(stepsToday),
                                    sub: 'Goal: ${_fmtInt(goalSteps)} steps',
                                    badge: '${(stepsProg * 100).round()}%',
                                    badgeBg: const Color(0xFF23B26D),
                                  ),
                                  _MetricCard(
                                    width: itemWidth,
                                    icon: Icons.favorite_rounded,
                                    iconBg: const Color(0xFFFFE8F0),
                                    iconColor: const Color(0xFFFF4D7D),
                                    title: 'Heart Rate',
                                    value: _fmtInt(heartRate),
                                    sub: 'BPM',
                                    badge: heartRate == 0 ? '—' : 'Logged',
                                    badgeBg: const Color(0xFF7A8AA6),
                                  ),
                                  _MetricCard(
                                    width: itemWidth,
                                    icon: Icons.local_fire_department_rounded,
                                    iconBg: const Color(0xFFFFEFE3),
                                    iconColor: const Color(0xFFFF8A2A),
                                    title: 'Calories',
                                    value: _fmtInt(caloriesBurned),
                                    sub: 'Goal: ${_fmtInt(goalCalories)}',
                                    badge: '${(calProg * 100).round()}%',
                                    badgeBg: const Color(0xFF23B26D),
                                  ),
                                  _MetricCard(
                                    width: itemWidth,
                                    icon: Icons.bedtime_rounded,
                                    iconBg: const Color(0xFFEAF2FF),
                                    iconColor: const Color(0xFF2F73FF),
                                    title: 'Sleep',
                                    value: _fmtHours(sleepHours),
                                    sub: 'Goal: ${_fmtHours(goalSleepHours)}',
                                    badge: '${(sleepProg * 100).round()}%',
                                    badgeBg: const Color(0xFF23B26D),
                                  ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 14),

                          // REMOVED: analysis/figures charts section

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
                                    valueTop: _fmtShortK(stepsToday),
                                    valueBottom: 'of ${_fmtShortK(goalSteps)}',
                                    progress: _safeProgress(stepsToday, goalSteps),
                                  ),
                                  _GoalRing(
                                    width: itemWidth,
                                    label: 'Active Minutes',
                                    valueTop: _fmtInt(activeMinutes),
                                    valueBottom: 'of ${_fmtInt(goalActiveMinutes)}',
                                    progress: _safeProgress(activeMinutes, goalActiveMinutes),
                                  ),
                                  _GoalRing(
                                    width: itemWidth,
                                    label: 'Calories',
                                    valueTop: _fmtInt(caloriesBurned),
                                    valueBottom: 'of ${_fmtInt(goalCalories)}',
                                    progress: _safeProgress(caloriesBurned, goalCalories),
                                  ),
                                  _GoalRing(
                                    width: itemWidth,
                                    label: 'Water Intake',
                                    valueTop: _fmtInt(waterCups),
                                    valueBottom: 'of ${_fmtInt(goalWaterCups)}',
                                    progress: _safeProgress(waterCups, goalWaterCups),
                                  ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          const _SectionHeader(
                            title: 'Wellness Tips',
                            subtitle: 'Static tips',
                          ),
                          const SizedBox(height: 10),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final tileWidth = (constraints.maxWidth - 12) / 2;
                              return Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: const [
                                  _TipCard(
                                    width: 0,
                                    icon: Icons.water_drop_rounded,
                                    title: 'Stay Hydrated',
                                    body: 'Great job focusing on hydration. Water supports energy and concentration.',
                                    tint: Color(0xFFEAF2FF),
                                    border: Color(0xFFBFD6FF),
                                    iconColor: Color(0xFF2F73FF),
                                  ),
                                  _TipCard(
                                    width: 0,
                                    icon: Icons.spa_rounded,
                                    title: 'Mindful Breathing',
                                    body: 'Take 5 minutes for deep breathing. It reduces stress and improves clarity.',
                                    tint: Color(0xFFF0E6FF),
                                    border: Color(0xFFD8C7FF),
                                    iconColor: Color(0xFF8C4DFF),
                                  ),
                                  _TipCard(
                                    width: 0,
                                    icon: Icons.restaurant_rounded,
                                    title: 'Balanced Nutrition',
                                    body: 'Aim for a colorful plate. Variety increases nutrient coverage.',
                                    tint: Color(0xFFE8FFF3),
                                    border: Color(0xFFBFEFD6),
                                    iconColor: Color(0xFF23B26D),
                                  ),
                                  _TipCard(
                                    width: 0,
                                    icon: Icons.directions_run_rounded,
                                    title: 'Move More',
                                    body: 'Short walks add up. Movement boosts mood and circulation.',
                                    tint: Color(0xFFFFF2E6),
                                    border: Color(0xFFFFD4AE),
                                    iconColor: Color(0xFFFF8A2A),
                                  ),
                                  _TipCard(
                                    width: 0,
                                    icon: Icons.bedtime_rounded,
                                    title: 'Quality Sleep',
                                    body: 'Consistent sleep hours improve recovery and focus.',
                                    tint: Color(0xFFEAF2FF),
                                    border: Color(0xFFBFD6FF),
                                    iconColor: Color(0xFF2F73FF),
                                  ),
                                  _TipCard(
                                    width: 0,
                                    icon: Icons.wb_sunny_rounded,
                                    title: 'Morning Sunlight',
                                    body: '10–15 minutes of morning light helps regulate your body clock.',
                                    tint: Color(0xFFFFF2E6),
                                    border: Color(0xFFFFD4AE),
                                    iconColor: Color(0xFFFF8A2A),
                                  ),
                                ],

                              );
                            },
                          ),

                          const SizedBox(height: 14),

                          _BigGradientCard(
                            width: double.infinity,
                            icon: Icons.monitor_heart_rounded,
                            title: 'Consistency Wins',
                            body: 'Small actions daily beat occasional big efforts.',
                            colors: const [Color(0xFF2DD36F), Color(0xFF12C2E9)],
                          ),
                          const SizedBox(height: 14),
                          _BigGradientCard(
                            width: double.infinity,
                            icon: Icons.apple_rounded,
                            title: 'Nutrition Goal',
                            body: 'Protein + fiber + hydration is a strong default.',
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
      ),
    );
  }

  String _simpleDateString() {
    final d = DateTime.now();
    final months = const [
      'January','February','March','April','May','June',
      'July','August','September','October','November','December'
    ];
    final weekdays = const [
      'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'
    ];
    final wd = weekdays[d.weekday - 1];
    final m = months[d.month - 1];
    return '$wd, $m ${d.day}, ${d.year}';
  }

  String _fmtInt(int v) => v.toString();
  String _fmtHours(double h) => '${h.toStringAsFixed(h % 1 == 0 ? 0 : 1)}h';

  String _fmtShortK(int v) {
    if (v >= 1000) {
      final k = v / 1000.0;
      final s = (k % 1 == 0) ? k.toStringAsFixed(0) : k.toStringAsFixed(1);
      return '${s}K';
    }
    return v.toString();
  }
}

class _DialogSectionTitle extends StatelessWidget {
  final String text;
  const _DialogSectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w900,
          color: Color(0xFF1B2B55),
        ),
      ),
    );
  }
}

class _DialogField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _DialogField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF7FAFF),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE1ECFF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2F73FF), width: 1.3),
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

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
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
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF2FF),
                borderRadius: BorderRadius.circular(14),
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
                      fontSize: 13.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B2B55),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7A8AA6),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF9FB0C9)),
          ],
        ),
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

  // unreadable badge fixed: solid background + WHITE text
  final String badge;
  final Color badgeBg;

  const _MetricCard({
    required this.width,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.sub,
    required this.badge,
    required this.badgeBg,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 8,
                        offset: Offset(0, 6),
                      )
                    ],
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
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
    final w = width == 0 ? (MediaQuery.of(context).size.width - 44) / 2 : width;
    return SizedBox(
      width: w,
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
