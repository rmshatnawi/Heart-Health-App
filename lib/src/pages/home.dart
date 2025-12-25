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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _cardMaxWidth = 520.0;
  static const _accent = Color(0xFF21899C);
  static const _tileBlue = Color(0xFF2F73FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD9E9FF), Color(0xFFCFE2FF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _cardMaxWidth),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 230),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _HeaderMenu(),
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

                      // Fixed "phone-like" grid inside a fixed-width card
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // inside the fixed card, use a stable 3 columns
                          const crossAxisCount = 3;

                          // Fixed tile shape (prevents “web-like stretching”)
                          const childAspectRatio = 0.86;

                          return GridView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 14,
                              childAspectRatio: childAspectRatio,
                            ),
                            children: [
                              _HomeTile(
                                title: 'Medical Info',
                                icon: Icons.favorite_border,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const MedicalInfoPage()),
                                  );
                                },
                              ),
                              _HomeTile(
                                title: 'Medical Store',
                                icon: Icons.store,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const StorePage()),
                                  );
                                },
                              ),
                              _HomeTile(
                                title: 'Calculator',
                                icon: Icons.calculate,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const CalculatorPage()),
                                  );
                                },
                              ),
                              _HomeTile(
                                title: 'Payment',
                                icon: Icons.attach_money,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const PaymentPage()),
                                  );
                                },
                              ),
                              _HomeTile(
                                title: 'Solutions',
                                icon: Icons.menu_book,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const SolutionsPage()),
                                  );
                                },
                              ),
                              _HomeTile(
                                title: 'Outlook on Wellness',
                                icon: Icons.show_chart,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const WellnessPage()),
                                  );
                                },
                              ),
                              _HomeTile(
                                title: 'Documents',
                                icon: Icons.description,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const DocumentsPage()),
                                  );
                                },
                              ),
                              _HomeTile(
                                title: 'Medical Consultation',
                                icon: Icons.medical_services,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const MedicalConsultationPage()),
                                  );
                                },
                              ),
                              _HomeTile(
                                title: 'Patient Care',
                                icon: Icons.person,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => const PatientCarePage()),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
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
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
                break;

              case _HomeMenuAction.settings:
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
                break;

              case _HomeMenuAction.privacy:
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PrivacyPage()),
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

/* =========================
   Simple pages (no errors)
   ========================= */

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF21899C),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(user?.email ?? 'No email'),
            subtitle: Text(user?.uid ?? ''),
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF21899C),
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.notifications_none),
              title: Text('Notifications'),
              subtitle: Text('Basic placeholder'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.palette_outlined),
              title: Text('Appearance'),
              subtitle: Text('Basic placeholder'),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
        backgroundColor: const Color(0xFF21899C),
        foregroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Privacy Policy'),
              subtitle: Text('Basic placeholder'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shield_outlined),
              title: Text('Data Controls'),
              subtitle: Text('Basic placeholder'),
            ),
          ],
        ),
      ),
    );
  }
}
