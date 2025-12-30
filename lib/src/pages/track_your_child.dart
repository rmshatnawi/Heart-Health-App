// lib/src/pages/track_your_child.dart
import 'package:flutter/material.dart';
import '../components/chd_scaffold.dart';
import 'track_child_detail.dart';

class TrackYourChildPage extends StatelessWidget {
  const TrackYourChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Track Your Child',
      titleAr: 'تتبّع طفلك',
      headerIcon: Icons.monitor_heart_outlined,
      child: (isArabic) => _TrackYourChildBody(isArabic: isArabic),
    );
  }
}

class _TrackYourChildBody extends StatefulWidget {
  const _TrackYourChildBody({required this.isArabic});
  final bool isArabic;

  @override
  State<_TrackYourChildBody> createState() => _TrackYourChildBodyState();
}

class _TrackYourChildBodyState extends State<_TrackYourChildBody> {
  late final List<ChildProfile> _children;

  String _t(String en, String ar) => widget.isArabic ? ar : en;

  @override
  void initState() {
    super.initState();
    _children = _fakeChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBar(
          title: _t('Your Children', 'أطفالك'),
          subtitle: _t('Tap a child to view records, schedules, and hospital tracking.', 'اضغط على الطفل لعرض السجلات والجداول وتتبع المستشفى.'),
          primaryText: _t('Add Child', 'إضافة طفل'),
          onPrimary: _openAddChildSheet,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _children.isEmpty
              ? Center(
            child: Text(
              _t('No children added yet.', 'لم يتم إضافة أطفال بعد.'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A6C96),
              ),
            ),
          )
              : ListView.builder(
            itemCount: _children.length,
            itemBuilder: (context, i) {
              final c = _children[i];
              return _ChildCard(
                isArabic: widget.isArabic,
                child: c,
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => TrackChildDetailPage(child: c)))
                      .then((_) => setState(() {}));
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _openAddChildSheet() async {
    final created = await showModalBottomSheet<ChildProfile>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddChildSheet(isArabic: widget.isArabic),
    );
    if (created != null) {
      setState(() => _children.add(created));
    }
  }

  List<ChildProfile> _fakeChildren() {
    return [
      ChildProfile(
        id: 'c1',
        name: 'Lina',
        gender: Gender.female,
        dob: DateTime(2022, 4, 18),
        weightKg: 11.4,
        otherConditions: ['Asthma (mild)'],
        mrn: 'KAUH-CHD-10482',
        doctors: [
          Doctor(name: 'Dr. Ahmad Al-Khateeb', specialty: 'Pediatric Cardiology', phone: '+962 7X XXX XXXX'),
          Doctor(name: 'Dr. Rana Nassar', specialty: 'Pediatrics', phone: '+962 7X XXX XXXX'),
        ],
        medications: [
          MedicationPlan(
            id: 'm1',
            name: 'Furosemide',
            dose: '10 mg',
            instructionsEn: 'Give after breakfast.',
            instructionsAr: 'يُعطى بعد الإفطار.',
            times: const ['08:30'],
            remindersEnabled: true,
          ),
          MedicationPlan(
            id: 'm2',
            name: 'Aspirin',
            dose: '81 mg',
            instructionsEn: 'Give with food.',
            instructionsAr: 'يُعطى مع الطعام.',
            times: const ['20:00'],
            remindersEnabled: false,
          ),
        ],
        appointments: [
          Appointment(
            id: 'a1',
            dateTime: DateTime.now().add(const Duration(days: 12, hours: 2)),
            titleEn: 'Cardiology Follow-up',
            titleAr: 'متابعة قلب أطفال',
            doctor: 'Dr. Ahmad Al-Khateeb',
            notesEn: 'Bring recent echo report. Discuss fatigue episodes.',
            notesAr: 'إحضار تقرير الإيكو الأخير. مناقشة نوبات التعب.',
            reminderEnabled: true,
          ),
        ],
        labTests: [
          LabTest(
            id: 'l1',
            nameEn: 'CBC (Complete Blood Count)',
            nameAr: 'صورة دم كاملة',
            date: DateTime.now().subtract(const Duration(days: 18)),
            resultEn: 'Within normal range.',
            resultAr: 'ضمن الحدود الطبيعية.',
            source: LabSource.hospital,
          ),
        ],
        hospitalTracking: HospitalTracking(
          isHospitalized: true,
          wardEn: 'Pediatric Cardiology Ward',
          wardAr: 'قسم قلب الأطفال',
          bed: 'B-12',
          bpEntries: [
            BloodPressureEntry(
              time: DateTime.now().subtract(const Duration(hours: 6)),
              systolic: 92,
              diastolic: 58,
              noteEn: 'Calm, resting.',
              noteAr: 'هادئة وفي وضع راحة.',
            ),
            BloodPressureEntry(
              time: DateTime.now().subtract(const Duration(hours: 2)),
              systolic: 96,
              diastolic: 60,
              noteEn: 'After walking.',
              noteAr: 'بعد الحركة.',
            ),
          ],
          spo2Entries: [
            PulseOxEntry(
              time: DateTime.now().subtract(const Duration(hours: 5, minutes: 30)),
              spo2: 94,
              pulse: 112,
              noteEn: 'Room air.',
              noteAr: 'هواء الغرفة.',
            ),
            PulseOxEntry(
              time: DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
              spo2: 96,
              pulse: 105,
              noteEn: 'Improved after rest.',
              noteAr: 'تحسّن بعد الراحة.',
            ),
          ],
          feedingEntries: [
            FeedingEntry(
              time: DateTime.now().subtract(const Duration(hours: 7)),
              type: FeedingType.oral,
              amountMl: 120,
              tolerance: FeedingTolerance.good,
              noteEn: 'Finished full feed.',
              noteAr: 'أكملت الوجبة كاملة.',
            ),
            FeedingEntry(
              time: DateTime.now().subtract(const Duration(hours: 3)),
              type: FeedingType.oral,
              amountMl: 90,
              tolerance: FeedingTolerance.mildIssues,
              noteEn: 'Mild spit-up.',
              noteAr: 'ارتجاع بسيط.',
            ),
          ],
        ),
      ),
      ChildProfile(
        id: 'c2',
        name: 'Omar',
        gender: Gender.male,
        dob: DateTime(2019, 11, 7),
        weightKg: 18.9,
        otherConditions: ['None reported'],
        mrn: 'KAUH-CHD-21903',
        doctors: [
          Doctor(name: 'Dr. Samer Huneidi', specialty: 'Pediatric Cardiology', phone: '+962 7X XXX XXXX'),
        ],
        medications: [
          MedicationPlan(
            id: 'm3',
            name: 'Propranolol',
            dose: '5 mg',
            instructionsEn: 'Monitor heart rate; give as scheduled.',
            instructionsAr: 'مراقبة النبض وإعطاء الدواء حسب الجدول.',
            times: const ['07:30', '15:30'],
            remindersEnabled: true,
          ),
        ],
        appointments: [
          Appointment(
            id: 'a3',
            dateTime: DateTime.now().add(const Duration(days: 6, hours: 3)),
            titleEn: 'Echo + Clinic Visit',
            titleAr: 'إيكو + عيادة',
            doctor: 'Dr. Samer Huneidi',
            notesEn: 'Child should be rested before echo.',
            notesAr: 'يفضل أن يكون الطفل مرتاحًا قبل الإيكو.',
            reminderEnabled: true,
          ),
        ],
        labTests: [
          LabTest(
            id: 'l3',
            nameEn: 'Electrolytes',
            nameAr: 'أملاح الدم',
            date: DateTime.now().subtract(const Duration(days: 9)),
            resultEn: 'Sodium/Potassium normal.',
            resultAr: 'الصوديوم/البوتاسيوم طبيعي.',
            source: LabSource.hospital,
          ),
        ],
        hospitalTracking: HospitalTracking(
          isHospitalized: false,
          wardEn: '',
          wardAr: '',
          bed: '',
          bpEntries: const [],
          spo2Entries: const [],
          feedingEntries: const [],
        ),
      ),
    ];
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.primaryText,
    required this.onPrimary,
  });

