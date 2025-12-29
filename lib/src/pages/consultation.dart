// lib/src/pages/medical_consultation.dart
import 'package:flutter/material.dart';

enum DoctorStatus { available, busy, offline }

class MedicalConsultationPage extends StatefulWidget {
  const MedicalConsultationPage({super.key});

  @override
  State<MedicalConsultationPage> createState() => _MedicalConsultationPageState();
}

class _MedicalConsultationPageState extends State<MedicalConsultationPage> {
  // Frame spec (412x917) + rounder edges
  static const double _frameW = 412;
  static const double _frameH = 917;
  static const double _frameRadius = 28;

  int _filterIndex = 0; // 0=All, 1=Available, 2=Busy, 3=Offline

  final List<_Doctor> _doctors = const [
    _Doctor(
      name: 'Dr. Sarah Mitchell',
      specialty: 'Cardiologist',
      rating: 4.9,
      reviews: 127,
      years: 15,
      status: DoctorStatus.available,
      imageUrl:
      'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=1200&q=60',
    ),
    _Doctor(
      name: 'Dr. Michael Chen',
      specialty: 'General Physician',
      rating: 4.8,
      reviews: 203,
      years: 12,
      status: DoctorStatus.available,
      imageUrl:
      'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=1200&q=60',
    ),
    _Doctor(
      name: 'Dr. Emily Rodriguez',
      specialty: 'Pediatrician',
      rating: 5.0,
      reviews: 189,
      years: 10,
      status: DoctorStatus.busy,
      imageUrl:
      'https://images.unsplash.com/photo-1580281658628-30b2f32623d9?auto=format&fit=crop&w=1200&q=60',
    ),
    _Doctor(
      name: 'Dr. Adam Johnson',
      specialty: 'Dermatologist',
      rating: 4.7,
      reviews: 98,
      years: 9,
      status: DoctorStatus.offline,
      imageUrl:
      'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=1200&q=60',
    ),
  ];

  List<_Doctor> get _filtered {
    if (_filterIndex == 0) return _doctors;
    final wanted = switch (_filterIndex) {
      1 => DoctorStatus.available,
      2 => DoctorStatus.busy,
      _ => DoctorStatus.offline,
    };
    return _doctors.where((d) => d.status == wanted).toList();
  }

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF2F73FF);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_frameRadius),
            child: SizedBox(
              width: _frameW,
              height: _frameH,
              child: Column(
                children: [
                  _TopHeader(
                    title: 'Medical Consultation',
                    subtitle: '',
                    icon: Icons.medical_information_outlined,
                    headerColor: blue,
                    onBack: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 10),
                  _buildFilters(),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, i) => _DoctorCard(doctor: _filtered[i]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    final items = const ['All Doctors', 'Available', 'Busy', 'Offline'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(items.length, (i) {
          final selected = _filterIndex == i;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(items[i]),
              selected: selected,
              onSelected: (_) => setState(() => _filterIndex = i),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : const Color(0xFF475569),
              ),
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFF2F73FF),
              side: BorderSide(
                color: selected ? Colors.transparent : const Color(0xFFE2E8F0),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          );
        }),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color headerColor;
  final VoidCallback onBack;

  const _TopHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.headerColor,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: headerColor,
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xE6FFFFFF),
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

class _DoctorCard extends StatelessWidget {
  final _Doctor doctor;
  const _DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      doctor.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFEFF6FF),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.person,
                          size: 54,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: _statusPill(doctor.status),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialty,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 18, color: Color(0xFFF59E0B)),
                        const SizedBox(width: 4),
                        Text(
                          doctor.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•  ${doctor.reviews} reviews',
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${doctor.years} years experience',
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: _actionButton(
                            label: 'Video',
                            icon: Icons.videocam_rounded,
                            bg: const Color(0xFFEFF6FF),
                            fg: const Color(0xFF2F73FF),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _actionButton(
                            label: 'Voice',
                            icon: Icons.call_rounded,
                            bg: const Color(0xFFECFDF5),
                            fg: const Color(0xFF10B981),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _actionButton(
                            label: 'Chat',
                            icon: Icons.chat_bubble_rounded,
                            bg: const Color(0xFFFDF2FF),
                            fg: const Color(0xFFA855F7),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusPill(DoctorStatus status) {
    final (bg, fg, label) = switch (status) {
      DoctorStatus.available => (const Color(0xFF16A34A), Colors.white, 'Available Now'),
      DoctorStatus.busy => (const Color(0xFFF59E0B), Colors.white, 'Busy'),
      DoctorStatus.offline => (const Color(0xFF94A3B8), Colors.white, 'Offline'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required Color bg,
    required Color fg,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: fg),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: fg,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final int years;
  final DoctorStatus status;
  final String imageUrl;

  const _Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.years,
    required this.status,
    required this.imageUrl,
  });
}
