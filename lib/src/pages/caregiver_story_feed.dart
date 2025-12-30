// lib/src/pages/caregiver_story_feed.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/chd_scaffold.dart';
import 'caregiver_story_view.dart';

class StoryFeedPage extends StatelessWidget {
  const StoryFeedPage({super.key, required this.type, required this.isArabic});
  final String type; // text | video
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final q = FirebaseFirestore.instance
        .collection('patient_stories')
        .where('type', isEqualTo: type)
        .orderBy('createdAt', descending: true)
        .limit(50);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: q.snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text(
              _t('Failed to load stories.', 'فشل تحميل القصص.'),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF9A2A2A),
              ),
              textAlign: TextAlign.center,
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

        final uid = FirebaseAuth.instance.currentUser?.uid;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, i) {
            final d = docs[i];
            final data = d.data();

            final title = (data['title'] ?? '').toString();
            final excerpt = (data['excerpt'] ?? '').toString();
            final authorName = (data['authorName'] ?? '').toString();
            final authorUid = (data['authorUid'] ?? '').toString();
            final mine = uid != null && uid == authorUid;

            return _StoryCard(
              title: title.isEmpty ? _t('Story', 'قصة') : title,
              subtitle: excerpt,
              trailing: mine ? _t('Mine', 'قصتي') : (authorName.isEmpty ? '' : authorName),
              icon: type == 'video' ? Icons.play_circle_outline : Icons.article_outlined,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StoryViewPage(
                      storyId: d.id,
                      isArabic: isArabic,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String trailing;
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
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 10),
              if (trailing.trim().isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FF),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: const Color(0xFFE3EBFF)),
                  ),
                  child: Text(
                    trailing,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF21899C),
                    ),
                  ),
                )
              else
                const Icon(Icons.chevron_right, color: Color(0xFF5A6C96)),
            ],
          ),
        ),
      ),
    );
  }
}
