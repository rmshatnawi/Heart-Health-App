import 'package:flutter/material.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      appBar: AppBar(
        leading: const BackButton(), // back to previous page
        title: const Text('Documents'),
        elevation: 0,
        backgroundColor: const Color(0xFFF6F9FF),
        foregroundColor: const Color(0xFF1B2B55),
      ),
      backgroundColor: const Color(0xFFF6F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row (title + upload button)
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Documents',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Your medical files in one place',
                          style: TextStyle(color: Color(0xFF6B7A99)),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Upload Document'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F73FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Search + filter icons
              Row(
                children: [
                  Expanded(
                    child: _SearchBox(
                      hint: 'Search documents...',
                      onChanged: (_) {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  _IconPill(
                    icon: Icons.filter_list,
                    label: 'Filter',
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),

              // Categories grid (NO scrolling here)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 2.35,
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Recent docs grid (NO scrolling here)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentDocs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.3, // more height to avoid overflow
                ),
                itemBuilder: (context, i) {
                  final d = recentDocs[i];
                  return _RecentDocumentCard(doc: d);
                },
              ),

              const SizedBox(height: 18),

              // Bottom stats
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

class _IconPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _IconPill({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE6ECF7)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF6D7FA6)),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Color(0xFF6D7FA6))),
          ],
        ),
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _SquareIconButton({required this.icon, required this.active, required this.onTap});

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
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    count,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Color(0xFF6B7A99), fontSize: 12),
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
          mainAxisSize: MainAxisSize.max,
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

            // Title (limit lines -> prevents overflow)
            Text(
              doc.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800, height: 1.2),
            ),
            const SizedBox(height: 6),

            // Meta row (single line -> prevents overflow)
            Text(
              '${doc.date}  •  ${doc.size}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF6B7A99), fontSize: 12),
            ),

            const Spacer(),

            // Tag chip
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
                  fontWeight: FontWeight.w700,
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
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
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
