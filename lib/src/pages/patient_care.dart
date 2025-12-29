// lib/src/pages/patient_care.dart
import 'package:flutter/material.dart';

import 'settings.dart';
import 'profile.dart';
import 'privacy.dart';

class PatientCarePage extends StatefulWidget {
  const PatientCarePage({super.key});

  @override
  State<PatientCarePage> createState() => _PatientCarePageState();
}

class _PatientCarePageState extends State<PatientCarePage> {
  // Frame spec (412x917) + rounder edges like other pages
  static const double _frameW = 412;
  static const double _frameH = 917;
  static const double _frameRadius = 28;

  // RESET: no default plans/stats. Keep UI, but data starts empty/zero.
  final List<_CarePlanData> _plans = [];
  final List<_ReminderItem> _reminders = [];

  // For Schedule Appointment -> list of doctor names
  final List<String> _doctorNames = const [
    'Dr. Sarah Mitchell',
    'Dr. Michael Chen',
    'Dr. Emily Rodriguez',
    'Dr. Adam Johnson',
  ];

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF2F73FF);

    final stats = <_StatCardData>[
      _StatCardData(
        value: '${_plans.where((p) => p.isActive).length}',
        label: 'Active Care Plans',
        badge: _plans.where((p) => p.isActive).isEmpty ? 'None' : 'Active',
        icon: Icons.show_chart,
        badgeColor: const Color(0xFFE7F7EF),
        iconBg: const Color(0xFFEAF2FF),
        iconColor: const Color(0xFF2F73FF),
      ),
      _StatCardData(
        value: '0',
        label: 'This Week',
        badge: 'Upcoming',
        icon: Icons.calendar_month,
        badgeColor: const Color(0xFFF3ECFF),
        iconBg: const Color(0xFFF3ECFF),
        iconColor: const Color(0xFF7B61FF),
      ),
      _StatCardData(
        value: '0',
        label: 'Care Team Members',
        badge: 'Available',
        icon: Icons.groups,
        badgeColor: const Color(0xFFFFF2E6),
        iconBg: const Color(0xFFFFF2E6),
        iconColor: const Color(0xFFFF8A00),
      ),
      _StatCardData(
        value: '${_reminders.where((r) => !r.done).length}',
        label: "Today's Tasks",
        badge: _reminders.where((r) => !r.done).isEmpty ? 'None' : 'Pending',
        icon: Icons.task_alt,
        badgeColor: const Color(0xFFE7F7EF),
        iconBg: const Color(0xFFE7F7EF),
        iconColor: const Color(0xFF16A34A),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: SafeArea(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_frameRadius),
            child: SizedBox(
              width: _frameW,
              height: _frameH,
              child: Column(
                children: [
                  _PhoneHeader(
                    onBack: () => Navigator.of(context).pop(),
                    onMenu: (action) async {
                      switch (action) {
                        case _MenuAction.profile:
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ProfilePage()),
                          );
                          break;
                        case _MenuAction.settings:
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SettingsPage()),
                          );
                          break;
                        case _MenuAction.privacy:
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const PrivacyPage()),
                          );
                          break;
                        case _MenuAction.logout:
                          break;
                      }
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                      child: Column(
                        children: [
                          _HeroBanner(
                            title: 'Welcome Back',
                            subtitle:
                            'Your care dashboard is ready. Add your plans and reminders to get started.',
                            onSchedule: _openDoctorPicker,
                            image: const NetworkImage(
                              'https://images.unsplash.com/photo-1511174511562-5f7f18b874f8?auto=format&fit=crop&w=1200&q=60',
                            ),
                          ),
                          const SizedBox(height: 16),

                          _StatsRow(items: stats),
                          const SizedBox(height: 16),

                          _SectionHeader(
                            icon: Icons.health_and_safety,
                            title: 'Active Care Plans',
                            actionText: 'Add Plan',
                            onAction: _addPlanDialog,
                          ),
                          const SizedBox(height: 10),

                          if (_plans.isEmpty)
                            const _EmptyCard(
                              icon: Icons.health_and_safety_outlined,
                              title: 'No plans yet',
                              subtitle: 'Add a care plan to track progress and next dates.',
                            )
                          else
                            Column(
                              children: [
                                for (int i = 0; i < _plans.length; i++) ...[
                                  _CarePlanCard(
                                    title: _plans[i].title,
                                    subtitle: _plans[i].subtitle,
                                    progress: _plans[i].progress,
                                    nextDate: _plans[i].nextDate,
                                    statusText: _plans[i].isActive ? 'active' : 'paused',
                                    statusColor: _plans[i].isActive
                                        ? const Color(0xFFE7F7EF)
                                        : const Color(0xFFF1F5FF),
                                    statusTextColor: _plans[i].isActive
                                        ? const Color(0xFF16A34A)
                                        : const Color(0xFF2F73FF),
                                    leadingIcon: _plans[i].icon,
                                    leadingBg: _plans[i].iconBg,
                                    leadingIconColor: _plans[i].iconColor,
                                    progressColor: _plans[i].progressColor,
                                    onDetails: () {},
                                  ),
                                  if (i != _plans.length - 1) const SizedBox(height: 12),
                                ],
                              ],
                            ),

                          const SizedBox(height: 16),

                          _SectionHeader(
                            icon: Icons.notifications_active_outlined,
                            title: "Today's Reminders",
                            actionText: 'Add Reminder',
                            onAction: _addReminderDialog,
                          ),
                          const SizedBox(height: 10),

                          if (_reminders.isEmpty)
                            const _EmptyCard(
                              icon: Icons.notifications_none_rounded,
                              title: 'No reminders yet',
                              subtitle:
                              'Add reminders in the same card format as the examples.',
                            )
                          else
                            _ReminderList(
                              items: _reminders,
                              onToggle: (index, value) {
                                setState(() {
                                  _reminders[index] =
                                      _reminders[index].copyWith(done: value);
                                });
                              },
                              onDelete: (index) {
                                setState(() => _reminders.removeAt(index));
                              },
                            ),
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



  Future<void> _openDoctorPicker() async {
    const frameW = 300.0;

    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: frameW),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Icon(Icons.calendar_month, color: Color(0xFF2F73FF)),
                          SizedBox(width: 10),
                          Text(
                            'Choose a Doctor',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1B2B55),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: _doctorNames.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (c, i) {
                            final name = _doctorNames[i];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAF2FF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.person,
                                    color: Color(0xFF2F73FF)),
                              ),
                              title: Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1B2B55),
                                ),
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => Navigator.of(ctx).pop(name),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    if (selected != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected: $selected')),
      );
    }
  }


  Future<void> _addPlanDialog() async {
    final titleCtrl = TextEditingController();
    final subtitleCtrl = TextEditingController();
    final nextDateCtrl = TextEditingController();
    double progress = 0.0;
    bool active = true;

    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add Care Plan'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: 'Plan title'),
                ),
                TextField(
                  controller: subtitleCtrl,
                  decoration: const InputDecoration(labelText: 'Plan description'),
                ),
                TextField(
                  controller: nextDateCtrl,
                  decoration: const InputDecoration(labelText: 'Next date (e.g. Jan 10, 2026)'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Progress'),
                    Expanded(
                      child: Slider(
                        value: progress,
                        onChanged: (v) => setState(() => progress = v),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Active'),
                    const Spacer(),
                    StatefulBuilder(
                      builder: (ctx2, setLocal) {
                        return Switch(
                          value: active,
                          onChanged: (v) => setLocal(() => active = v),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Save')),
          ],
        );
      },
    );

    if (saved == true && titleCtrl.text.trim().isNotEmpty) {
      setState(() {
        _plans.add(
          _CarePlanData(
            title: titleCtrl.text.trim(),
            subtitle: subtitleCtrl.text.trim().isEmpty
                ? 'Custom care plan'
                : subtitleCtrl.text.trim(),
            progress: progress.clamp(0, 1),
            nextDate: nextDateCtrl.text.trim().isEmpty ? '—' : nextDateCtrl.text.trim(),
            isActive: active,
            icon: Icons.health_and_safety,
            iconBg: const Color(0xFFEAF2FF),
            iconColor: const Color(0xFF2F73FF),
            progressColor: const Color(0xFF2F73FF),
          ),
        );
      });
    }
  }

  Future<void> _addReminderDialog() async {
    final titleCtrl = TextEditingController();
    final timeCtrl = TextEditingController();
    final tagCtrl = TextEditingController(text: 'medication');

    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add Reminder'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: 'Title (example format)'),
                ),
                TextField(
                  controller: timeCtrl,
                  decoration: const InputDecoration(labelText: 'Time (e.g. 08:00 AM)'),
                ),
                TextField(
                  controller: tagCtrl,
                  decoration: const InputDecoration(labelText: 'Tag (medication / measurement / appointment)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Add')),
          ],
        );
      },
    );

    if (saved == true && titleCtrl.text.trim().isNotEmpty) {
      setState(() {
        _reminders.add(
          _ReminderItem(
            title: titleCtrl.text.trim(),
            time: timeCtrl.text.trim().isEmpty ? '—' : timeCtrl.text.trim(),
            tag: tagCtrl.text.trim().isEmpty ? 'reminder' : tagCtrl.text.trim(),
            done: false,
          ),
        );
      });
    }
  }
}

