// lib/src/pages/caregiver_personal_contacts.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/chd_scaffold.dart';

class PersonalContactsPage extends StatelessWidget {
  const PersonalContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Personal Contacts',
      titleAr: 'جهات اتصال شخصية',
      headerIcon: Icons.person_add_alt_1_outlined,
      child: (isArabic) => _PersonalContactsBody(isArabic: isArabic),
    );
  }
}

class _PersonalContactsBody extends StatefulWidget {
  const _PersonalContactsBody({required this.isArabic});
  final bool isArabic;

  @override
  State<_PersonalContactsBody> createState() => _PersonalContactsBodyState();
}

class _PersonalContactsBodyState extends State<_PersonalContactsBody> {
  String _t(String en, String ar) => widget.isArabic ? ar : en;

  CollectionReference<Map<String, dynamic>>? _ref() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    return FirebaseFirestore.instance.collection('users').doc(uid).collection('personal_contacts');
  }

  Future<void> _callOrMsg(BuildContext context, String tel) async {
    final uri = Uri.tryParse('tel:${tel.trim()}');
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _addContactDialog(String groupId) async {
    final name = TextEditingController();
    final phone = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(_t('Add Contact', 'إضافة جهة اتصال')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(hintText: _t('Name', 'الاسم')),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: _t('Phone', 'الهاتف')),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(_t('Cancel', 'إلغاء'))),
          TextButton(
            onPressed: () async {
              final r = _ref();
              if (r == null) return;

              final n = name.text.trim();
              final p = phone.text.trim();
              if (n.isEmpty || p.isEmpty) return;

              await r.doc(groupId).set({
                'updatedAt': FieldValue.serverTimestamp(),
              }, SetOptions(merge: true));

              await r.doc(groupId).collection('items').add({
                'name': n,
                'phone': p,
                'createdAt': FieldValue.serverTimestamp(),
              });

              if (mounted) Navigator.pop(context);
            },
            child: Text(_t('Save', 'حفظ')),
          ),
        ],
      ),
    );

    name.dispose();
    phone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = _ref();
    if (r == null) {
      return Center(
        child: Text(
          _t('Please sign in.', 'يرجى تسجيل الدخول.'),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF5A6C96)),
        ),
      );
    }

    final groups = <_Group>[
      _Group(
        id: 'emergency',
        titleEn: 'Emergency Contacts',
        titleAr: 'جهات اتصال الطوارئ',
        subtitleEn: 'Quick access for urgent situations.',
        subtitleAr: 'وصول سريع للحالات العاجلة.',
        defaultItems: const [
          {'name': 'Ambulance', 'phone': '911'},
          {'name': 'Family Member', 'phone': '+962790000000'},
        ],
      ),
      _Group(
        id: 'short_break',
        titleEn: 'Short Break (2–3 hours)',
        titleAr: 'استراحة قصيرة (2–3 ساعات)',
        subtitleEn: 'Someone who can stay for a short time.',
        subtitleAr: 'شخص يستطيع المساعدة لفترة قصيرة.',
        defaultItems: const [
          {'name': 'Neighbor', 'phone': '+962780000000'},
        ],
      ),
      _Group(
        id: 'extra_hand',
        titleEn: 'Extra Hand',
        titleAr: 'مساعدة إضافية',
        subtitleEn: 'Backup help for errands and support.',
        subtitleAr: 'مساعدة احتياطية للمشاوير والدعم.',
        defaultItems: const [
          {'name': 'Friend', 'phone': '+962770000000'},
        ],
      ),
    ];

    return ListView(
      children: groups.map((g) {
        return _Box(
          title: _t(g.titleEn, g.titleAr),
          icon: Icons.contact_phone_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (g.subtitleEn.trim().isNotEmpty)
                Text(
                  _t(g.subtitleEn, g.subtitleAr),
                  style: const TextStyle(
                    fontSize: 12.6,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A6C96),
                    height: 1.35,
                  ),
                ),
              const SizedBox(height: 10),
              SizedBox(
                height: 42,
                child: ElevatedButton.icon(
                  onPressed: () => _addContactDialog(g.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F73FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text(
                    _t('Add contact', 'إضافة جهة اتصال'),
                    style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _GroupList(
                groupId: g.id,
                isArabic: widget.isArabic,
                defaults: g.defaultItems,
                onCall: _callOrMsg,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _GroupList extends StatelessWidget {
  const _GroupList({
    required this.groupId,
    required this.isArabic,
    required this.defaults,
    required this.onCall,
  });

  final String groupId;
  final bool isArabic;
  final List<Map<String, String>> defaults;
  final Future<void> Function(BuildContext, String) onCall;

  String _t(String en, String ar) => isArabic ? ar : en;

  CollectionReference<Map<String, dynamic>> _itemsRef() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uid).collection('personal_contacts').doc(groupId).collection('items');
  }

  @override
  Widget build(BuildContext context) {
    final q = _itemsRef().orderBy('createdAt', descending: true);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: q.snapshots(),
      builder: (context, snap) {
        final docs = snap.data?.docs ?? const [];
        final hasAny = docs.isNotEmpty;

        final cards = <Widget>[];

        if (!hasAny) {
          for (final d in defaults) {
            cards.add(_ContactRow(
              name: d['name'] ?? '',
              phone: d['phone'] ?? '',
              isArabic: isArabic,
              onCall: onCall,
            ));
          }
        } else {
          for (final doc in docs) {
            final data = doc.data();
            cards.add(_ContactRow(
              name: (data['name'] ?? '').toString(),
              phone: (data['phone'] ?? '').toString(),
              isArabic: isArabic,
              onCall: onCall,
            ));
          }
        }

        return Column(
          children: cards.isEmpty
              ? [
            Text(
              _t('No contacts.', 'لا توجد جهات اتصال.'),
              style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w700, color: Color(0xFF5A6C96)),
            )
          ]
              : cards,
        );
      },
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.name,
    required this.phone,
    required this.isArabic,
    required this.onCall,
  });

  final String name;
  final String phone;
  final bool isArabic;
  final Future<void> Function(BuildContext, String) onCall;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.isEmpty ? (isArabic ? 'جهة اتصال' : 'Contact') : name,
                  style: const TextStyle(fontSize: 12.8, fontWeight: FontWeight.w900, color: Color(0xFF1B2B55)),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: const TextStyle(fontSize: 12.4, fontWeight: FontWeight.w700, color: Color(0xFF5A6C96)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 38,
            child: ElevatedButton(
              onPressed: phone.trim().isEmpty ? null : () => onCall(context, phone),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F73FF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(
                isArabic ? 'اتصال' : 'Call',
                style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Group {
  final String id;
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String subtitleAr;
  final List<Map<String, String>> defaultItems;

  _Group({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
    required this.defaultItems,
  });
}

class _Box extends StatelessWidget {
  const _Box({required this.title, required this.icon, required this.child});
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3EBFF)),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF2F73FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF1B2B55)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
