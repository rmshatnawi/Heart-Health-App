// lib/src/pages/patient_story_detail.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/chd_scaffold.dart';

class PatientStoryDetailPage extends StatelessWidget {
  const PatientStoryDetailPage({
    super.key,
    required this.isCommunity,
    required this.storyId,
    required this.titleEn,
    required this.titleAr,
    required this.bodyEn,
    required this.bodyAr,
    required this.mediaType,
    required this.mediaUrl,
    required this.tags,
  });

  final bool isCommunity;
  final String storyId;
  final String titleEn;
  final String titleAr;
  final String bodyEn;
  final String bodyAr;
  final String mediaType; // none | video | image
  final String mediaUrl;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: titleEn.isEmpty ? 'Story' : titleEn,
      titleAr: titleAr.isEmpty ? 'قصة' : titleAr,
      headerIcon: Icons.favorite_border,
      child: (isArabic) => _DetailBody(
        isArabic: isArabic,
        titleEn: titleEn,
        titleAr: titleAr,
        bodyEn: bodyEn,
        bodyAr: bodyAr,
        mediaType: mediaType,
        mediaUrl: mediaUrl,
        tags: tags,
        storyId: storyId,
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({
    required this.isArabic,
    required this.titleEn,
    required this.titleAr,
    required this.bodyEn,
    required this.bodyAr,
    required this.mediaType,
    required this.mediaUrl,
    required this.tags,
    required this.storyId,
  });

  final bool isArabic;
  final String titleEn;
  final String titleAr;
  final String bodyEn;
  final String bodyAr;
  final String mediaType;
  final String mediaUrl;
  final List<String> tags;
  final String storyId;

  String _t(String en, String ar) => isArabic ? ar : en;

  Future<void> _openUrl(BuildContext context) async {
    final uri = Uri.tryParse(mediaUrl.trim());
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t('Invalid URL', 'رابط غير صالح'))),
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
    final title = isArabic ? (titleAr.isEmpty ? titleEn : titleAr) : (titleEn.isEmpty ? titleAr : titleEn);
    final body = isArabic ? (bodyAr.isEmpty ? bodyEn : bodyAr) : (bodyEn.isEmpty ? bodyAr : bodyEn);

    return ListView(
      children: [
        _Box(
          title: _t('Story', 'القصة'),
          icon: Icons.article_outlined,
          child: Text(
            body.trim().isEmpty ? _t('No text.', 'لا يوجد نص.') : body,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: const TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5A6C96),
              height: 1.5,
            ),
          ),
        ),
        if (tags.isNotEmpty)
          _Box(
            title: _t('Tags', 'الوسوم'),
            icon: Icons.sell_outlined,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags
                  .map(
                    (t) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5FF),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: const Color(0xFFE3EBFF)),
                  ),
                  child: Text(
                    t,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B2B55),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        if (mediaUrl.trim().isNotEmpty)
          _Box(
            title: _t(mediaType == 'video' ? 'Video link' : 'Link', mediaType == 'video' ? 'رابط الفيديو' : 'الرابط'),
            icon: mediaType == 'video' ? Icons.play_circle_outline : Icons.link,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  mediaUrl,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(
                    fontSize: 12.6,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2F73FF),
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => _openUrl(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F73FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: Text(
                      _t('Open', 'فتح'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        _RelatedStoriesBox(
          isArabic: isArabic,
          currentStoryId: storyId,
          currentTags: tags,
        ),
      ],
    );
  }
}

class _RelatedStoriesBox extends StatelessWidget {
  const _RelatedStoriesBox({
    required this.isArabic,
    required this.currentStoryId,
    required this.currentTags,
  });

  final bool isArabic;
  final String currentStoryId;
  final List<String> currentTags;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    // Simple “ML-like” baseline: tag-overlap ranking computed client-side.
    final q = FirebaseFirestore.instance
        .collection('stories')
        .where('status', isEqualTo: 'approved')
        .where('visibility', isEqualTo: 'public')
        .orderBy('createdAt', descending: true)
        .limit(80);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: q.snapshots(),
      builder: (context, snap) {
        if (!snap.hasData || snap.data!.docs.isEmpty || currentTags.isEmpty) {
          return _Box(
            title: _t('Related stories', 'قصص مشابهة'),
            icon: Icons.auto_awesome_outlined,
            child: Text(
              _t('No related stories yet.', 'لا توجد قصص مشابهة بعد.'),
              style: const TextStyle(
                fontSize: 12.8,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        final docs = snap.data!.docs
            .where((d) => d.id != currentStoryId)
            .toList();

        int score(List<String> a, List<String> b) {
          final sa = a.map((e) => e.toLowerCase()).toSet();
          final sb = b.map((e) => e.toLowerCase()).toSet();
          return sa.intersection(sb).length;
        }

        final scored = docs
            .map((d) {
          final m = d.data();
          final tags = _asStrList(m['tags']);
          return (_RelDoc(d: d, tags: tags, s: score(currentTags, tags)));
        })
            .where((x) => x.s > 0)
            .toList()
          ..sort((a, b) => b.s.compareTo(a.s));

        final top = scored.take(5).toList();

        if (top.isEmpty) {
          return _Box(
            title: _t('Related stories', 'قصص مشابهة'),
            icon: Icons.auto_awesome_outlined,
            child: Text(
              _t('No related stories yet.', 'لا توجد قصص مشابهة بعد.'),
              style: const TextStyle(
                fontSize: 12.8,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        return _Box(
          title: _t('Related stories', 'قصص مشابهة'),
          icon: Icons.auto_awesome_outlined,
          child: Column(
            children: top.map((x) {
              final m = x.d.data();
              final title = (m['title'] ?? '').toString().trim();
              final body = (m['body'] ?? '').toString().trim();
              return _MiniRow(
                title: title.isEmpty ? _t('Story', 'قصة') : title,
                subtitle: body,
                badge: '${x.s}',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PatientStoryDetailPage(
                        isCommunity: true,
                        storyId: x.d.id,
                        titleEn: title,
                        titleAr: '',
                        bodyEn: body,
                        bodyAr: '',
                        mediaUrl: (m['mediaUrl'] ?? '').toString(),
                        mediaType: (m['mediaType'] ?? 'none').toString(),
                        tags: x.tags,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _RelDoc {
  const _RelDoc({required this.d, required this.tags, required this.s});
  final QueryDocumentSnapshot<Map<String, dynamic>> d;
  final List<String> tags;
  final int s;
}

class _MiniRow extends StatelessWidget {
  const _MiniRow({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F8FF),
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
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.8,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.2,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5A6C96),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF2F73FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, color: Color(0xFF5A6C96)),
            ],
          ),
        ),
      ),
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
        color: Colors.white.withValues(alpha: 235),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3EBFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
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

List<String> _asStrList(dynamic v) {
  if (v is List) return v.map((e) => e.toString()).where((s) => s.trim().isNotEmpty).toList();
  return const [];
}