enum _MenuAction { profile, settings, privacy, logout }

class _PhoneHeader extends StatelessWidget {
  final VoidCallback onBack;
  final ValueChanged<_MenuAction> onMenu;

  const _PhoneHeader({
    required this.onBack,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF2F73FF),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 10, 10, 10),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            ),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.favorite, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient Care',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Daily plans, reminders, and support',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xE6FFFFFF),
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<_MenuAction>(
              tooltip: 'Menu',
              icon: const Icon(Icons.settings, color: Colors.white),
              onSelected: onMenu,
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: _MenuAction.profile,
                  child: Row(
                    children: [
                      Icon(Icons.person_outline, size: 18),
                      SizedBox(width: 10),
                      Text('Profile'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: _MenuAction.settings,
                  child: Row(
                    children: [
                      Icon(Icons.tune, size: 18),
                      SizedBox(width: 10),
                      Text('Settings'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: _MenuAction.privacy,
                  child: Row(
                    children: [
                      Icon(Icons.lock_outline, size: 18),
                      SizedBox(width: 10),
                      Text('Privacy'),
                    ],
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem(
                  value: _MenuAction.logout,
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 18, color: Colors.red),
                      SizedBox(width: 10),
                      Text('Log out'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onSchedule;
  final ImageProvider image;

  const _HeroBanner({
    required this.title,
    required this.subtitle,
    required this.onSchedule,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F5CFF),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 220),
                  height: 1.35,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onSchedule,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1B2B55),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.calendar_month, size: 18),
                  label: const Text('Schedule Appointment'),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(image: image, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final List<_StatCardData> items;

  const _StatsRow({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.85,
      ),
      itemBuilder: (context, i) => _StatCard(items[i]),
    );
  }
}

class _StatCardData {
  final String value;
  final String label;
  final String badge;
  final IconData icon;
  final Color badgeColor;
  final Color iconBg;
  final Color iconColor;

  const _StatCardData({
    required this.value,
    required this.label,
    required this.badge,
    required this.icon,
    required this.badgeColor,
    required this.iconBg,
    required this.iconColor,
  });
}

class _StatCard extends StatelessWidget {
  final _StatCardData data;

  const _StatCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6ECFF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: data.iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: data.iconColor, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      data.value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1B2B55),
                        height: 1.0,
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                        decoration: BoxDecoration(
                          color: data.badgeColor,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          data.badge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1B2B55),
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  data.label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF1B2B55).withValues(alpha: 170),
                    fontSize: 12,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
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

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? actionText;
  final VoidCallback? onAction;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.actionText,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2F73FF)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1B2B55),
            ),
          ),
        ),
        if (actionText != null)
          TextButton(
            onPressed: onAction,
            child: Text(actionText!),
          ),
      ],
    );
  }
}

