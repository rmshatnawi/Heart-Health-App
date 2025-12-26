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
  static const double _phoneMaxWidth = 430.0;

  final List<_ReminderItem> _reminders = [
    _ReminderItem(
      title: 'Take Morning Medication',
      time: '08:00 AM',
      tag: 'medication',
      done: false,
    ),
    _ReminderItem(
      title: 'Blood Pressure Check',
      time: '02:00 PM',
      tag: 'measurement',
      done: false,
    ),
    _ReminderItem(
      title: 'Physical Therapy Session',
      time: '04:30 PM',
      tag: 'appointment',
      done: false,
    ),
    _ReminderItem(
      title: 'Evening Medication',
      time: '08:00 PM',
      tag: 'medication',
      done: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),

      // IMPORTANT: no AppBar here.
      // We render a phone-width header inside the body so it does NOT stretch on web.
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _phoneMaxWidth),
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
                      // Put your logout logic here if you need it.
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
                          title: 'Welcome Back, Sarah',
                          subtitle:
                          'Your personalized care journey continues. We\'re here to support you every step of the way.',
                          onSchedule: () {},
                          image: const NetworkImage(
                            'https://images.unsplash.com/photo-1511174511562-5f7f18b874f8?auto=format&fit=crop&w=1200&q=60',
                          ),
                        ),
                        const SizedBox(height: 16),

                        const _StatsRow(
                          items: [
                            _StatCardData(
                              value: '3',
                              label: 'Active Care Plans',
                              badge: 'Active',
                              icon: Icons.show_chart,
                              badgeColor: Color(0xFFE7F7EF),
                              iconBg: Color(0xFFEAF2FF),
                              iconColor: Color(0xFF2F73FF),
                            ),
                            _StatCardData(
                              value: '5',
                              label: 'This Week',
                              badge: 'Upcoming',
                              icon: Icons.calendar_month,
                              badgeColor: Color(0xFFF3ECFF),
                              iconBg: Color(0xFFF3ECFF),
                              iconColor: Color(0xFF7B61FF),
                            ),
                            _StatCardData(
                              value: '3',
                              label: 'Care Team Members',
                              badge: 'Available',
                              icon: Icons.groups,
                              badgeColor: Color(0xFFFFF2E6),
                              iconBg: Color(0xFFFFF2E6),
                              iconColor: Color(0xFFFF8A00),
                            ),
                            _StatCardData(
                              value: '4',
                              label: 'Today\'s Tasks',
                              badge: 'Pending',
                              icon: Icons.task_alt,
                              badgeColor: Color(0xFFE7F7EF),
                              iconBg: Color(0xFFE7F7EF),
                              iconColor: Color(0xFF16A34A),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        _SectionHeader(
                          icon: Icons.health_and_safety,
                          title: 'Active Care Plans',
                          actionText: 'View All',
                          onAction: () {},
                        ),
                        const SizedBox(height: 10),

                        _CarePlanCard(
                          title: 'Post-Surgery Recovery',
                          subtitle:
                          'Comprehensive recovery plan with physical therapy and medication management',
                          progress: 0.65,
                          nextDate: 'Dec 22, 2025',
                          statusText: 'active',
                          statusColor: const Color(0xFFE7F7EF),
                          statusTextColor: const Color(0xFF16A34A),
                          leadingIcon: Icons.show_chart,
                          leadingBg: const Color(0xFFEAF2FF),
                          leadingIconColor: const Color(0xFF2F73FF),
                          progressColor: const Color(0xFF2F73FF),
                          onDetails: () {},
                        ),
                        const SizedBox(height: 12),

                        _CarePlanCard(
                          title: 'Diabetes Management',
                          subtitle: 'Blood sugar monitoring, diet planning, and regular check-ups',
                          progress: 0.80,
                          nextDate: 'Dec 20, 2025',
                          statusText: 'active',
                          statusColor: const Color(0xFFE7F7EF),
                          statusTextColor: const Color(0xFF16A34A),
                          leadingIcon: Icons.medical_services,
                          leadingBg: const Color(0xFFE7F7EF),
                          leadingIconColor: const Color(0xFF16A34A),
                          progressColor: const Color(0xFF16A34A),
                          onDetails: () {},
                        ),
                        const SizedBox(height: 12),

                        _CarePlanCard(
                          title: 'Cardiac Care Program',
                          subtitle: 'Heart health monitoring and lifestyle modification guidance',
                          progress: 0.45,
                          nextDate: 'Dec 25, 2025',
                          statusText: 'active',
                          statusColor: const Color(0xFFEAF2FF),
                          statusTextColor: const Color(0xFF2F73FF),
                          leadingIcon: Icons.favorite,
                          leadingBg: const Color(0xFFFFE6EA),
                          leadingIconColor: const Color(0xFFE11D48),
                          progressColor: const Color(0xFFE11D48),
                          onDetails: () {},
                        ),

                        const SizedBox(height: 16),

                        _SectionHeader(
                          icon: Icons.notifications_active_outlined,
                          title: 'Today\'s Reminders',
                          actionText: 'Add Task',
                          onAction: () {},
                        ),
                        const SizedBox(height: 10),

                        _ReminderList(
                          items: _reminders,
                          onToggle: (index, value) {
                            setState(() {
                              _reminders[index] = _reminders[index].copyWith(done: value);
                            });
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
    );
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
    // Make cards taller to avoid overflow on web/phone.
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

  const _ReminderList({
    required this.items,
    required this.onToggle,
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

  const _ReminderTile({
    required this.item,
    required this.onChanged,
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
        ],
      ),
    );
  }
}
