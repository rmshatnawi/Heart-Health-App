// lib/src/pages/caregiver_story_journal.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'caregiver_write_story.dart';
import 'caregiver_story_view.dart';

class StoryJournalPage extends StatelessWidget {
  const StoryJournalPage({super.key, required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return Center(
        child: Text(
          _t('Please sign in.', 'يرجى تسجيل الدخول.'),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF5A6C96),
          ),
        ),
      );
    }

    final q = FirebaseFirestore.instance
        .collection('patient_stories')
        .where('authorUid', isEqualTo: uid)
        .orderBy('createdAt', descending: true);

    return Column(
      children: [
        SizedBox(
          height: 44,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const WriteStoryPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F73FF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            icon: const Icon(Icons.edit_note, color: Colors.white),
            label: Text(
              _t('Write your story', 'اكتب قصتك'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: q.snapshots(),
            builder: (context, snap) {
              if (snap.hasError) {
                return Center(
                  child: Text(
                    _t('Failed to load.', 'فشل التحميل.'),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF9A2A2A),
                    ),
                  ),
                );
              }
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final docs = snap.data?.docs ?? const [];
              if (docs.isEmpty) {
                return Center(
                  child: Text(
                    _t('No stories yet.', 'لا توجد قصص بعد.'),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF5A6C96),
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, i) {
                  final d = docs[i];
                  final data = d.data();
                  final title = (data['title'] ?? '').toString();
                  final excerpt = (data['excerpt'] ?? '').toString();
                  final type = (data['type'] ?? 'text').toString();

                  return _JournalCard(
                    title: title.isEmpty ? _t('My story', 'قصتي') : title,
                    subtitle: excerpt,
                    icon: type == 'video' ? Icons.play_circle_outline : Icons.article_outlined,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => StoryViewPage(storyId: d.id, isArabic: isArabic)),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _JournalCard extends StatelessWidget {
  const _JournalCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
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
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF2F73FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    if (subtitle.trim().isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5A6C96),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right, color: Color(0xFF5A6C96)),
            ],
          ),
        ),
      ),
    );
  }
}
