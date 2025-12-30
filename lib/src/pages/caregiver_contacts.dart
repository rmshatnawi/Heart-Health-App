// lib/src/pages/caregiver_contacts.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/chd_scaffold.dart';

class CaregiverContactsPage extends StatelessWidget {
  const CaregiverContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Contacts',
      titleAr: 'جهات الاتصال',
      headerIcon: Icons.contact_phone_outlined,
      child: (isArabic) => _ContactsBody(isArabic: isArabic),
    );
  }
}

class _ContactsBody extends StatelessWidget {
  const _ContactsBody({required this.isArabic});
  final bool isArabic;

  String _t(String en, String ar) => isArabic ? ar : en;

  Future<void> _launch(BuildContext context, String raw) async {
    final uri = Uri.tryParse(raw.trim());
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t('Invalid link', 'رابط غير صالح'))),
      );
      return;
    }
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t('Could not open', 'تعذر الفتح'))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _Box(
          title: _t('LLU Phone Numbers & Email', 'أرقام LLU والبريد'),
          icon: Icons.phone_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _RowLine(label: _t('Phone', 'هاتف'), value: '+1 800 000 0000'),
              const SizedBox(height: 6),
              _RowLine(label: _t('Email', 'بريد'), value: 'support@llu.example'),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () => _launch(context, 'tel:+18000000000'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F73FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        child: Text(
                          _t('Call', 'اتصال'),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () => _launch(context, 'mailto:support@llu.example'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF21899C),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        child: Text(
                          _t('Email', 'بريد'),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        _Box(
          title: _t('Local Resources', 'موارد محلية'),
          icon: Icons.place_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _RowLine(label: _t('Phone', 'هاتف'), value: '+962 7 9000 0000'),
              const SizedBox(height: 6),
              _RowLine(label: _t('Email', 'بريد'), value: 'help@local.example'),
              const SizedBox(height: 6),
              _RowLine(label: _t('Website', 'موقع'), value: 'https://www.google.com/search?q=Jordan+caregiver+support+resources'),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () => _launch(context, 'https://www.google.com/search?q=Jordan+caregiver+support+resources'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F73FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text(
                    _t('Open Website', 'فتح الموقع'),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RowLine extends StatelessWidget {
  const _RowLine({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F6FF),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFFE3EBFF)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w900,
              color: Color(0xFF21899C),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12.8,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5A6C96),
            ),
          ),
        ),
      ],
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({required this.title, required this.icon, required this.child});
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3EBFF)),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 4)),
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
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
