// lib/src/pages/patient_stories.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/chd_scaffold.dart';
import 'patient_story_detail.dart';

class PatientStoriesPage extends StatelessWidget {
  const PatientStoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Patient Stories',
      titleAr: 'قصص المرضى',
      headerIcon: Icons.ondemand_video_outlined,
      child: (isArabic) => _PatientStoriesBody(isArabic: isArabic),
    );
  }
}

class _PatientStoriesBody extends StatefulWidget {
  const _PatientStoriesBody({required this.isArabic});
  final bool isArabic;

  @override
  State<_PatientStoriesBody> createState() => _PatientStoriesBodyState();
}

class _PatientStoriesBodyState extends State<_PatientStoriesBody> {
  int _tab = 0;

  String _t(String en, String ar) => widget.isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Tabs(
          isArabic: widget.isArabic,
          index: _tab,
          onChanged: (i) => setState(() => _tab = i),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _tab == 0
              ? _FeaturedStories(isArabic: widget.isArabic)
              : _CommunityStories(isArabic: widget.isArabic),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 46,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              final uid = FirebaseAuth.instance.currentUser?.uid;
              if (uid == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_t('Please log in first.', 'يرجى تسجيل الدخول أولاً.'))),
                );
                return;
              }
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => _AddStorySheet(isArabic: widget.isArabic),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F73FF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text(
              _t('Add your story', 'أضف قصتك'),
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
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({
    required this.isArabic,
    required this.index,
    required this.onChanged,
  });

  final bool isArabic;
  final int index;
  final ValueChanged<int> onChanged;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabBtn(
              text: _t('Featured', 'مميزة'),
              selected: index == 0,
              onTap: () => onChanged(0),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _TabBtn(
              text: _t('Community', 'المجتمع'),
              selected: index == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBtn extends StatelessWidget {
  const _TabBtn({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFF2F73FF) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: selected ? Colors.white : const Color(0xFF1B2B55),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedStories extends StatelessWidget {
  const _FeaturedStories({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance
        .collection('content_pages')
        .doc('caregiver_support')
        .collection('categories')
        .doc('patient_stories');

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ref.snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text(
              _t('Failed to load featured stories.', 'فشل تحميل القصص المميزة.'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF9A2A2A),
              ),
            ),
          );
        }
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snap.hasData || !snap.data!.exists) {
          return Center(
            child: Text(
              _t('No featured stories yet.', 'لا توجد قصص مميزة بعد.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        final data = snap.data!.data() ?? {};
        final items = (data['items'] as List<dynamic>? ?? const []);

        if (items.isEmpty) {
          return Center(
            child: Text(
              _t('No featured stories yet.', 'لا توجد قصص مميزة بعد.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, i) {
            final m = (items[i] as Map).cast<String, dynamic>();
            final titleEn = (m['titleEn'] ?? '').toString();
            final titleAr = (m['titleAr'] ?? '').toString();
            final descEn = (m['descEn'] ?? '').toString();
            final descAr = (m['descAr'] ?? '').toString();
            final url = (m['url'] ?? '').toString();
            final tags = _asStrList(m['tags']);

            final title = isArabic ? (titleAr.isEmpty ? titleEn : titleAr) : (titleEn.isEmpty ? titleAr : titleEn);
            final desc = isArabic ? (descAr.isEmpty ? descEn : descAr) : (descEn.isEmpty ? descAr : descEn);

            return _StoryCard(
              title: title.isEmpty ? _t('Story', 'قصة') : title,
              subtitle: desc,
              badge: _t('Featured', 'مميزة'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PatientStoryDetailPage(
                      isCommunity: false,
                      storyId: 'featured_$i',
                      titleEn: titleEn,
                      titleAr: titleAr,
                      bodyEn: descEn,
                      bodyAr: descAr,
                      mediaUrl: url,
                      mediaType: url.trim().isEmpty ? 'none' : 'video',
                      tags: tags,
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

class _CommunityStories extends StatelessWidget {
  const _CommunityStories({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final q = FirebaseFirestore.instance
        .collection('stories')
        .where('status', isEqualTo: 'approved')
        .where('visibility', isEqualTo: 'public')
        .orderBy('createdAt', descending: true)
        .limit(50);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: q.snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text(
              _t('Failed to load community stories.', 'فشل تحميل قصص المجتمع.'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
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
              _t('No community stories yet.', 'لا توجد قصص من المجتمع بعد.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, i) {
            final d = docs[i];
            final m = d.data();

            final title = (m['title'] ?? '').toString();
            final body = (m['body'] ?? '').toString();
            final lang = (m['lang'] ?? 'mixed').toString();
            final tags = _asStrList(m['tags']);
            final mediaType = (m['mediaType'] ?? 'none').toString();
            final mediaUrl = (m['mediaUrl'] ?? '').toString();

            final showTitle = title.trim().isEmpty ? _t('Story', 'قصة') : title;
            final badge = _t('Community', 'المجتمع');

            // Basic language choice: if story has lang=en/ar, show accordingly; otherwise show as-is.
            final subtitle = body;

            return _StoryCard(
              title: showTitle,
              subtitle: subtitle,
              badge: badge,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PatientStoryDetailPage(
                      isCommunity: true,
                      storyId: d.id,
                      titleEn: lang == 'ar' ? '' : showTitle,
                      titleAr: lang == 'ar' ? showTitle : '',
                      bodyEn: lang == 'ar' ? '' : body,
                      bodyAr: lang == 'ar' ? body : '',
                      mediaUrl: mediaUrl,
                      mediaType: mediaType,
                      tags: tags,
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
    required this.badge,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String badge;
  final VoidCallback onTap;

  static const _tileBlue = Color(0xFF2F73FF);

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _tileBlue,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.favorite_border, color: Colors.white, size: 22),
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
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1B2B55),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5FF),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: const Color(0xFFE3EBFF)),
                          ),
                          child: Text(
                            badge,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1B2B55),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5A6C96),
                        height: 1.35,
                      ),
                    ),
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

List<String> _asStrList(dynamic v) {
  if (v is List) return v.map((e) => e.toString()).where((s) => s.trim().isNotEmpty).toList();
  return const [];
}

class _AddStorySheet extends StatefulWidget {
  const _AddStorySheet({required this.isArabic});
  final bool isArabic;

  @override
  State<_AddStorySheet> createState() => _AddStorySheetState();
}

class _AddStorySheetState extends State<_AddStorySheet> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  final _tags = TextEditingController();
  bool _public = true;
  bool _loading = false;
  String? _err;

  String _t(String en, String ar) => widget.isArabic ? ar : en;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    _tags.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final title = _title.text.trim();
    final body = _body.text.trim();
    final tags = _tags.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (body.length < 20) {
      setState(() => _err = _t('Story is too short (min 20 chars).', 'القصة قصيرة جداً (الحد الأدنى 20 حرف).'));
      return;
    }

    setState(() {
      _loading = true;
      _err = null;
    });

    try {
      await FirebaseFirestore.instance.collection('stories').add({
        'authorUid': uid,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending', // moderation gate
        'visibility': _public ? 'public' : 'private',
        'lang': widget.isArabic ? 'ar' : 'en',
        'title': title,
        'body': body,
        'mediaType': 'none',
        'mediaUrl': '',
        'tags': tags,
      });

      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t('Submitted for review.', 'تم الإرسال للمراجعة.'))),
      );
    } catch (e) {
      setState(() {
        _err = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE3EBFF)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 22,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _t('Add your story', 'أضف قصتك'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1B2B55),
                  ),
                ),
                const SizedBox(height: 12),
                _Input(
                  controller: _title,
                  hint: _t('Title (optional)', 'العنوان (اختياري)'),
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                _Input(
                  controller: _body,
                  hint: _t('Write your story...', 'اكتب قصتك...'),
                  maxLines: 6,
                ),
                const SizedBox(height: 10),
                _Input(
                  controller: _tags,
                  hint: _t('Tags (comma separated) e.g. surgery, NICU', 'وسوم (بفواصل) مثل: عملية, حضّانة'),
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Switch(
                      value: _public,
                      onChanged: _loading ? null : (v) => setState(() => _public = v),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _public ? _t('Public', 'عام') : _t('Private', 'خاص'),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1B2B55),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_err != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _err!,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF9A2A2A),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submit,
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
                      _t('Submit', 'إرسال'),
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
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({
    required this.controller,
    required this.hint,
    required this.maxLines,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1B2B55),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: Color(0xFF7A8AB3),
        ),
        filled: true,
        fillColor: const Color(0xFFF6F8FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE3EBFF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE3EBFF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF2F73FF), width: 1.2),
        ),
      ),
    );
  }
}
