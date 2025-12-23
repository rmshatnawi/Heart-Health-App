import 'package:flutter/material.dart';

class PatientCarePage extends StatefulWidget {
  const PatientCarePage({super.key});

  @override
  State<PatientCarePage> createState() => _PatientCarePageState();
}

class _PatientCarePageState extends State<PatientCarePage> {
  final List<_ReminderItem> _reminders = [
    _ReminderItem(
      title: 'Take Morning Medication',
      time: '08:00 AM',
      tag: 'medication',
      done: true,
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
    final w = MediaQuery.of(context).size.width;
    final contentMaxWidth = w > 900 ? 900.0 : w; // keeps it nice on tablets/desktop

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: const BackButton(), // back to previous page
        title: Row(
          children: const [
            Icon(Icons.favorite, color: Color(0xFF2F73FF)),
            SizedBox(width: 10),
            Text(
              'Patient Care',
              style: TextStyle(
                color: Color(0xFF1B2B55),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Color(0xFF1B2B55)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle, color: Color(0xFF2F73FF)),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: contentMaxWidth),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _HeroBanner(
                  title: 'Welcome Back, Sarah',
                  subtitle:
                  'Your personalized care journey continues. We\'re here to support you every step of the way.',
                  onSchedule: () {},
                  // Replace with your own asset later if you want:
                  image: const NetworkImage(
                    'https://images.unsplash.com/photo-1511174511562-5f7f18b874f8?auto=format&fit=crop&w=1200&q=60',
                  ),
                ),
                const SizedBox(height: 16),

                _StatsRow(
                  items: const [
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

                // Responsive: stack on phones, side-by-side on wide screens.
                LayoutBuilder(
                  builder: (context, c) {
                    final isWide = c.maxWidth >= 820;
                    if (isWide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildLeftColumn()),
                          const SizedBox(width: 16),
                          SizedBox(width: 320, child: _buildRightColumn()),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        _buildLeftColumn(),
                        const SizedBox(height: 16),
                        _buildRightColumn(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      children: [
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
    );
  }

  Widget _buildRightColumn() {
    return Column(
      children: [
        _SectionHeader(
          icon: Icons.groups_2_outlined,
          title: 'Your Care Team',
          actionText: null,
          onAction: null,
        ),
        const SizedBox(height: 10),
        _CareTeamCard(
          name: 'Dr. Sarah Johnson',
          role: 'Primary Care Physician',
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=400&q=60',
          ),
          online: true,
        ),
        const SizedBox(height: 12),
        _CareTeamCard(
          name: 'Michael Chen',
          role: 'Physical Therapist',
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=400&q=60',
          ),
          online: true,
        ),
        const SizedBox(height: 12),
        _CareTeamCard(
          name: 'Emily Rodriguez',
          role: 'Registered Nurse',
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1582750433449-648ed127bb54?auto=format&fit=crop&w=400&q=60',
          ),
          online: true,
        ),

        const SizedBox(height: 16),

        _SectionHeader(
          icon: Icons.favorite_border,
          title: 'Support Resources',
          actionText: null,
          onAction: null,
        ),
        const SizedBox(height: 10),
        _ResourceTile(
          icon: Icons.description_outlined,
          title: 'Understanding Your Care Plan',
          subtitle: 'Learn about your personalized treatment journey',
          onTap: () {},
        ),
        const SizedBox(height: 10),
        _ResourceTile(
          icon: Icons.family_restroom_outlined,
          title: 'Family Support Resources',
          subtitle: 'Tools and information for family caregivers',
          onTap: () {},
        ),
        const SizedBox(height: 10),
        _ResourceTile(
          icon: Icons.call_outlined,
          title: 'Emergency Contacts',
          subtitle: '24/7 support and emergency assistance',
          onTap: () {},
        ),

        const SizedBox(height: 12),

        _EmergencyCard(
          onCall: () {},
        ),
      ],
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
        child: LayoutBuilder(
          builder: (context, c) {
            final isWide = c.maxWidth >= 700;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: isWide
                  ? Row(
                children: [
                  Expanded(child: _textBlock(context)),
                  const SizedBox(width: 16),
                  _imageBlock(isWide: true),
                ],
              )
                  : Column(
                children: [
                  _textBlock(context),
                  const SizedBox(height: 12),
                  _imageBlock(isWide: false),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _textBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 220),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ElevatedButton.icon(
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
          ],
        ),
      ],
    );
  }

  Widget _imageBlock({required bool isWide}) {
    return Container(
      width: isWide ? 320 : double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(image: image, fit: BoxFit.cover),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final List<_StatCardData> items;

  const _StatsRow({required this.items});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        // phone: 2 columns, wide: 4 columns
        final cols = c.maxWidth >= 820 ? 4 : 2;
        final gap = 12.0;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: gap,
            mainAxisSpacing: gap,
            childAspectRatio: 2.7,
          ),
          itemBuilder: (context, i) => _StatCard(items[i]),
        );
      },
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6ECFF)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: data.iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: data.iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      data.value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: data.badgeColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        data.badge,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1B2B55),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  data.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF1B2B55).withValues(alpha: 160),
                    fontSize: 12,
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
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1B2B55),
          ),
        ),
        const Spacer(),
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
                              fontWeight: FontWeight.w800,
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
                              fontWeight: FontWeight.w700,
                              color: statusTextColor,
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
              fontWeight: FontWeight.w700,
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
                  fontWeight: FontWeight.w800,
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
              Text(
                'Next: $nextDate',
                style: const TextStyle(color: Color(0xFF60709A)),
              ),
              const Spacer(),
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
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1B2B55),
                    decoration: item.done ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Color(0xFF60709A)),
                    const SizedBox(width: 6),
                    Text(item.time, style: const TextStyle(color: Color(0xFF60709A))),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5FF),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.tag,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
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

class _CareTeamCard extends StatelessWidget {
  final String name;
  final String role;
  final ImageProvider image;
  final bool online;

  const _CareTeamCard({
    required this.name,
    required this.role,
    required this.image,
    required this.online,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6ECFF)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(radius: 22, backgroundImage: image),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: online ? const Color(0xFF22C55E) : const Color(0xFF9CA3AF),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      role,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: const Color(0xFF1B2B55).withValues(alpha: 150)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _smallActionButton(icon: Icons.call, label: 'Call', onTap: () {})),
              const SizedBox(width: 8),
              Expanded(child: _smallActionButton(icon: Icons.message, label: 'Message', onTap: () {})),
              const SizedBox(width: 8),
              Expanded(child: _smallActionButton(icon: Icons.videocam, label: 'Video', onTap: () {})),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F6FF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE6ECFF)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF1B2B55)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _ResourceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ResourceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE6ECFF)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1B2B55),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: const Color(0xFF1B2B55).withValues(alpha: 150)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF60709A)),
          ],
        ),
      ),
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  final VoidCallback onCall;

  const _EmergencyCard({required this.onCall});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF2D55), Color(0xFFB91C1C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '24/7 Emergency Support',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'For urgent medical assistance, contact our emergency line anytime.',
            style: TextStyle(color: Colors.white.withValues(alpha: 230)),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCall,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFB91C1C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Call Emergency Line',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
