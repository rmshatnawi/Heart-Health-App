// lib/src/components/chd_scaffold.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../state/language_controller.dart';
import '../pages/login.dart';
import '../pages/profile.dart' as profile_page;
import '../pages/settings.dart' as settings_page;
import '../pages/privacy.dart' as privacy_page;

class ChdScaffold extends StatelessWidget {
  const ChdScaffold({
    super.key,
    required this.titleEn,
    required this.titleAr,
    required this.headerIcon,
    required this.child,
    this.showBack = true,
  });

  final String titleEn;
  final String titleAr;
  final IconData headerIcon;
  final Widget Function(bool isArabic) child;
  final bool showBack;

  static const double _phoneMaxWidth = 412.0;
  static const _accent = Color(0xFF21899C);
  static const _tileBlue = Color(0xFF2F73FF);

  @override
  Widget build(BuildContext context) {
    final lang = LanguageScope.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEEF2FA),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _phoneMaxWidth),
            child: Padding(
              padding: const EdgeInsets.all(12),
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
                    padding: const EdgeInsets.all(14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 230),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
                            child: Row(
                              children: [
                                if (showBack)
                                  IconButton(
                                    tooltip: 'Back',
                                    icon: const Icon(Icons.arrow_back, color: _accent),
                                    onPressed: () => Navigator.of(context).maybePop(),
                                  )
                                else
                                  const SizedBox(width: 8),

                                const Spacer(),

                                PopupMenuButton<_ChdMenuAction>(
                                  tooltip: 'Menu',
                                  icon: const Icon(Icons.settings, color: _accent),
                                  onSelected: (action) async {
                                    switch (action) {
                                      case _ChdMenuAction.profile:
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const profile_page.ProfilePage(),
                                          ),
                                        );
                                        break;

                                      case _ChdMenuAction.settings:
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const settings_page.SettingsPage(),
                                          ),
                                        );
                                        break;

                                      case _ChdMenuAction.privacy:
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const privacy_page.PrivacyPage(),
                                          ),
                                        );
                                        break;

                                      case _ChdMenuAction.logout:
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
                                      value: _ChdMenuAction.profile,
                                      child: Row(
                                        children: [
                                          Icon(Icons.person_outline, size: 18),
                                          SizedBox(width: 10),
                                          Text('Profile'),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: _ChdMenuAction.settings,
                                      child: Row(
                                        children: [
                                          Icon(Icons.tune, size: 18),
                                          SizedBox(width: 10),
                                          Text('Settings'),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: _ChdMenuAction.privacy,
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
                                      value: _ChdMenuAction.logout,
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

                                const SizedBox(width: 6),

                                // Global EN/AR toggle
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: lang.toggle,
                                      child: Center(
                                        child: Text(
                                          lang.isArabic ? 'AR' : 'EN',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800,
                                            color: _accent,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: Image.asset(
                                    'assets/images/logonly.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(18, 10, 18, 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: _tileBlue,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(headerIcon, color: Colors.white, size: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    lang.t(titleEn, titleAr),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1B2B55),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 235),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: child(lang.isArabic),
                                ),
                              ),
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

enum _ChdMenuAction { profile, settings, privacy, logout }
