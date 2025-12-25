// lib/src/pages/_simple_info_page.dart
import 'package:flutter/material.dart';
import '../components/app_menu.dart';

class InfoSection {
  final String title;
  final String subtitle;

  /// Color of the section header strip.
  final Color headerBg;

  /// Optional: color used for item titles/icons. If null, headerBg is used.
  final Color? accent;

  final List<InfoItem> items;

  const InfoSection({
    required this.title,
    this.subtitle = '',
    required this.headerBg,
    this.accent,
    required this.items,
  });
}

class InfoItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const InfoItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });
}

class SimpleInfoPage extends StatelessWidget {
  const SimpleInfoPage({
    super.key,
    required this.title,
    required this.headerIcon,
    required this.gradient,
    this.sections,
  });

  final String title;
  final IconData headerIcon;
  final List<Color> gradient;

  // Optional: when provided, show real designed content
  final List<InfoSection>? sections;

  static const _cardMaxWidth = 520.0;

  @override
  Widget build(BuildContext context) {
    final hasSections = sections != null && sections!.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _cardMaxWidth),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Header(
                    title: title,
                    gradient: gradient,
                    showBack: true,
                  ),

                  // Content container under the header (phone-like fixed card)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 230),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 14,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: hasSections
                        ? _SectionsBody(sections: sections!)
                        : _PlaceholderBody(headerIcon: headerIcon, title: title),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceholderBody extends StatelessWidget {
  const _PlaceholderBody({
    required this.headerIcon,
    required this.title,
  });

  final IconData headerIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF2F73FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(headerIcon, color: Colors.white),
          ),
          const SizedBox(height: 14),
          Text(
            '$title page (placeholder)',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF5B677A),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Content will be added later.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF6B768A),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _SectionsBody extends StatelessWidget {
  const _SectionsBody({required this.sections});
  final List<InfoSection> sections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final s = sections[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _SectionCard(section: s),
        );
      },
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.section});
  final InfoSection section;

  @override
  Widget build(BuildContext context) {
    final accent = section.accent ?? section.headerBg;
    final hasSubtitle = section.subtitle.trim().isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE7ECF5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Colored header strip (like your design)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
            decoration: BoxDecoration(
              color: section.headerBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                if (hasSubtitle) ...[
                  const SizedBox(height: 6),
                  Text(
                    section.subtitle,
                    style: TextStyle(
                      fontSize: 12.8,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 210),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // White body with items
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              children: [
                for (int i = 0; i < section.items.length; i++) ...[
                  _InfoTile(item: section.items[i], accent: accent),
                  if (i != section.items.length - 1) const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.item, required this.accent});
  final InfoItem item;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7ECF5)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ICON WITHOUT BACKGROUND
            Icon(
              item.icon,
              color: item.iconColor,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 14.2,
                      fontWeight: FontWeight.w900,
                      color: accent,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 13.2,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B768A),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.gradient,
    required this.showBack,
  });

  final String title;
  final List<Color> gradient;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            )
          else
            const SizedBox(width: 48),
          const SizedBox(width: 2),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const AppMenuButton(iconColor: Colors.white),
          const SizedBox(width: 8),
          SizedBox(
            width: 44,
            height: 44,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/logonly.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
