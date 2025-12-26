import 'package:flutter/material.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F9FF);
    const blue = Color(0xFF2F73FF);

    final categories = <_DocCategory>[
      _DocCategory(title: 'Lab Reports', count: 12, icon: Icons.science_outlined),
      _DocCategory(title: 'Prescriptions', count: 8, icon: Icons.receipt_long_outlined),
      _DocCategory(title: 'Medical History', count: 15, icon: Icons.history_edu_outlined),
      _DocCategory(title: 'Imaging', count: 6, icon: Icons.image_outlined),
      _DocCategory(title: 'Checkup Records', count: 10, icon: Icons.medical_services_outlined),
      _DocCategory(title: 'Vital Signs', count: 20, icon: Icons.monitor_heart_outlined),
    ];

    final recentDocs = <_RecentDoc>[
      _RecentDoc(
        title: 'Blood Test Results - Complete Blood Count',
        date: 'Dec 15, 2024',
        size: '2.4 MB',
        tag: 'Lab Report',
        icon: Icons.science_outlined,
      ),
      _RecentDoc(
        title: 'Prescription - Antibiotic Treatment',
        date: 'Dec 12, 2024',
        size: '156 KB',
        tag: 'Prescription',
        icon: Icons.receipt_long_outlined,
      ),
      _RecentDoc(
        title: 'Annual Physical Examination',
        date: 'Dec 10, 2024',
        size: '1.8 MB',
        tag: 'Checkup',
        icon: Icons.medical_services_outlined,
      ),
      _RecentDoc(
        title: 'X-Ray - Chest',
        date: 'Dec 8, 2024',
        size: '5.2 MB',
        tag: 'Imaging',
        icon: Icons.image_outlined,
      ),
      _RecentDoc(
        title: 'Cholesterol Test Results',
        date: 'Dec 5, 2024',
        size: '1.1 MB',
        tag: 'Lab Report',
        icon: Icons.science_outlined,
      ),
      _RecentDoc(
        title: 'Vaccination Record - Flu Shot',
        date: 'Dec 3, 2024',
        size: '342 KB',
        tag: 'Medical History',
        icon: Icons.history_edu_outlined,
      ),
    ];

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430), // phone-fit
            child: Column(
              children: [
                _TopHeader(
                  title: 'Documents',
                  subtitle: 'Your medical files in one place',
                  icon: Icons.folder_open_rounded,
                  headerColor: blue, // header bg = icon theme (blue)
                  onBack: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Upload button (full width on phone)
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add),
                            label: const Text(
                              'Upload Document',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Search + filter icons (phone friendly)
                        Row(
                          children: [
                            Expanded(
                              child: _SearchBox(
                                hint: 'Search documents...',
                                onChanged: (_) {},
                              ),
                            ),
                            const SizedBox(width: 10),
                            _SquareIconButton(
                              icon: Icons.filter_list,
                              active: false,
                              onTap: () {},
                            ),
                            const SizedBox(width: 10),
                            _SquareIconButton(
                              icon: Icons.grid_view_rounded,
                              active: true,
                              onTap: () {},
                            ),
                            const SizedBox(width: 10),
                            _SquareIconButton(
                              icon: Icons.view_agenda_outlined,
                              active: false,
                              onTap: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          'Categories',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 12),

                        // Categories grid (phone: 2 columns)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categories.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 2.65,
                          ),
                          itemBuilder: (context, i) {
                            final c = categories[i];
                            return _CategoryTile(
                              title: c.title,
                              count: '${c.count} documents',
                              icon: c.icon,
                              onTap: () {},
                            );
                          },
                        ),

                        const SizedBox(height: 22),

                        // Recent docs header
                        Row(
                          children: [
                            const Text(
                              'Recent Documents',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: const Text('View All'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Recent docs grid (phone: 2 columns, taller cards)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recentDocs.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.25,
                          ),
                          itemBuilder: (context, i) {
                            final d = recentDocs[i];
                            return _RecentDocumentCard(doc: d);
                          },
                        ),

                        const SizedBox(height: 18),

                        _StatCard(
                          icon: Icons.description_outlined,
                          iconBg: const Color(0xFFE8F1FF),
                          value: '71',
                          label: 'Total Documents',
                        ),
                        const SizedBox(height: 12),
                        _StatCard(
                          icon: Icons.add_circle_outline,
                          iconBg: const Color(0xFFE9FFF1),
                          value: '9',
                          label: 'Added This Month',
                          iconColor: const Color(0xFF00A651),
                        ),
                        const SizedBox(height: 12),
                        _StatCard(
                          icon: Icons.storage_outlined,
                          iconBg: const Color(0xFFF1E8FF),
                          value: '24.8 MB',
                          label: 'Total Storage',
                          iconColor: const Color(0xFF7A3BFF),
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

class _TopHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color headerColor;
  final VoidCallback onBack;

  const _TopHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.headerColor,
    required this.onBack,
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
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
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
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;

  const _SearchBox({required this.hint, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6ECF7)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF8FA0C2)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Color(0xFF8FA0C2)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _SquareIconButton({
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF2F73FF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE6ECF7)),
        ),
        child: Icon(icon, color: active ? Colors.white : const Color(0xFF6D7FA6)),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.title,
    required this.count,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE6ECF7)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF2F73FF), size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    count,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF6B7A99),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF8FA0C2)),
          ],
        ),
      ),
    );
  }
}

class _RecentDocumentCard extends StatelessWidget {
  final _RecentDoc doc;

  const _RecentDocumentCard({required this.doc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE6ECF7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F5FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(doc.icon, size: 18, color: const Color(0xFF1B2B55)),
                ),
                const Spacer(),
                const Icon(Icons.more_horiz, color: Color(0xFF8FA0C2)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              doc.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w900, height: 1.2),
            ),
            const SizedBox(height: 6),
            Text(
              '${doc.date}  •  ${doc.size}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF6B7A99), fontSize: 12),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1FF),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                doc.tag,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF2F73FF),
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color? iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconBg,
    required this.value,
    required this.label,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6ECF7)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor ?? const Color(0xFF2F73FF)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 2),
              Text(label, style: const TextStyle(color: Color(0xFF6B7A99))),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocCategory {
  final String title;
  final int count;
  final IconData icon;

  const _DocCategory({required this.title, required this.count, required this.icon});
}

class _RecentDoc {
  final String title;
  final String date;
  final String size;
  final String tag;
  final IconData icon;

  const _RecentDoc({
    required this.title,
    required this.date,
    required this.size,
    required this.tag,
    required this.icon,
  });
}