  final String title;
  final String subtitle;
  final String primaryText;
  final VoidCallback onPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 235),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1B2B55),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A6C96),
                  height: 1.3,
                ),
              ),
            ]),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 42,
            child: ElevatedButton.icon(
              onPressed: onPrimary,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F73FF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              icon: const Icon(Icons.add, color: Colors.white, size: 18),
              label: Text(
                primaryText,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ChildCard extends StatelessWidget {
  const _ChildCard({
    required this.isArabic,
    required this.child,
    required this.onTap,
  });

  final bool isArabic;
  final ChildProfile child;
  final VoidCallback onTap;

  String _t(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final age = child.ageString(isArabic: isArabic);
    final gender = child.gender == Gender.male ? _t('Male', 'ذكر') : _t('Female', 'أنثى');
    final hosp = child.hospitalTracking?.isHospitalized == true;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF2F73FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(hosp ? Icons.local_hospital_outlined : Icons.child_care_outlined, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        child.name,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1B2B55),
                        ),
                      ),
                    ),
                    if (hosp)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5FF),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: const Color(0xFFE3EBFF)),
                        ),
                        child: Text(
                          _t('Hospitalized', 'منوّم'),
                          style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w900, color: Color(0xFF1B2B55)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _t('$age • $gender • ${child.weightKg.toStringAsFixed(1)} kg',
                      '$age • $gender • ${child.weightKg.toStringAsFixed(1)} كغ'),
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A6C96),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _t('MRN: ${child.mrn}', 'رقم الملف: ${child.mrn}'),
                  style: const TextStyle(
                    fontSize: 12.2,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5A6C96),
                  ),
                ),
              ]),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF5A6C96)),
          ],
        ),
      ),
    );
  }
}

