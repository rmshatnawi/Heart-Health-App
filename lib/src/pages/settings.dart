// lib/src/pages/settings.dart
import 'package:flutter/material.dart';
import '../components/app_menu.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _cardMaxWidth = 520.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: SafeArea(
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        const Expanded(
                          child: Text(
                            'Settings',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const AppMenuButton(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const ListTile(
                      leading: Icon(Icons.notifications_none),
                      title: Text('Notifications'),
                      subtitle: Text('Placeholder'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.palette_outlined),
                      title: Text('Appearance'),
                      subtitle: Text('Placeholder'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
