// lib/src/pages/diseases.dart
import 'package:flutter/material.dart';
import '../components/app_menu.dart';

class DiseasesPage extends StatelessWidget {
  const DiseasesPage({super.key});

  // Fixed frame size (phone frame) as requested.
  static const double _phoneWidth = 412.0;
  static const double _phoneHeight = 917.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Outside-of-phone background (web background)
      backgroundColor: const Color(0xFFEEF2FA),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: _phoneWidth,
            height: _phoneHeight,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 22,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  color: const Color(0xFFF3F6FF),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const _Header(),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
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
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _IntroCard(),
                              SizedBox(height: 14),
                              _DiseaseItem(
                                title: 'Ventricular Septal Defect (VSD)',
                                description:
                                'A hole in the wall separating the heart’s two lower chambers (ventricles), allowing oxygen-rich and oxygen-poor blood to mix.',
                              ),
                              _DiseaseItem(
                                title: 'Atrial Septal Defect (ASD)',
                                description:
                                'An opening in the wall between the heart’s two upper chambers (atria), causing abnormal blood flow.',
                              ),
                              _DiseaseItem(
                                title: 'Tetralogy of Fallot',
                                description:
                                'A combination of four heart defects that affect blood flow through the heart and reduce oxygen levels.',
                              ),
                              _DiseaseItem(
                                title: 'Patent Ductus Arteriosus (PDA)',
                                description:
                                'A persistent opening between two major blood vessels leaving the heart that normally closes after birth.',
                              ),
                              _DiseaseItem(
                                title: 'Coarctation of the Aorta',
                                description:
                                'A narrowing of the aorta that restricts blood flow to the body.',
                              ),
                              _DiseaseItem(
                                title: 'Transposition of Great Arteries',
                                description:
                                'The two main arteries leaving the heart are reversed, disrupting normal oxygen circulation.',
                              ),
                              _DiseaseItem(
                                title: 'Pulmonary Stenosis',
                                description:
                                'Narrowing of the pulmonary valve, reducing blood flow from the heart to the lungs.',
                              ),
                              _DiseaseItem(
                                title: 'Aortic Stenosis',
                                description:
                                'Narrowing of the aortic valve opening, restricting blood flow to the body.',
                              ),
                              _DiseaseItem(
                                title: 'Hypoplastic Left Heart Syndrome',
                                description:
                                'A rare condition where the left side of the heart is critically underdeveloped.',
                              ),
                              _DiseaseItem(
                                title: 'Tricuspid Atresia',
                                description:
                                'The tricuspid valve is missing or malformed, blocking normal blood flow between heart chambers.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* ================= HEADER ================= */

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1BAA8B), Color(0xFF138C73)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
          ),
          const SizedBox(width: 4),
          const Expanded(
            child: Text(
              'Diseases',
              style: TextStyle(
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

/* ================= CONTENT ================= */

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF6F2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Congenital Heart Diseases',
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1B2B55),
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Congenital heart diseases (CHD) are structural problems with the heart present at birth. Below are common types and their characteristics.',
            style: TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w500,
              color: Color(0xFF5B677A),
            ),
          ),
        ],
      ),
    );
  }
}

class _DiseaseItem extends StatelessWidget {
  final String title;
  final String description;

  const _DiseaseItem({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF2FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.favorite,
                color: Color(0xFF1BAA8B),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
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