class _CarePlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final String nextDate;
  final String statusText;
  final Color statusColor;
  final Color statusTextColor;
  final IconData leadingIcon;
  final Color leadingBg;
  final Color leadingIconColor;
  final Color progressColor;
  final VoidCallback onDetails;

  const _CarePlanCard({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.nextDate,
    required this.statusText,
    required this.statusColor,
    required this.statusTextColor,
    required this.leadingIcon,
    required this.leadingBg,
    required this.leadingIconColor,
    required this.progressColor,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    final pct = (progress * 100).clamp(0, 100).toStringAsFixed(0);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6ECFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 16,
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
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: leadingBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(leadingIcon, color: leadingIconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1B2B55),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: statusTextColor,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: const Color(0xFF1B2B55).withValues(alpha: 160),
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Progress',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF1B2B55),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0, 1),
                    minHeight: 8,
                    backgroundColor: const Color(0xFFEFF3FF),
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$pct%',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1B2B55),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_month, size: 18, color: Color(0xFF60709A)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Next: $nextDate',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFF60709A)),
                ),
              ),
              TextButton(
                onPressed: onDetails,
                child: const Text('View Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReminderList extends StatelessWidget {
  final List<_ReminderItem> items;
  final void Function(int index, bool value) onToggle;
  final void Function(int index) onDelete;

  const _ReminderList({
    required this.items,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (i) {
        final it = items[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _ReminderTile(
            item: it,
            onChanged: (v) => onToggle(i, v),
            onDelete: () => onDelete(i),
          ),
        );
      }),
    );
  }
}

class _ReminderItem {
  final String title;
  final String time;
  final String tag;
  final bool done;

  const _ReminderItem({
    required this.title,
    required this.time,
    required this.tag,
    required this.done,
  });

  _ReminderItem copyWith({bool? done}) {
    return _ReminderItem(
      title: title,
      time: time,
      tag: tag,
      done: done ?? this.done,
    );
  }
}

class _ReminderTile extends StatelessWidget {
  final _ReminderItem item;
  final ValueChanged<bool> onChanged;
  final VoidCallback onDelete;

  const _ReminderTile({
    required this.item,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6ECFF)),
      ),
      child: Row(
        children: [
          Checkbox(
            value: item.done,
            onChanged: (v) => onChanged(v ?? false),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1B2B55),
                    decoration: item.done ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Color(0xFF60709A)),
                        const SizedBox(width: 6),
                        Text(item.time, style: const TextStyle(color: Color(0xFF60709A))),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5FF),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.tag,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2F73FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 235),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6ECFF)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
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
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF60709A),
                    height: 1.25,
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

class _CarePlanData {
  final String title;
  final String subtitle;
  final double progress;
  final String nextDate;
  final bool isActive;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Color progressColor;

  const _CarePlanData({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.nextDate,
    required this.isActive,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.progressColor,
  });
}
