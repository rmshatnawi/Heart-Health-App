// lib/src/pages/caregiver_story_view.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/chd_scaffold.dart';

class StoryViewPage extends StatelessWidget {
  const StoryViewPage({super.key, required this.storyId, required this.isArabic});
  final String storyId;
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  Future<void> _openUrl(BuildContext context, String url) async {
    final raw = url.trim();
    final uri = Uri.tryParse(raw);
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t('Invalid link', 'رابط غير صالح'))),
      );
      return;
    }
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t('Could not open link', 'تعذر فتح الرابط'))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection('patient_stories').doc(storyId);

    return ChdScaffold(
      titleEn: 'Story',
      titleAr: 'قصة',
      headerIcon: Icons.auto_stories_outlined,
      child: (_) => StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: ref.snapshots(),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(
              child: Text(
                _t('Failed to load story.', 'فشل تحميل القصة.'),
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
          if (!snap.hasData || !snap.data!.exists) {
            return Center(
              child: Text(
                _t('Story not found.', 'القصة غير موجودة.'),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5A6C96),
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          final d = snap.data!.data() ?? {};
          final type = (d['type'] ?? 'text').toString();
          final title = (d['title'] ?? '').toString();
          final body = (d['body'] ?? '').toString();
          final url = (d['url'] ?? '').toString();
          final recommended = (d['recommendedIds'] as List<dynamic>? ?? const []).map((e) => e.toString()).toList();

          return ListView(
            children: [
              _Box(
                title: title.isEmpty ? _t('Story', 'قصة') : title,
                icon: type == 'video' ? Icons.play_circle_outline : Icons.article_outlined,
                child: type == 'video'
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      url.isEmpty ? _t('No video link.', 'لا يوجد رابط فيديو.') : url,
                      style: TextStyle(
                        fontSize: 12.6,
                        fontWeight: FontWeight.w800,
                        color: url.isEmpty ? const Color(0xFF5A6C96) : const Color(0xFF2F73FF),
                        decoration: url.isEmpty ? null : TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: url.isEmpty ? null : () => _openUrl(context, url),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F73FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        child: Text(
                          _t('Open Video', 'فتح الفيديو'),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : Text(
                  body.trim().isEmpty ? _t('No text.', 'لا يوجد نص.') : body,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12.8,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A6C96),
                    height: 1.55,
                  ),
                ),
              ),
              _Box(
                title: _t('Related Stories', 'قصص مرتبطة'),
                icon: Icons.recommend_outlined,
                child: recommended.isEmpty
                    ? Text(
                  _t(
                    'No related stories yet. Related IDs can be produced by a server model and stored in recommendedIds.',
                    'لا توجد قصص مرتبطة بعد. يمكن لنموذج على الخادم توليدها وتخزينها داخل recommendedIds.',
                  ),
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12.8,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A6C96),
                    height: 1.5,
                  ),
                )
                    : _RelatedList(ids: recommended, isArabic: isArabic),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _RelatedList extends StatelessWidget {
  const _RelatedList({required this.ids, required this.isArabic});
  final List<String> ids;
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection('patient_stories');

    return Column(
      children: ids.map((id) {
        return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: ref.doc(id).get(),
          builder: (context, snap) {
            if (!snap.hasData || !snap.data!.exists) return const SizedBox.shrink();
            final d = snap.data!.data() ?? {};
            final title = (d['title'] ?? '').toString();
            final excerpt = (d['excerpt'] ?? '').toString();

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F6FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE3EBFF)),
              ),
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => StoryViewPage(storyId: id, isArabic: isArabic)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.chevron_right, color: Color(0xFF5A6C96)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title.isEmpty ? _t('Story', 'قصة') : title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.8,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1B2B55),
                            ),
                          ),
                          if (excerpt.trim().isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              excerpt,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.2,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF5A6C96),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
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
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1B2B55),
                  ),
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
