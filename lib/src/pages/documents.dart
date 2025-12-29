import 'package:flutter/material.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  static const _frameW = 412.0;
  static const _frameH = 917.0;
  static const _blue = Color(0xFF2F73FF);
  static const _bg = Color(0xFFF6F9FF);

  final List<_UserDoc> _docs = <_UserDoc>[];

  int get _totalDocs => _docs.length;

  int get _addedThisMonth {
    final now = DateTime.now();
    return _docs
        .where((d) => d.createdAt.year == now.year && d.createdAt.month == now.month)
        .length;
  }

  Future<void> _addDocDialog() async {
    final titleCtrl = TextEditingController();
    final tagCtrl = TextEditingController();
    final sizeCtrl = TextEditingController();
    final dateCtrl = TextEditingController(
      text: _formatDate(DateTime.now()),
    );

    IconData pickedIcon = Icons.description_outlined;

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add Document'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'e.g. Blood Test Results',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: tagCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Tag',
                    hintText: 'e.g. Lab Report',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: sizeCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Size',
                    hintText: 'e.g. 1.2 MB',
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dateCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    hintText: 'YYYY-MM-DD',
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _IconChoice(
                        icon: Icons.description_outlined,
                        selected: pickedIcon == Icons.description_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.description_outlined),
                      ),
                      _IconChoice(
                        icon: Icons.science_outlined,
                        selected: pickedIcon == Icons.science_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.science_outlined),
                      ),
                      _IconChoice(
                        icon: Icons.receipt_long_outlined,
                        selected: pickedIcon == Icons.receipt_long_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.receipt_long_outlined),
                      ),
                      _IconChoice(
                        icon: Icons.image_outlined,
                        selected: pickedIcon == Icons.image_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.image_outlined),
                      ),
                      _IconChoice(
                        icon: Icons.medical_services_outlined,
                        selected: pickedIcon == Icons.medical_services_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.medical_services_outlined),
                      ),
                      _IconChoice(
                        icon: Icons.history_edu_outlined,
                        selected: pickedIcon == Icons.history_edu_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.history_edu_outlined),
                      ),
                    ],
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
                final title = titleCtrl.text.trim();
                final tag = tagCtrl.text.trim();
                final size = sizeCtrl.text.trim();
                final dateText = dateCtrl.text.trim();

                if (title.isEmpty || tag.isEmpty || size.isEmpty) return;

                final parsed = _parseDate(dateText) ?? DateTime.now();

                setState(() {
                  _docs.insert(
                    0,
                    _UserDoc(
                      title: title,
                      tag: tag,
                      sizeText: size,
                      createdAt: parsed,
                      icon: pickedIcon,
                    ),
                  );
                });

                Navigator.of(ctx).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: _blue, foregroundColor: Colors.white),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    titleCtrl.dispose();
    tagCtrl.dispose();
    sizeCtrl.dispose();
    dateCtrl.dispose();
  }

  void _editDocDialog(_UserDoc doc) async {
    final titleCtrl = TextEditingController(text: doc.title);
    final tagCtrl = TextEditingController(text: doc.tag);
    final sizeCtrl = TextEditingController(text: doc.sizeText);
    final dateCtrl = TextEditingController(text: _formatDate(doc.createdAt));
    IconData pickedIcon = doc.icon;

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Document'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: tagCtrl,
                  decoration: const InputDecoration(labelText: 'Tag'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: sizeCtrl,
                  decoration: const InputDecoration(labelText: 'Size'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dateCtrl,
                  decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _IconChoice(
                        icon: Icons.description_outlined,
                        selected: pickedIcon == Icons.description_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.description_outlined),
                      ),
                      _IconChoice(
                        icon: Icons.science_outlined,
                        selected: pickedIcon == Icons.science_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.science_outlined),
                      ),
                      _IconChoice(
                        icon: Icons.receipt_long_outlined,
                        selected: pickedIcon == Icons.receipt_long_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.receipt_long_outlined),
                      ),
                      _IconChoice(
                        icon: Icons.image_outlined,
                        selected: pickedIcon == Icons.image_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.image_outlined),
                      ),
                      _IconChoice(
                        icon: Icons.medical_services_outlined,
                        selected: pickedIcon == Icons.medical_services_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.medical_services_outlined),
                      ),
                      _IconChoice(
                        icon: Icons.history_edu_outlined,
                        selected: pickedIcon == Icons.history_edu_outlined,
                        onTap: () => setState(() => pickedIcon = Icons.history_edu_outlined),
                      ),
                    ],
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
                final title = titleCtrl.text.trim();
                final tag = tagCtrl.text.trim();
                final size = sizeCtrl.text.trim();
                final dateText = dateCtrl.text.trim();
                if (title.isEmpty || tag.isEmpty || size.isEmpty) return;

                final parsed = _parseDate(dateText) ?? doc.createdAt;

                setState(() {
                  final idx = _docs.indexWhere((d) => d.id == doc.id);
                  if (idx >= 0) {
                    _docs[idx] = _docs[idx].copyWith(
                      title: title,
                      tag: tag,
                      sizeText: size,
                      createdAt: parsed,
                      icon: pickedIcon,
                    );
                  }
                });

                Navigator.of(ctx).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: _blue, foregroundColor: Colors.white),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    titleCtrl.dispose();
    tagCtrl.dispose();
    sizeCtrl.dispose();
    dateCtrl.dispose();
  }

  void _deleteDoc(_UserDoc doc) {
    setState(() => _docs.removeWhere((d) => d.id == doc.id));
  }

  void _resetAll() {
    setState(() => _docs.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28), // rounder edges like other pages
            child: SizedBox(
              width: _frameW,
              height: _frameH,
              child: Column(
                children: [
                  _TopHeader(
                    title: 'Documents',
                    subtitle: 'Your medical files in one place',
                    icon: Icons.folder_open_rounded,
                    headerColor: _blue,
                    onBack: () => Navigator.of(context).pop(),
                    onReset: _resetAll,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: _addDocDialog,
                              icon: const Icon(Icons.add),
                              label: const Text(
                                'Add Document',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          _StatRow(
                            total: _totalDocs,
                            addedThisMonth: _addedThisMonth,
                          ),

                          const SizedBox(height: 16),

                          const Text(
                            'All Documents',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1B2B55),
                            ),
                          ),
                          const SizedBox(height: 10),

                          if (_docs.isEmpty)
                            _EmptyState(onAdd: _addDocDialog)
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _docs.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, i) {
                                final d = _docs[i];
                                return _DocRowCard(
                                  doc: d,
                                  onEdit: () => _editDocDialog(d),
                                  onDelete: () => _deleteDoc(d),
                                );
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
}

class _TopHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color headerColor;
  final VoidCallback onBack;
  final VoidCallback onReset;

  const _TopHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.headerColor,
    required this.onBack,
    required this.onReset,
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
          TextButton(
            onPressed: onReset,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
            child: const Text(
              'Reset',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final int total;
  final int addedThisMonth;

  const _StatRow({required this.total, required this.addedThisMonth});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MiniStat(
            icon: Icons.description_outlined,
            iconBg: const Color(0xFFE8F1FF),
            value: '$total',
            label: 'Total Documents',
            iconColor: const Color(0xFF2F73FF),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _MiniStat(
            icon: Icons.add_circle_outline,
            iconBg: const Color(0xFFE9FFF1),
            value: '$addedThisMonth',
            label: 'Added This Month',
            iconColor: const Color(0xFF00A651),
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String value;
  final String label;

  const _MiniStat({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.value,
    required this.label,
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1B2B55),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6B7A99),
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

class _DocRowCard extends StatelessWidget {
  final _UserDoc doc;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _DocRowCard({
    required this.doc,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6ECF7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 14,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F5FA),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(doc.icon, size: 20, color: const Color(0xFF1B2B55)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1B2B55),
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_formatDate(doc.createdAt)}  •  ${doc.sizeText}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6B7A99),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
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
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<_DocMenuAction>(
            tooltip: '',
            icon: const Icon(Icons.more_horiz, color: Color(0xFF8FA0C2)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            onSelected: (v) {
              if (v == _DocMenuAction.edit) onEdit();
              if (v == _DocMenuAction.delete) onDelete();
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _DocMenuAction.edit,
                child: Text('Edit'),
              ),
              PopupMenuItem(
                value: _DocMenuAction.delete,
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _DocMenuAction { edit, delete }

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyState({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6ECF7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'No documents yet.',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1B2B55),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Add your own documents and they will appear here.',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7A99),
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 46,
            child: ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Document',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F73FF),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconChoice extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _IconChoice({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final border = selected ? const Color(0xFF2F73FF) : const Color(0xFFE6ECF7);
    final bg = selected ? const Color(0xFFE8F1FF) : const Color(0xFFF7FAFF);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border),
        ),
        child: Icon(icon, color: const Color(0xFF1B2B55)),
      ),
    );
  }
}

class _UserDoc {
  final String id;
  final String title;
  final String tag;
  final String sizeText;
  final DateTime createdAt;
  final IconData icon;

  _UserDoc({
    required this.title,
    required this.tag,
    required this.sizeText,
    required this.createdAt,
    required this.icon,
  }) : id = UniqueKey().toString();

  _UserDoc._({
    required this.id,
    required this.title,
    required this.tag,
    required this.sizeText,
    required this.createdAt,
    required this.icon,
  });

  _UserDoc copyWith({
    String? title,
    String? tag,
    String? sizeText,
    DateTime? createdAt,
    IconData? icon,
  }) {
    return _UserDoc._(
      id: id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      sizeText: sizeText ?? this.sizeText,
      createdAt: createdAt ?? this.createdAt,
      icon: icon ?? this.icon,
    );
  }
}

String _formatDate(DateTime dt) {
  final y = dt.year.toString().padLeft(4, '0');
  final m = dt.month.toString().padLeft(2, '0');
  final d = dt.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

DateTime? _parseDate(String s) {
  final parts = s.split('-');
  if (parts.length != 3) return null;
  final y = int.tryParse(parts[0]);
  final m = int.tryParse(parts[1]);
  final d = int.tryParse(parts[2]);
  if (y == null || m == null || d == null) return null;
  if (m < 1 || m > 12) return null;
  if (d < 1 || d > 31) return null;
  return DateTime(y, m, d);
}
