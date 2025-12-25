// lib/src/components/app_menu.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/login.dart';
import '../pages/profile.dart';
import '../pages/settings.dart';
import '../pages/privacy.dart';

enum AppMenuAction { profile, settings, privacy, logout }

class AppMenuButton extends StatelessWidget {
  const AppMenuButton({super.key, this.iconColor = const Color(0xFF21899C)});

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AppMenuAction>(
      tooltip: 'Menu',
      icon: Icon(Icons.settings, color: iconColor),
      onSelected: (action) async {
        switch (action) {
          case AppMenuAction.profile:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
            break;
          case AppMenuAction.settings:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            );
            break;
          case AppMenuAction.privacy:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const PrivacyPage()),
            );
            break;
          case AppMenuAction.logout:
            await FirebaseAuth.instance.signOut();
            if (!context.mounted) return;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
            );
            break;
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: AppMenuAction.profile,
          child: Row(
            children: [
              Icon(Icons.person_outline, size: 18),
              SizedBox(width: 10),
              Text('Profile'),
            ],
          ),
        ),
        PopupMenuItem(
          value: AppMenuAction.settings,
          child: Row(
            children: [
              Icon(Icons.tune, size: 18),
              SizedBox(width: 10),
              Text('Settings'),
            ],
          ),
        ),
        PopupMenuItem(
          value: AppMenuAction.privacy,
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
          value: AppMenuAction.logout,
          child: Row(
            children: [
              Icon(Icons.logout, size: 18, color: Colors.red),
              SizedBox(width: 10),
              Text('Log out'),
            ],
          ),
        ),
      ],
    );
  }
}