class _AddChildSheet extends StatefulWidget {
  const _AddChildSheet({required this.isArabic});
  final bool isArabic;

  @override
  State<_AddChildSheet> createState() => _AddChildSheetState();
}

class _AddChildSheetState extends State<_AddChildSheet> {
  final _name = TextEditingController();
  Gender _gender = Gender.male;
  DateTime _dob = DateTime(2023, 1, 1);
  double _weight = 10.0;
  final _mrn = TextEditingController(text: 'KAUH-CHD-00000');
  final _conditions = TextEditingController(text: 'None');

  String _t(String en, String ar) => widget.isArabic ? ar : en;

  @override
  void dispose() {
    _name.dispose();
    _mrn.dispose();
    _conditions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE3EBFF)),
            boxShadow: const [
              BoxShadow(color: Color(0x22000000), blurRadius: 22, offset: Offset(0, 12)),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text(
                _t('Add Child (Local Demo)', 'إضافة طفل (تجريبي محلي)'),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1B2B55),
                ),
              ),
              const SizedBox(height: 12),
              _Input(hint: _t('Name', 'الاسم'), controller: _name),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _PickBox(
                      title: _t('Gender', 'الجنس'),
                      value: _gender == Gender.male ? _t('Male', 'ذكر') : _t('Female', 'أنثى'),
                      onTap: () => setState(() => _gender = _gender == Gender.male ? Gender.female : Gender.male),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _PickBox(
                      title: _t('Date of Birth', 'تاريخ الميلاد'),
                      value: '${_dob.year}-${_dob.month.toString().padLeft(2, '0')}-${_dob.day.toString().padLeft(2, '0')}',
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _dob,
                          firstDate: DateTime(2000, 1, 1),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) setState(() => _dob = picked);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _PickBox(
                title: _t('Weight (kg)', 'الوزن (كغ)'),
                value: _weight.toStringAsFixed(1),
                onTap: () {},
                trailing: SizedBox(
                  width: 160,
                  child: Slider(
                    value: _weight,
                    min: 2,
                    max: 60,
                    divisions: 580,
                    onChanged: (v) => setState(() => _weight = v),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _Input(hint: _t('Medical Record Number (MRN)', 'رقم الملف الطبي'), controller: _mrn),
              const SizedBox(height: 10),
              _Input(hint: _t('Other health conditions', 'حالات صحية أخرى'), controller: _conditions, maxLines: 2),
              const SizedBox(height: 14),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    final name = _name.text.trim();
                    if (name.isEmpty) return;

                    final child = ChildProfile(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: name,
                      gender: _gender,
                      dob: _dob,
                      weightKg: _weight,
                      otherConditions: [_conditions.text.trim().isEmpty ? 'None' : _conditions.text.trim()],
                      mrn: _mrn.text.trim().isEmpty ? 'KAUH-CHD-00000' : _mrn.text.trim(),
                      doctors: [const Doctor(name: 'Dr. (Demo)', specialty: 'Pediatrics', phone: '')],
                      medications: const [],
                      appointments: const [],
                      labTests: const [],
                      hospitalTracking: HospitalTracking(
                        isHospitalized: false,
                        wardEn: '',
                        wardAr: '',
                        bed: '',
                        bpEntries: const [],
                        spo2Entries: const [],
                        feedingEntries: const [],
                      ),
                    );

                    Navigator.of(context).pop(child);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F73FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: Text(
                    _t('Save', 'حفظ'),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({required this.hint, required this.controller, this.maxLines = 1});
  final String hint;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1B2B55)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Color(0xFF7A8AB3)),
        filled: true,
        fillColor: const Color(0xFFF6F8FF),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE3EBFF))),
        enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFE3EBFF))),
        focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF2F73FF), width: 1.2)),
      ),
    );
  }
}

