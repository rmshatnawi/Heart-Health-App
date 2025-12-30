// lib/src/pages/caregiver_write_story.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/chd_scaffold.dart';

class WriteStoryPage extends StatefulWidget {
  const WriteStoryPage({super.key});

  @override
  State<WriteStoryPage> createState() => _WriteStoryPageState();
}

class _WriteStoryPageState extends State<WriteStoryPage> {
  final _title = TextEditingController();
  final _body = TextEditingController();

  bool _loading = false;
  String? _err;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final title = _title.text.trim();
    final body = _body.text.trim();

    setState(() {
      _loading = true;
      _err = null;
    });

    try {
      final excerpt = body.length <= 120 ? body : '${body.substring(0, 120)}...';
      await FirebaseFirestore.instance.collection('patient_stories').add({
        'type': 'text',
        'title': title.isEmpty ? 'My Story' : title,
        'body': body,
        'excerpt': excerpt,
        'authorUid': uid,
        'authorName': (FirebaseAuth.instance.currentUser?.email ?? '').toString(),
        'createdAt': FieldValue.serverTimestamp(),
        // ML hook: server can fill recommendedIds later
        'recommendedIds': <String>[],
      });

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _err = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Write Your Story',
      titleAr: 'اكتب قصتك',
      headerIcon: Icons.edit_note,
      child: (isArabic) {
        String t(String en, String ar) => isArabic ? ar : en;

        return ListView(
          children: [
            _Field(
              label: t('Title', 'العنوان'),
              child: TextField(
                controller: _title,
                decoration: InputDecoration(
                  hintText: t('Optional', 'اختياري'),
                  border: InputBorder.none,
                ),
              ),
            ),
            _Field(
              label: t('Your Story', 'قصتك'),
              child: TextField(
                controller: _body,
                minLines: 8,
                maxLines: 14,
                decoration: InputDecoration(
                  hintText: t('Write here...', 'اكتب هنا...'),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (_err != null) ...[
              const SizedBox(height: 8),
              Text(
                isArabic ? 'حدث خطأ: $_err' : 'Error: $_err',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF9A2A2A),
                ),
              ),
            ],
            const SizedBox(height: 12),
            SizedBox(
              height: 46,
              child: ElevatedButton(
                onPressed: _loading ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F73FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: _loading
                    ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
                    : Text(
                  t('Publish', 'نشر'),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.child});
  final String label;
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
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1B2B55),
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
