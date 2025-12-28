// lib/src/pages/gcc_vaccines.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/chd_scaffold.dart';
import '../components/content_blocks.dart';

class GccVaccinesPage extends StatelessWidget {
  const GccVaccinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Vaccines',
      titleAr: 'اللقاحات',
      headerIcon: Icons.vaccines_outlined,
      child: (isArabic) => _GccBlocksPageBody(
        isArabic: isArabic,
        pageId: 'general_childcare_vaccines',
      ),
    );
  }
}

class _GccBlocksPageBody extends StatelessWidget {
  const _GccBlocksPageBody({
    required this.isArabic,
    required this.pageId,
  });

  final bool isArabic;
  final String pageId;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection('content_pages').doc(pageId);

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ref.snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          final msg = snap.error.toString();
          return Center(
            child: Text(
              isArabic ? 'خطأ في تحميل البيانات:\n$msg' : 'Failed to load data:\n$msg',
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
              _t('No content yet.', 'لا يوجد محتوى بعد.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        final data = snap.data!.data();
        final blocks = (data?['blocks'] as List<dynamic>? ?? const []);

        return ContentBlocks(blocks: blocks, isArabic: isArabic);
      },
    );
  }
}
