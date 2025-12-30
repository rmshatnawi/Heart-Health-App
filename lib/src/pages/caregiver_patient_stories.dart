// lib/src/pages/caregiver_patient_stories.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';

import 'caregiver_story_feed.dart';
import 'caregiver_story_journal.dart';

class PatientStoriesPage extends StatelessWidget {
  const PatientStoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Patient Stories',
      titleAr: 'قصص المرضى',
      headerIcon: Icons.auto_stories_outlined,
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
        _Segmented(
          isArabic: widget.isArabic,
          index: _tab,
          labels: [
            _t('Written', 'مكتوبة'),
            _t('Videos', 'فيديوهات'),
            _t('My Journal', 'مذكرتي'),
          ],
          onChanged: (i) => setState(() => _tab = i),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Builder(
            builder: (_) {
              if (_tab == 0) {
                return StoryFeedPage(type: 'text', isArabic: widget.isArabic);
              } else if (_tab == 1) {
                return StoryFeedPage(type: 'video', isArabic: widget.isArabic);
              } else {
                return StoryJournalPage(isArabic: widget.isArabic);
              }
            },
          ),
        ),
      ],
    );
  }
}

class _Segmented extends StatelessWidget {
  const _Segmented({
    required this.isArabic,
    required this.index,
    required this.labels,
    required this.onChanged,
  });

  final bool isArabic;
  final int index;
  final List<String> labels;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Row(
        children: List.generate(labels.length, (i) {
          final selected = i == index;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onChanged(i),
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? const Color(0xFF2F73FF) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  labels[i],
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w900,
                    color: selected ? Colors.white : const Color(0xFF1B2B55),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
