// lib/src/pages/coping_tools_category.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/chd_scaffold.dart';

class CopingToolsCategoryPage extends StatelessWidget {
  const CopingToolsCategoryPage({
    super.key,
    required this.categoryId,
    required this.titleEn,
    required this.titleAr,
    required this.icon,
  });

  final String categoryId;
  final String titleEn;
  final String titleAr;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: titleEn.isEmpty ? 'Coping Tools' : titleEn,
      titleAr: titleAr.isEmpty ? 'أدوات للتكيف' : titleAr,
      headerIcon: icon,
      child: (isArabic) => _CategoryBody(isArabic: isArabic, categoryId: categoryId),
    );
  }
}

class _CategoryBody extends StatelessWidget {
  const _CategoryBody({required this.isArabic, required this.categoryId});
  final bool isArabic;
  final String categoryId;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance
        .collection('content_pages')
        .doc('coping_tools')
        .collection('categories')
        .doc(categoryId);

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ref.snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text(
              _t('Failed to load content.', 'فشل تحميل المحتوى.'),
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
              _t('No content yet.', 'لا يوجد محتوى بعد.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          );
        }

        final data = snap.data!.data() ?? {};
        final items = (data['items'] as List<dynamic>? ?? const [])
            .map((e) => (e as Map).cast<String, dynamic>())
            .toList();

        if (items.isEmpty) {
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

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, i) {
            final it = items[i];
            final type = (it['type'] ?? 'text').toString();

            final titleEn = (it['titleEn'] ?? '').toString();
            final titleAr = (it['titleAr'] ?? '').toString();
            final descEn = (it['descEn'] ?? '').toString();
            final descAr = (it['descAr'] ?? '').toString();

            final bodyEn = (it['bodyEn'] ?? '').toString();
            final bodyAr = (it['bodyAr'] ?? '').toString();
            final url = (it['url'] ?? '').toString();

            final title = isArabic ? (titleAr.isEmpty ? titleEn : titleAr) : (titleEn.isEmpty ? titleAr : titleEn);
            final desc = isArabic ? (descAr.isEmpty ? descEn : descAr) : (descEn.isEmpty ? descAr : descEn);
            final body = isArabic ? (bodyAr.isEmpty ? bodyEn : bodyAr) : (bodyEn.isEmpty ? bodyAr : bodyEn);

            return _ToolBox(
              title: title.isEmpty ? _t('Tool', 'أداة') : title,
              subtitle: desc,
              icon: _iconForType(type),
              child: _buildContent(context, type, body, url),
            );
          },
        );
      },
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'video':
        return Icons.play_circle_outline;
      case 'audio':
        return Icons.headphones_outlined;
      case 'link':
        return Icons.link;
      default:
        return Icons.article_outlined;
    }
  }

  Widget _buildContent(BuildContext context, String type, String body, String url) {
    if (type == 'link' || type == 'video' || type == 'audio') {
      return _LinkBlock(isArabic: isArabic, url: url);
    }

    return Text(
      body.trim().isEmpty ? _t('No text.', 'لا يوجد نص.') : body,
      textAlign: isArabic ? TextAlign.right : TextAlign.left,
      style: const TextStyle(
        fontSize: 12.8,
        fontWeight: FontWeight.w600,
        color: Color(0xFF5A6C96),
        height: 1.55,
      ),
    );
  }
}

class _LinkBlock extends StatelessWidget {
  const _LinkBlock({required this.isArabic, required this.url});
  final bool isArabic;
  final String url;

  String _t(String en, String ar) => isArabic ? ar : en;

  Future<void> _open(BuildContext context) async {
    final uri = Uri.tryParse(url.trim());
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
    final clean = url.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          clean.isEmpty ? _t('No URL.', 'لا يوجد رابط.') : clean,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            fontSize: 12.6,
            fontWeight: FontWeight.w800,
            color: clean.isEmpty ? const Color(0xFF5A6C96) : const Color(0xFF2F73FF),
            decoration: clean.isEmpty ? null : TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 44,
          child: ElevatedButton(
            onPressed: clean.isEmpty ? null : () => _open(context),
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
    );
  }
}

class _ToolBox extends StatelessWidget {
  const _ToolBox({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
  });

  final String title;
  final String subtitle;
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
          if (subtitle.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
                height: 1.35,
              ),
            ),
          ],
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
