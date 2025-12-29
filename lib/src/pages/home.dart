import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'medical_info.dart';
import 'calculator.dart';
import 'payment.dart';
import 'store.dart';
import 'solutions.dart';
import 'wellness.dart';
import 'documents.dart';
import 'consultation.dart';
import 'patient_care.dart';
import 'login.dart';

import 'profile.dart' as profile_page;
import 'settings.dart' as settings_page;
import 'privacy.dart' as privacy_page;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Fixed frame size (phone frame) as requested.
  static const double _phoneWidth = 412.0;
  static const double _phoneHeight = 917.0;

  static const _accent = Color(0xFF21899C);
  static const _tileBlue = Color(0xFF2F73FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is the "outside of the phone" background (web page background).
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
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFD9E9FF), Color(0xFFCFE2FF)],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 230),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const _HeaderMenu(),
                          const SizedBox(height: 14),
                          const Text(
                            'Healthcare Services',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1B2B55),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Fill the remaining height with the grid,
                          // and compute aspect ratio so tiles expand vertically (no empty space).
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, gridBox) {
                                const cols = 3;
                                const rows = 3;
                                const spacing = 14.0;

                                final w = gridBox.maxWidth;
                                final h = gridBox.maxHeight;

                                final tileW =
                                    (w - spacing * (cols - 1)) / cols;
                                final tileH =
                                    (h - spacing * (rows - 1)) / rows;

                                final aspect =
                                (tileH <= 0) ? 1.0 : (tileW / tileH);

                                return GridView(
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: cols,
                                    mainAxisSpacing: spacing,
                                    crossAxisSpacing: spacing,
                                    childAspectRatio: aspect,
                                  ),
                                  children: [
                                    _HomeTile(
                                      title: 'Medical Info',
                                      icon: Icons.favorite_border,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                            const MedicalInfoPage(),
                                          ),
                                        );
                                      },
                                    ),
                                    _HomeTile(
                                      title: 'Medical Store',
                                      icon: Icons.store,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const StorePage(),
                                          ),
                                        );
                                      },
                                    ),
                                    _HomeTile(
                                      title: 'Calculator',
                                      icon: Icons.calculate,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                            const CalculatorPage(),
                                          ),
                                        );
                                      },
                                    ),
                                    _HomeTile(
                                      title: 'Payment',
                                      icon: Icons.attach_money,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                            const PaymentPage(),
                                          ),
                                        );
                                      },
                                    ),
                                    _HomeTile(
                                      title: 'Solutions',
                                      icon: Icons.menu_book,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                            const SolutionsPage(),
                                          ),
                                        );
                                      },
                                    ),
                                    _HomeTile(
                                      title: 'Outlook on\nWellness',
                                      icon: Icons.show_chart,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                            const WellnessPage(),
                                          ),
                                        );
                                      },
                                    ),
                                    _HomeTile(
                                      title: 'Documents',
                                      icon: Icons.description,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                            const DocumentsPage(),
                                          ),
                                        );
                                      },
                                    ),
                                    _HomeTile(
                                      title: 'Medical\nConsultation',
                                      icon: Icons.medical_services,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                            const MedicalConsultationPage(),
                                          ),
                                        );
                                      },
                                    ),
                                    _HomeTile(
                                      title: 'Patient Care',
                                      icon: Icons.person,
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                            const PatientCarePage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
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
      ),
    );
  }
}

class _HeaderMenu extends StatelessWidget {
  const _HeaderMenu();

  static const _accent = Color(0xFF21899C);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton<_HomeMenuAction>(
          tooltip: 'Menu',
          icon: const Icon(Icons.settings, color: _accent),
          onSelected: (action) async {
            switch (action) {
              case _HomeMenuAction.profile:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const profile_page.ProfilePage(),
                  ),
                );
                break;

              case _HomeMenuAction.settings:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const settings_page.SettingsPage(),
                  ),
                );
                break;

              case _HomeMenuAction.privacy:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const privacy_page.PrivacyPage(),
                  ),
                );
                break;

              case _HomeMenuAction.logout:
                await FirebaseAuth.instance.signOut();
                if (!context.mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                );
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: _HomeMenuAction.profile,
              child: Row(
                children: [
                  Icon(Icons.person_outline, size: 18),
                  SizedBox(width: 10),
                  Text('Profile'),
                ],
              ),
            ),
            PopupMenuItem(
              value: _HomeMenuAction.settings,
              child: Row(
                children: [
                  Icon(Icons.tune, size: 18),
                  SizedBox(width: 10),
                  Text('Settings'),
                ],
              ),
            ),
            PopupMenuItem(
              value: _HomeMenuAction.privacy,
              child: Row(
                children: [
                  Icon(Icons.lock_outline, size: 18),
                  SizedBox(width: 10),
                  Text('Privacy'),
                ],
              ),
            ),
            PopupMenuDivider(),
            PopupMenuItem(
              value: _HomeMenuAction.logout,
              child: Row(
                children: [
                  Icon(Icons.logout, size: 18, color: Colors.red),
                  SizedBox(width: 10),
                  Text('Log out'),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 44,
          height: 44,
          child: Image.asset(
            'assets/images/logonly.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}

enum _HomeMenuAction { profile, settings, privacy, logout }

class _HomeTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const _HomeTile({
    required this.title,
    required this.icon,
    this.onTap,
  });

  static const _tileBlue = Color(0xFF2F73FF);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 160),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: _tileBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1B2B55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}