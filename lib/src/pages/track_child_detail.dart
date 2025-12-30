// lib/src/pages/track_child_detail.dart

import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';
import 'track_your_child.dart';

class TrackChildDetailPage extends StatelessWidget {
  const TrackChildDetailPage({super.key, required this.child});
  final ChildProfile child;

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: child.name,
      titleAr: child.name,
      headerIcon: Icons.badge_outlined,
      child: (isArabic) => _DetailBody(isArabic: isArabic, child: child),
    );
  }
}

class _DetailBody extends StatefulWidget {
  const _DetailBody({required this.isArabic, required this.child});
  final bool isArabic;
  final ChildProfile child;

  @override
  State<_DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<_DetailBody> {
  int _tab = 0;

  String _t(String en, String ar) => widget.isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _t('Profile', 'الملف'),
      _t('Medications', 'الأدوية'),
      _t('Appointments', 'المواعيد'),
      _t('Lab Tests', 'التحاليل'),
      _t('Hospital Tracking', 'تتبّع المستشفى'),
    ];

    return Column(
      children: [
        _TabBar(labels: tabs, index: _tab, onChanged: (i) => setState(() => _tab = i)),
        const SizedBox(height: 12),
        Expanded(
          child: _tab == 0
              ? _ProfileTab(
            isArabic: widget.isArabic,
            child: widget.child,
          )
              : _tab == 1
              ? _MedsTab(
            isArabic: widget.isArabic,
            child: widget.child,
            onChanged: () => setState(() {}),
          )
              : _tab == 2
              ? _AppointmentsTab(
            isArabic: widget.isArabic,
            child: widget.child,
            onChanged: () => setState(() {}),
          )
              : _tab == 3
              ? _LabsTab(
            isArabic: widget.isArabic,
            child: widget.child,
          )
              : _HospitalTrackingTab(
            isArabic: widget.isArabic,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.labels, required this.index, required this.onChanged});
  final List<String> labels;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Row(
        children: List.generate(labels.length, (i) {
          final selected = i == index;
          return Expanded(
            child: Material(
              color: selected ? const Color(0xFF2F73FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => onChanged(i),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      labels[i],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w900,
                        color: selected ? Colors.white : const Color(0xFF1B2B55),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/* ===========================
   TAB 1: PROFILE
=========================== */

class _ProfileTab extends StatelessWidget {
  const _ProfileTab({required this.isArabic, required this.child});
  final bool isArabic;
  final ChildProfile child;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final age = child.ageString(isArabic: isArabic);
    final gender = child.gender == Gender.male ? _t('Male', 'ذكر') : _t('Female', 'أنثى');

    return ListView(
      children: [
        _Box(
          title: _t('Child Info', 'معلومات الطفل'),
          icon: Icons.child_care_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kv(_t('Name', 'الاسم'), child.name),
              _kv(_t('Gender', 'الجنس'), gender),
              _kv(_t('Date of birth', 'تاريخ الميلاد'), _fmtDate(child.dob)),
              _kv(_t('Age', 'العمر'), age),
              _kv(_t('Weight', 'الوزن'), _t('${child.weightKg.toStringAsFixed(1)} kg', '${child.weightKg.toStringAsFixed(1)} كغ')),
              _kv(_t('Other conditions', 'حالات أخرى'), child.otherConditions.join(', ')),
            ],
          ),
        ),
        _Box(
          title: _t('Hospital Record', 'معلومات المستشفى'),
          icon: Icons.local_hospital_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kv(_t('Medical Record Number (MRN)', 'رقم الملف الطبي'), child.mrn),
              const SizedBox(height: 10),
              Text(
                _t('Responsible Doctors', 'الأطباء المسؤولون'),
                style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w900, color: Color(0xFF1B2B55)),
              ),
              const SizedBox(height: 8),
              ...child.doctors.map(
                    (d) => _MiniCard(
                  title: d.name,
                  subtitle: d.specialty,
                  trailing: d.phone.trim().isEmpty ? null : _t('Call', 'اتصال'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '$k: $v',
        style: const TextStyle(
          fontSize: 12.7,
          fontWeight: FontWeight.w700,
          color: Color(0xFF5A6C96),
          height: 1.45,
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

/* ===========================
   TAB 2: MEDICATIONS
=========================== */

class _MedsTab extends StatelessWidget {
  const _MedsTab({required this.isArabic, required this.child, required this.onChanged});
  final bool isArabic;
  final ChildProfile child;
  final VoidCallback onChanged;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    if (child.medications.isEmpty) {
      return Center(
        child: Text(
          _t('No medications added.', 'لا توجد أدوية مضافة.'),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96)),
        ),
      );
    }

    return ListView(
      children: child.medications.map((m) {
        final instr = isArabic
            ? (m.instructionsAr.isEmpty ? m.instructionsEn : m.instructionsAr)
            : (m.instructionsEn.isEmpty ? m.instructionsAr : m.instructionsEn);
        final times = m.times.join(' • ');

        return _Box(
          title: '${m.name} — ${m.dose}',
          icon: Icons.medication_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                instr,
                style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96), height: 1.45),
              ),
              const SizedBox(height: 10),
              Text(
                _t('Times: $times', 'الأوقات: $times'),
                style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w800, color: Color(0xFF1B2B55)),
              ),
              const SizedBox(height: 10),
              _ToggleRow(
                label: _t('Medication reminder', 'تذكير الدواء'),
                value: m.remindersEnabled,
                onChanged: (v) {
                  m.remindersEnabled = v;
                  onChanged();
                },
              ),
              const SizedBox(height: 6),
              Text(
                _t('', ''),
                style: const TextStyle(fontSize: 12.2, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

/* ===========================
   TAB 3: APPOINTMENTS
=========================== */

class _AppointmentsTab extends StatelessWidget {
  const _AppointmentsTab({required this.isArabic, required this.child, required this.onChanged});
  final bool isArabic;
  final ChildProfile child;
  final VoidCallback onChanged;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    if (child.appointments.isEmpty) {
      return Center(
        child: Text(
          _t('No appointments added.', 'لا توجد مواعيد مضافة.'),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96)),
        ),
      );
    }

    final sorted = [...child.appointments]..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return ListView(
      children: sorted.map((a) {
        final title = isArabic ? (a.titleAr.isEmpty ? a.titleEn : a.titleAr) : (a.titleEn.isEmpty ? a.titleAr : a.titleEn);
        final notes = isArabic ? (a.notesAr.isEmpty ? a.notesEn : a.notesAr) : (a.notesEn.isEmpty ? a.notesAr : a.notesEn);

        return _Box(
          title: title,
          icon: Icons.event_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _t('Date: ${_fmtDateTime(a.dateTime)}', 'التاريخ: ${_fmtDateTime(a.dateTime)}'),
                style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w800, color: Color(0xFF1B2B55)),
              ),
              const SizedBox(height: 6),
              Text(
                _t('Doctor: ${a.doctor}', 'الطبيب: ${a.doctor}'),
                style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Color(0xFF5A6C96)),
              ),
              const SizedBox(height: 10),
              Text(
                notes,
                style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96), height: 1.45),
              ),
              const SizedBox(height: 10),
              _ToggleRow(
                label: _t('Appointment reminder', 'تذكير الموعد'),
                value: a.reminderEnabled,
                onChanged: (v) {
                  a.reminderEnabled = v;
                  onChanged();
                },
              ),
              const SizedBox(height: 6),
              Text(
                _t('', ''),
                style: const TextStyle(fontSize: 12.2, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _fmtDateTime(DateTime d) {
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} $hh:$mm';
  }
}

/* ===========================
   TAB 4: LAB TESTS
=========================== */

class _LabsTab extends StatelessWidget {
  const _LabsTab({required this.isArabic, required this.child});
  final bool isArabic;
  final ChildProfile child;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    if (child.labTests.isEmpty) {
      return Center(
        child: Text(
          _t('No lab results available.', 'لا توجد نتائج تحاليل.'),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96)),
        ),
      );
    }

    final sorted = [...child.labTests]..sort((a, b) => b.date.compareTo(a.date));

    return ListView(
      children: [
        _Box(
          title: _t('Lab results (Hospital-added)', 'نتائج التحاليل (يضيفها المستشفى)'),
          icon: Icons.biotech_outlined,
          child: Text(
            _t('', ''),
            style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96), height: 1.45),
          ),
        ),
        ...sorted.map((l) {
          final name = isArabic ? l.nameAr : l.nameEn;
          final result = isArabic ? l.resultAr : l.resultEn;
          return _Box(
            title: name,
            icon: Icons.science_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _t('Date: ${_fmtDate(l.date)}', 'التاريخ: ${_fmtDate(l.date)}'),
                  style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w800, color: Color(0xFF1B2B55)),
                ),
                const SizedBox(height: 10),
                Text(
                  result,
                  style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96), height: 1.45),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  String _fmtDate(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

/* ===========================
   TAB 5: HOSPITAL TRACKING
   BP + SpO2 + Feeding
=========================== */

class _HospitalTrackingTab extends StatelessWidget {
  const _HospitalTrackingTab({required this.isArabic, required this.child});
  final bool isArabic;
  final ChildProfile child;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final ht = child.hospitalTracking;
    if (ht == null || ht.isHospitalized == false) {
      return Center(
        child: Text(
          _t('Child is not hospitalized.', 'الطفل غير منوّم.'),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96)),
        ),
      );
    }

    final ward = isArabic ? (ht.wardAr.isEmpty ? ht.wardEn : ht.wardAr) : (ht.wardEn.isEmpty ? ht.wardAr : ht.wardEn);

    final bp = [...ht.bpEntries]..sort((a, b) => b.time.compareTo(a.time));
    final spo2 = [...ht.spo2Entries]..sort((a, b) => b.time.compareTo(a.time));
    final feed = [...ht.feedingEntries]..sort((a, b) => b.time.compareTo(a.time));

    return ListView(
      children: [
        _Box(
          title: _t('Admission', 'معلومات التنويم'),
          icon: Icons.local_hospital_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kv(_t('Ward', 'القسم'), ward),
              _kv(_t('Bed', 'السرير'), ht.bed),
              const SizedBox(height: 6),
              Text(
                _t(' hospital-entered data .', 'بيانات مدخلة من المستشفى .'),
                style: const TextStyle(fontSize: 12.3, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96)),
              ),
            ],
          ),
        ),
        _VitalsSection(
          isArabic: isArabic,
          titleEn: 'Blood Pressure (BP)',
          titleAr: 'ضغط الدم',
          icon: Icons.monitor_heart_outlined,
          entries: bp
              .map((e) => _LineEntry(
            left: _fmtDateTime(e.time),
            main: '${e.systolic}/${e.diastolic} mmHg',
            sub: isArabic ? (e.noteAr.isEmpty ? e.noteEn : e.noteAr) : (e.noteEn.isEmpty ? e.noteAr : e.noteEn),
          ))
              .toList(),
        ),
        _VitalsSection(
          isArabic: isArabic,
          titleEn: 'Pulse Oximetry (SpO₂)',
          titleAr: 'تشبع الأكسجين (SpO₂)',
          icon: Icons.bloodtype_outlined,
          entries: spo2
              .map((e) => _LineEntry(
            left: _fmtDateTime(e.time),
            main: '${e.spo2}%  •  ${_t('Pulse', 'النبض')}: ${e.pulse} bpm',
            sub: isArabic ? (e.noteAr.isEmpty ? e.noteEn : e.noteAr) : (e.noteEn.isEmpty ? e.noteAr : e.noteEn),
          ))
              .toList(),
        ),
        _FeedingSection(isArabic: isArabic, entries: feed),
      ],
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        '$k: $v',
        style: const TextStyle(fontSize: 12.7, fontWeight: FontWeight.w700, color: Color(0xFF5A6C96), height: 1.45),
      ),
    );
  }

  String _fmtDateTime(DateTime d) {
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} $hh:$mm';
  }
}

class _VitalsSection extends StatelessWidget {
  const _VitalsSection({
    required this.isArabic,
    required this.titleEn,
    required this.titleAr,
    required this.icon,
    required this.entries,
  });

  final bool isArabic;
  final String titleEn;
  final String titleAr;
  final IconData icon;
  final List<_LineEntry> entries;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    return _Box(
      title: _t(titleEn, titleAr),
      icon: icon,
      child: entries.isEmpty
          ? Text(_t('No entries.', 'لا توجد قراءات.'), style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96)))
          : Column(
        children: entries
            .map((e) => Padding(padding: const EdgeInsets.only(bottom: 10), child: _EntryRow(entry: e)))
            .toList(),
      ),
    );
  }
}

class _FeedingSection extends StatelessWidget {
  const _FeedingSection({required this.isArabic, required this.entries});
  final bool isArabic;
  final List<FeedingEntry> entries;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    return _Box(
      title: _t('Feeding', 'التغذية'),
      icon: Icons.restaurant_outlined,
      child: entries.isEmpty
          ? Text(_t('No entries.', 'لا توجد سجلات.'), style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96)))
          : Column(
        children: entries.map((f) {
          final type = switch (f.type) {
            FeedingType.oral => _t('Oral', 'فموي'),
            FeedingType.ngTube => _t('NG Tube', 'أنبوب أنفي معدي'),
            FeedingType.iv => _t('IV', 'وريدي'),
          };
          final tol = switch (f.tolerance) {
            FeedingTolerance.good => _t('Good', 'جيد'),
            FeedingTolerance.mildIssues => _t('Mild issues', 'مشاكل بسيطة'),
            FeedingTolerance.poor => _t('Poor', 'ضعيف'),
          };
          final note = isArabic ? (f.noteAr.isEmpty ? f.noteEn : f.noteAr) : (f.noteEn.isEmpty ? f.noteAr : f.noteEn);

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _EntryRow(
              entry: _LineEntry(
                left: _fmtDateTime(f.time),
                main: '$type • ${_t('Amount', 'الكمية')}: ${f.amountMl} ml • ${_t('Tolerance', 'التحمّل')}: $tol',
                sub: note,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _fmtDateTime(DateTime d) {
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} $hh:$mm';
  }
}

class _LineEntry {
  const _LineEntry({required this.left, required this.main, required this.sub});
  final String left;
  final String main;
  final String sub;
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.entry});
  final _LineEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(entry.left, style: const TextStyle(fontSize: 12.2, fontWeight: FontWeight.w900, color: Color(0xFF1B2B55))),
        const SizedBox(height: 6),
        Text(entry.main, style: const TextStyle(fontSize: 12.6, fontWeight: FontWeight.w800, color: Color(0xFF1B2B55))),
        if (entry.sub.trim().isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(entry.sub, style: const TextStyle(fontSize: 12.4, fontWeight: FontWeight.w600, color: Color(0xFF5A6C96), height: 1.35)),
        ],
      ]),
    );
  }
}

/* ===========================
   SHARED UI WIDGETS
=========================== */

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({required this.label, required this.value, required this.onChanged});
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 12.8, fontWeight: FontWeight.w800, color: Color(0xFF1B2B55))),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
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
        color: Colors.white.withValues(alpha: 235),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3EBFF)),
        boxShadow: const [
          BoxShadow(color: Color(0x11000000), blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF1B2B55)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ]),
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({required this.title, required this.subtitle, this.trailing});
  final String title;
  final String subtitle;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 12.8, fontWeight: FontWeight.w900, color: Color(0xFF1B2B55))),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 12.2, fontWeight: FontWeight.w700, color: Color(0xFF5A6C96))),
            ]),
          ),
          if (trailing != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5FF),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFFE3EBFF)),
              ),
              child: Text(trailing!, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: Color(0xFF1B2B55))),
            ),
        ],
      ),
    );
  }
}