class _PickBox extends StatelessWidget {
  const _PickBox({
    required this.title,
    required this.value,
    required this.onTap,
    this.trailing,
  });

  final String title;
  final String value;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontSize: 11.8, fontWeight: FontWeight.w900, color: Color(0xFF1B2B55))),
                const SizedBox(height: 6),
                Text(value, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Color(0xFF5A6C96))),
              ]),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/* ===========================
   MODELS (static demo)
=========================== */

enum Gender { male, female }

enum LabSource { hospital, caregiver }

class ChildProfile {
  ChildProfile({
    required this.id,
    required this.name,
    required this.gender,
    required this.dob,
    required this.weightKg,
    required this.otherConditions,
    required this.mrn,
    required this.doctors,
    required this.medications,
    required this.appointments,
    required this.labTests,
    required this.hospitalTracking,
  });

  final String id;
  String name;
  Gender gender;
  DateTime dob;
  double weightKg;
  List<String> otherConditions;

  String mrn;
  List<Doctor> doctors;

  List<MedicationPlan> medications;
  List<Appointment> appointments;

  List<LabTest> labTests;

  HospitalTracking? hospitalTracking;

  String ageString({required bool isArabic}) {
    final now = DateTime.now();
    int years = now.year - dob.year;
    int months = now.month - dob.month;
    int days = now.day - dob.day;

    if (days < 0) {
      final prevMonth = DateTime(now.year, now.month, 0);
      days += prevMonth.day;
      months -= 1;
    }
    if (months < 0) {
      months += 12;
      years -= 1;
    }

    if (years <= 0) return isArabic ? '$months شهر' : '$months mo';
    return isArabic ? '$years سنة $months شهر' : '$years y $months mo';
  }
}

class Doctor {
  const Doctor({required this.name, required this.specialty, required this.phone});
  final String name;
  final String specialty;
  final String phone;
}

class MedicationPlan {
  MedicationPlan({
    required this.id,
    required this.name,
    required this.dose,
    required this.instructionsEn,
    required this.instructionsAr,
    required this.times,
    required this.remindersEnabled,
  });

  final String id;
  String name;
  String dose;
  String instructionsEn;
  String instructionsAr;
  List<String> times;
  bool remindersEnabled;
}

class Appointment {
  Appointment({
    required this.id,
    required this.dateTime,
    required this.titleEn,
    required this.titleAr,
    required this.doctor,
    required this.notesEn,
    required this.notesAr,
    required this.reminderEnabled,
  });

  final String id;
  DateTime dateTime;
  String titleEn;
  String titleAr;
  String doctor;
  String notesEn;
  String notesAr;
  bool reminderEnabled;
}

class LabTest {
  LabTest({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.date,
    required this.resultEn,
    required this.resultAr,
    required this.source,
  });

  final String id;
  final String nameEn;
  final String nameAr;
  final DateTime date;
  final String resultEn;
  final String resultAr;
  final LabSource source;
}

/* ===========================
   HOSPITAL TRACKING MODELS
   (BP, Pulse Ox, Feeding)
=========================== */

class HospitalTracking {
  HospitalTracking({
    required this.isHospitalized,
    required this.wardEn,
    required this.wardAr,
    required this.bed,
    required this.bpEntries,
    required this.spo2Entries,
    required this.feedingEntries,
  });

  bool isHospitalized;
  String wardEn;
  String wardAr;
  String bed;

  List<BloodPressureEntry> bpEntries;
  List<PulseOxEntry> spo2Entries;
  List<FeedingEntry> feedingEntries;
}

class BloodPressureEntry {
  BloodPressureEntry({
    required this.time,
    required this.systolic,
    required this.diastolic,
    required this.noteEn,
    required this.noteAr,
  });

  final DateTime time;
  final int systolic;
  final int diastolic;
  final String noteEn;
  final String noteAr;
}

class PulseOxEntry {
  PulseOxEntry({
    required this.time,
    required this.spo2,
    required this.pulse,
    required this.noteEn,
    required this.noteAr,
  });

  final DateTime time;
  final int spo2; // %
  final int pulse; // bpm
  final String noteEn;
  final String noteAr;
}

enum FeedingType { oral, ngTube, iv }

enum FeedingTolerance { good, mildIssues, poor }

class FeedingEntry {
  FeedingEntry({
    required this.time,
    required this.type,
    required this.amountMl,
    required this.tolerance,
    required this.noteEn,
    required this.noteAr,
  });

  final DateTime time;
  final FeedingType type;
  final int amountMl;
  final FeedingTolerance tolerance;
  final String noteEn;
  final String noteAr;
}
