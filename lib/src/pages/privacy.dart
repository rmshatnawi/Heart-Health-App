// lib/src/pages/privacy.dart
import 'package:flutter/material.dart';
import '../components/app_menu.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  // frame size
  static const _frameW = 412.0;
  static const _frameH = 917.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: SafeArea(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26), // rounder edges
            child: SizedBox(
              width: _frameW,
              height: _frameH,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
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
                              'Privacy',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const AppMenuButton(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const ListTile(
                        leading: Icon(Icons.lock_outline),
                        title: Text('Privacy Policy'),
                        subtitle: Text('Placeholder'),
                      ),
                      const Divider(),
                      const ListTile(
                        leading: Icon(Icons.shield_outlined),
                        title: Text('Data Controls'),
                        subtitle: Text('Placeholder'),
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
