// lib/src/pages/medications.dart
import 'package:flutter/material.dart';
import '../components/app_menu.dart';

class MedicationsPage extends StatelessWidget {
  const MedicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(
      title: 'Medications',
      headerIcon: Icons.local_pharmacy_outlined,
      gradient: [Color(0xFF6D5AE6), Color(0xFF5646D8)],
      showLanguageChip: false,
      showPhoneFrame: true,
      content: _MedicationsContent(),
    );
  }
}



class SimpleInfoPage extends StatelessWidget {
  const SimpleInfoPage({
    super.key,
    required this.title,
    required this.headerIcon,
    required this.gradient,
    required this.content,
    this.showLanguageChip = false,
    this.showPhoneFrame = true,
  });

  final String title;
  final IconData headerIcon;
  final List<Color> gradient;
  final Widget content;
  final bool showLanguageChip;
  final bool showPhoneFrame;

  static const _phoneMaxWidth = 520.0;

  @override
  Widget build(BuildContext context) {
    final pageBody = Column(
      children: [
        _Header(
          title: title,
          headerIcon: headerIcon,
          gradient: gradient,
          showBack: true,
          showLanguageChip: showLanguageChip,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: content,
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: SafeArea(
        child: showPhoneFrame
            ? Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _phoneMaxWidth),
            child: pageBody,
          ),
        )
            : pageBody,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.headerIcon,
    required this.gradient,
    required this.showBack,
    required this.showLanguageChip,
  });

  final String title;
  final IconData headerIcon;
  final List<Color> gradient;
  final bool showBack;
  final bool showLanguageChip;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
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
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
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
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          // settings/menu
          const AppMenuButton(iconColor: Colors.white),

          const SizedBox(width: 8),

          // logo (same size as icon)
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

          if (showLanguageChip) ...[
            const SizedBox(width: 10),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 40),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 60),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.language_rounded, size: 18, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    'EN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/* =========================================================
   Medications screen content (matches your design)
   ========================================================= */

class _MedicationsContent extends StatelessWidget {
  const _MedicationsContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [

        SizedBox(height: 14),

        _MedicationCard(
          name: 'Digoxin (Lanoxin)',
          description:
          'Helps the heart pump more effectively and controls heart rate',
          dosage: 'Usually given once or twice daily',
        ),
        _MedicationCard(
          name: 'Furosemide (Lasix)',
          description:
          'Diuretic that removes extra fluid from the body, reducing heart workload',
          dosage: 'Typically given once or twice daily',
        ),
        _MedicationCard(
          name: 'Captopril (Capoten)',
          description:
          'ACE inhibitor that relaxes blood vessels and lowers blood pressure',
          dosage: 'Usually given 2–3 times daily',
        ),
        _MedicationCard(
          name: 'Enalapril (Vasotec)',
          description:
          'Helps blood vessels relax, making it easier for the heart to pump',
          dosage: 'Typically given once or twice daily',
        ),
        _MedicationCard(
          name: 'Spironolactone (Aldactone)',
          description:
          'Diuretic that helps remove fluid while preserving potassium',
          dosage: 'Usually given once or twice daily',
        ),
        _MedicationCard(
          name: 'Aspirin',
          description: 'Prevents blood clots and reduces risk of blockages',
          dosage: 'Given once daily, usually in the morning',
        ),
        _MedicationCard(
          name: 'Propranolol (Inderal)',
          description:
          'Beta-blocker that slows heart rate and reduces blood pressure',
          dosage: 'Typically given 2–3 times daily',
        ),

        SizedBox(height: 14),

        _InfoBox(
          title: 'Important Safety Notes',
          icon: Icons.info_outline_rounded,
          bg: Color(0xFFFFF3D6),
          border: Color(0xFFE9D39A),
          titleColor: Color(0xFF8A6A12),
          bullets: [
            'Always give medications at the same time each day',
            'Never skip or double doses without consulting your doctor',
            'Store medications in a cool, dry place away from children',
            'Keep a list of all medications with you at all times',
          ],
        ),

        SizedBox(height: 14),

        _InfoBox(
          title: 'When to Contact Your Doctor',
          icon: Icons.info_outline_rounded,
          bg: Color(0xFFFFE6EA),
          border: Color(0xFFE7A7B5),
          titleColor: Color(0xFF8A1D3D),
          bullets: [
            'Unusual tiredness or weakness',
            'Changes in heart rate or breathing',
            'Vomiting or refusing to eat',
            'Swelling in face, hands, or feet',
            'Rash or allergic reactions',
          ],
        ),
      ],
    );
  }
}

/* =========================
   UI pieces
   ========================= */

class _TitleStrip extends StatelessWidget {
  const _TitleStrip({
    required this.title,
    required this.icon,
    required this.iconBg,
    required this.stripBg,
    required this.stripBorder,
  });

  final String title;
  final IconData icon;
  final Color iconBg;
  final Color stripBg;
  final Color stripBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: stripBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: stripBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1B2B55),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  const _MedicationCard({
    required this.name,
    required this.description,
    required this.dosage,
  });

  final String name;
  final String description;
  final String dosage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7ECF5)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.favorite_border,
              color: Color(0xFF6D5AE6),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1B2B55),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12.8,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B768A),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    dosage,
                    style: const TextStyle(
                      fontSize: 12.2,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7A8598),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({
    required this.title,
    required this.icon,
    required this.bg,
    required this.border,
    required this.titleColor,
    required this.bullets,
  });

  final String title;
  final IconData icon;
  final Color bg;
  final Color border;
  final Color titleColor;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: titleColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: titleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...bullets.map(
                (b) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: titleColor.withValues(alpha: 170),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5B677A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
