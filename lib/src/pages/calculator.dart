// lib/src/pages/calculator.dart
import 'dart:math';
import 'package:flutter/material.dart';

enum Sex { male, female }

enum GlucoseTestType { fasting, ogtt2h, random }

enum SugarInputMode { glucose, a1c }

enum BpCategory { normal, elevated, stage1, stage2, crisis }

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage>
    with SingleTickerProviderStateMixin {
  // FIXED FRAME SIZE (412x917)
  static const double _frameW = 412.0;
  static const double _frameH = 917.0;

  late final TabController _tabController;

  // BMI
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  Sex _sex = Sex.male;
  double? _bmi;
  String? _bmiLabel;

  // Blood sugar (glucose + A1c)
  SugarInputMode _sugarMode = SugarInputMode.glucose;
  final _glucoseController = TextEditingController();
  GlucoseTestType _glucoseType = GlucoseTestType.fasting;
  double? _glucoseValue;
  String? _glucoseLabel;

  final _a1cController = TextEditingController();
  double? _a1cValue;
  String? _a1cLabel;

  // Blood pressure
  final _sbpController = TextEditingController();
  final _dbpController = TextEditingController();
  int? _sbp;
  int? _dbp;
  BpCategory? _bpCategory;
  String? _bpLabel;

  // Heart risk (screening score)
  final _ageController = TextEditingController();
  bool _smoker = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    _weightController.dispose();
    _heightController.dispose();

    _glucoseController.dispose();
    _a1cController.dispose();

    _sbpController.dispose();
    _dbpController.dispose();

    _ageController.dispose();
    super.dispose();
  }

  // ============================ BMI ============================

  void _calcBmi() {
    final w = double.tryParse(_weightController.text.trim());
    final hCm = double.tryParse(_heightController.text.trim());

    if (w == null || hCm == null || w <= 0 || hCm <= 0) {
      setState(() {
        _bmi = null;
        _bmiLabel = 'Enter valid numbers';
      });
      return;
    }

    final h = hCm / 100.0;
    final bmi = w / (h * h);

    String label;
    if (bmi < 18.5) {
      label = 'Underweight';
    } else if (bmi < 25) {
      label = 'Normal';
    } else if (bmi < 30) {
      label = 'Overweight';
    } else if (bmi < 35) {
      label = 'Obesity (Class I)';
    } else if (bmi < 40) {
      label = 'Obesity (Class II)';
    } else {
      label = 'Obesity (Class III)';
    }

    setState(() {
      _bmi = double.parse(bmi.toStringAsFixed(1));
      _bmiLabel = label;
    });
  }

  // ============================ BLOOD SUGAR ============================

  void _calcGlucose() {
    final v = double.tryParse(_glucoseController.text.trim());
    if (v == null || v <= 0) {
      setState(() {
        _glucoseValue = null;
        _glucoseLabel = 'Enter a valid number';
      });
      return;
    }

    String label;
    if (_glucoseType == GlucoseTestType.fasting) {
      if (v < 100) {
        label = 'Normal (fasting)';
      } else if (v < 126) {
        label = 'Prediabetes (fasting)';
      } else {
        label = 'Diabetes range (fasting)';
      }
    } else if (_glucoseType == GlucoseTestType.ogtt2h) {
      if (v < 140) {
        label = 'Normal (2-hour OGTT)';
      } else if (v < 200) {
        label = 'Prediabetes (2-hour OGTT)';
      } else {
        label = 'Diabetes range (2-hour OGTT)';
      }
    } else {
      if (v < 140) {
        label = 'Typical range (random)';
      } else if (v < 200) {
        label = 'Elevated (random)';
      } else {
        label = 'Diabetes range (random)';
      }
    }

    setState(() {
      _glucoseValue = double.parse(v.toStringAsFixed(0));
      _glucoseLabel = label;
    });
  }

  void _calcA1c() {
    final v = double.tryParse(_a1cController.text.trim());
    if (v == null || v <= 0) {
      setState(() {
        _a1cValue = null;
        _a1cLabel = 'Enter a valid number';
      });
      return;
    }

    String label;
    if (v < 5.7) {
      label = 'Normal (A1c)';
    } else if (v < 6.5) {
      label = 'Prediabetes (A1c)';
    } else {
      label = 'Diabetes range (A1c)';
    }

    setState(() {
      _a1cValue = double.parse(v.toStringAsFixed(1));
      _a1cLabel = label;
    });
  }

  // ============================ BLOOD PRESSURE ============================

  void _calcBp() {
    final sbp = int.tryParse(_sbpController.text.trim());
    final dbp = int.tryParse(_dbpController.text.trim());

    if (sbp == null || dbp == null || sbp <= 0 || dbp <= 0) {
      setState(() {
        _sbp = null;
        _dbp = null;
        _bpCategory = null;
        _bpLabel = 'Enter valid numbers';
      });
      return;
    }

    BpCategory cat;
    String label;

    if (sbp >= 180 || dbp >= 120) {
      cat = BpCategory.crisis;
      label = 'Hypertensive crisis (seek urgent care)';
    } else if (sbp >= 140 || dbp >= 90) {
      cat = BpCategory.stage2;
      label = 'Hypertension (Stage 2)';
    } else if ((sbp >= 130 && sbp <= 139) || (dbp >= 80 && dbp <= 89)) {
      cat = BpCategory.stage1;
      label = 'Hypertension (Stage 1)';
    } else if (sbp >= 120 && sbp <= 129 && dbp < 80) {
      cat = BpCategory.elevated;
      label = 'Elevated BP';
    } else {
      cat = BpCategory.normal;
      label = 'Normal BP';
    }

    setState(() {
      _sbp = sbp;
      _dbp = dbp;
      _bpCategory = cat;
      _bpLabel = label;
    });
  }

  // ============================ HEART RISK (SCREENING SCORE) ============================

  int _riskScore() {
    final age = int.tryParse(_ageController.text.trim());
    int score = 0;

    if (age != null) {
      if (age < 30) score += 0;
      else if (age < 40) score += 1;
      else if (age < 50) score += 2;
      else if (age < 60) score += 3;
      else if (age < 70) score += 4;
      else score += 5;
    }

    if (_smoker) score += 2;

    switch (_bpCategory) {
      case BpCategory.normal:
        score += 0;
        break;
      case BpCategory.elevated:
        score += 1;
        break;
      case BpCategory.stage1:
        score += 2;
        break;
      case BpCategory.stage2:
        score += 3;
        break;
      case BpCategory.crisis:
        score += 5;
        break;
      case null:
        break;
    }

    final diabetesFromA1c =
        (_a1cValue != null && (_a1cValue! >= 6.5)) &&
            _sugarMode == SugarInputMode.a1c;
    final diabetesFromGlucose =
        (_glucoseLabel != null &&
            _glucoseLabel!.toLowerCase().contains('diabetes')) &&
            _sugarMode == SugarInputMode.glucose;

    if (diabetesFromA1c || diabetesFromGlucose) {
      score += 3;
    } else {
      final prediabetesFromA1c =
          (_a1cValue != null && _a1cValue! >= 5.7 && _a1cValue! < 6.5) &&
              _sugarMode == SugarInputMode.a1c;
      final prediabetesFromGlucose =
          (_glucoseLabel != null &&
              _glucoseLabel!.toLowerCase().contains('prediabetes')) &&
              _sugarMode == SugarInputMode.glucose;
      if (prediabetesFromA1c || prediabetesFromGlucose) score += 1;
    }

    if (_bmi != null) {
      if (_bmi! >= 30) {
        score += 2;
      } else if (_bmi! >= 25) {
        score += 1;
      }
    }

    return score;
  }

  (String, Color) _riskBand(int score) {
    if (score <= 2) return ('Low', Colors.green);
    if (score <= 5) return ('Moderate', Colors.orange);
    if (score <= 8) return ('High', Colors.red);
    return ('Very High', const Color(0xFF7B1FA2));
  }

  // ============================ UI HELPERS ============================

  Color _bmiColor(double bmi) {
    if (bmi < 18.5) return Colors.lightBlue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  (Color, String) _sugarChip() {
    if (_sugarMode == SugarInputMode.glucose) {
      if (_glucoseValue == null || _glucoseLabel == null) {
        return (const Color(0xFF6B7C97), '');
      }
      final lower = _glucoseLabel!.toLowerCase();
      if (lower.contains('normal') || lower.contains('typical')) {
        return (Colors.green, _glucoseLabel!);
      }
      if (lower.contains('prediabetes') || lower.contains('elevated')) {
        return (Colors.orange, _glucoseLabel!);
      }
      if (lower.contains('diabetes')) {
        return (Colors.red, _glucoseLabel!);
      }
      return (const Color(0xFF6B7C97), _glucoseLabel!);
    } else {
      if (_a1cValue == null || _a1cLabel == null) {
        return (const Color(0xFF6B7C97), '');
      }
      final lower = _a1cLabel!.toLowerCase();
      if (lower.contains('normal')) return (Colors.green, _a1cLabel!);
      if (lower.contains('prediabetes')) return (Colors.orange, _a1cLabel!);
      if (lower.contains('diabetes')) return (Colors.red, _a1cLabel!);
      return (const Color(0xFF6B7C97), _a1cLabel!);
    }
  }

  Color _bpColor(BpCategory cat) {
    switch (cat) {
      case BpCategory.normal:
        return Colors.green;
      case BpCategory.elevated:
        return Colors.orange;
      case BpCategory.stage1:
        return Colors.deepOrange;
      case BpCategory.stage2:
        return Colors.red;
      case BpCategory.crisis:
        return const Color(0xFF7B1FA2);
    }
  }

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF2F73FF);

    return Scaffold(
      // outside background (web/desktop)
      backgroundColor: const Color(0xFFEEF2FA),
      body: SafeArea(
        child: Center(
          // FIXED FRAME SIZE
          child: SizedBox(
            width: _frameW,
            height: _frameH,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Scaffold(
                backgroundColor: const Color(0xFFF3F6FF),
                body: SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 430),
                      child: Column(
                        children: [
                          _TopHeader(
                            title: 'Health Calculator',
                            subtitle: 'BMI • Sugar • BP • Risk',
                            icon: Icons.calculate_outlined,
                            onBack: () => Navigator.pop(context),
                            color: blue,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: _Card(
                                child: Column(
                                  children: [
                                    _Tabs(controller: _tabController),
                                    const SizedBox(height: 14),
                                    Expanded(
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          _BmiTab(
                                            sex: _sex,
                                            onSexChanged: (s) =>
                                                setState(() => _sex = s),
                                            weight: _weightController,
                                            height: _heightController,
                                            bmi: _bmi,
                                            label: _bmiLabel,
                                            onCalc: _calcBmi,
                                            colorForBmi: _bmiColor,
                                          ),
                                          _SugarTab(
                                            mode: _sugarMode,
                                            onModeChanged: (m) =>
                                                setState(() => _sugarMode = m),
                                            glucoseController: _glucoseController,
                                            glucoseType: _glucoseType,
                                            onGlucoseTypeChanged: (t) =>
                                                setState(() => _glucoseType = t),
                                            onCalcGlucose: _calcGlucose,
                                            glucoseValue: _glucoseValue,
                                            a1cController: _a1cController,
                                            onCalcA1c: _calcA1c,
                                            a1cValue: _a1cValue,
                                            chip: _sugarChip(),
                                          ),
                                          _BpTab(
                                            sbpController: _sbpController,
                                            dbpController: _dbpController,
                                            onCalc: _calcBp,
                                            sbp: _sbp,
                                            dbp: _dbp,
                                            label: _bpLabel,
                                            category: _bpCategory,
                                            colorForCategory: _bpColor,
                                          ),
                                          _RiskTab(
                                            ageController: _ageController,
                                            sex: _sex,
                                            onSexChanged: (s) =>
                                                setState(() => _sex = s),
                                            smoker: _smoker,
                                            onSmokerChanged: (v) =>
                                                setState(() => _smoker = v),
                                            bmi: _bmi,
                                            bmiLabel: _bmiLabel,
                                            bpLabel: _bpLabel,
                                            bpCategory: _bpCategory,
                                            sugarMode: _sugarMode,
                                            glucoseValue: _glucoseValue,
                                            glucoseLabel: _glucoseLabel,
                                            a1cValue: _a1cValue,
                                            a1cLabel: _a1cLabel,
                                            score: _riskScore(),
                                            bandForScore: _riskBand,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Educational only — not a diagnosis.',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4E6A8F),
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

// ====================== HEADER / SHELL ======================

class _TopHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onBack;
  final Color color;

  const _TopHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onBack,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
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
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xE6FFFFFF),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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

class _Tabs extends StatelessWidget {
  final TabController controller;
  const _Tabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        labelColor: const Color(0xFF1B2B55),
        unselectedLabelColor: const Color(0xFF6B7C97),
        labelStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
        tabs: const [
          Tab(icon: Icon(Icons.monitor_weight_outlined, size: 18), text: 'BMI'),
          Tab(icon: Icon(Icons.bloodtype_outlined, size: 18), text: 'Sugar'),
          Tab(icon: Icon(Icons.favorite_outline, size: 18), text: 'BP'),
          Tab(icon: Icon(Icons.insights_outlined, size: 18), text: 'Risk'),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE6EEFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 16,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ====================== REUSABLE INPUT ======================

class _NumberField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final String? suffix;

  const _NumberField({
    required this.label,
    required this.controller,
    this.hint = '',
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint.isEmpty ? null : hint,
        suffixText: suffix,
        filled: true,
        fillColor: const Color(0xFFF7FAFF),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PrimaryButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F73FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 15.5,
          ),
        ),
      ),
    );
  }
}

class _SegButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _SegButton({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xFF2F73FF) : Colors.white;
    final fg = selected ? Colors.white : const Color(0xFF1B2B55);
    final border = selected ? const Color(0xFF2F73FF) : const Color(0xFFE1ECFF);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: border),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w900, color: fg),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChipBox extends StatelessWidget {
  final Color color;
  final String text;

  const _ChipBox({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

// ====================== BMI TAB ======================

class _BmiTab extends StatelessWidget {
  final Sex sex;
  final ValueChanged<Sex> onSexChanged;
  final TextEditingController weight;
  final TextEditingController height;
  final double? bmi;
  final String? label;
  final VoidCallback onCalc;
  final Color Function(double) colorForBmi;

  const _BmiTab({
    required this.sex,
    required this.onSexChanged,
    required this.weight,
    required this.height,
    required this.bmi,
    required this.label,
    required this.onCalc,
    required this.colorForBmi,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF7FAFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE1ECFF)),
          ),
          child: Row(
            children: [
              _SegButton(
                text: 'Male',
                selected: sex == Sex.male,
                onTap: () => onSexChanged(Sex.male),
              ),
              const SizedBox(width: 8),
              _SegButton(
                text: 'Female',
                selected: sex == Sex.female,
                onTap: () => onSexChanged(Sex.female),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _NumberField(label: 'Weight', controller: weight, hint: '70', suffix: 'kg'),
        const SizedBox(height: 12),
        _NumberField(label: 'Height', controller: height, hint: '170', suffix: 'cm'),
        const SizedBox(height: 14),
        _PrimaryButton(text: 'Calculate', onTap: onCalc),
        const SizedBox(height: 14),
        if (bmi != null && label != null)
          _ChipBox(
            color: colorForBmi(bmi!),
            text: 'BMI: ${bmi!.toStringAsFixed(1)} • $label',
          ),
      ],
    );
  }
}

// ====================== SUGAR TAB (Glucose + A1c) ======================

class _SugarTab extends StatelessWidget {
  final SugarInputMode mode;
  final ValueChanged<SugarInputMode> onModeChanged;

  final TextEditingController glucoseController;
  final GlucoseTestType glucoseType;
  final ValueChanged<GlucoseTestType> onGlucoseTypeChanged;
  final VoidCallback onCalcGlucose;
  final double? glucoseValue;

  final TextEditingController a1cController;
  final VoidCallback onCalcA1c;
  final double? a1cValue;

  final (Color, String) chip;

  const _SugarTab({
    required this.mode,
    required this.onModeChanged,
    required this.glucoseController,
    required this.glucoseType,
    required this.onGlucoseTypeChanged,
    required this.onCalcGlucose,
    required this.glucoseValue,
    required this.a1cController,
    required this.onCalcA1c,
    required this.a1cValue,
    required this.chip,
  });

  @override
  Widget build(BuildContext context) {
    final (c, txt) = chip;

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF7FAFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE1ECFF)),
          ),
          child: Row(
            children: [
              _SegButton(
                text: 'Glucose',
                selected: mode == SugarInputMode.glucose,
                onTap: () => onModeChanged(SugarInputMode.glucose),
              ),
              const SizedBox(width: 8),
              _SegButton(
                text: 'HbA1c',
                selected: mode == SugarInputMode.a1c,
                onTap: () => onModeChanged(SugarInputMode.a1c),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (mode == SugarInputMode.glucose) ...[
          DropdownButtonFormField<GlucoseTestType>(
            value: glucoseType,
            items: const [
              DropdownMenuItem(
                value: GlucoseTestType.fasting,
                child: Text('Fasting (FPG)'),
              ),
              DropdownMenuItem(
                value: GlucoseTestType.ogtt2h,
                child: Text('2-hour OGTT'),
              ),
              DropdownMenuItem(
                value: GlucoseTestType.random,
                child: Text('Random / Casual'),
              ),
            ],
            onChanged: (v) {
              if (v != null) onGlucoseTypeChanged(v);
            },
            decoration: const InputDecoration(
              labelText: 'Test Type',
              filled: true,
              fillColor: Color(0xFFF7FAFF),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          _NumberField(
            label: 'Glucose',
            controller: glucoseController,
            hint: '95',
            suffix: 'mg/dL',
          ),
          const SizedBox(height: 14),
          _PrimaryButton(text: 'Calculate', onTap: onCalcGlucose),
        ] else ...[
          _NumberField(
            label: 'HbA1c',
            controller: a1cController,
            hint: '5.6',
            suffix: '%',
          ),
          const SizedBox(height: 14),
          _PrimaryButton(text: 'Calculate', onTap: onCalcA1c),
        ],
        const SizedBox(height: 14),
        if (txt.isNotEmpty) _ChipBox(color: c, text: txt),
      ],
    );
  }
}

// ====================== BP TAB ======================

class _BpTab extends StatelessWidget {
  final TextEditingController sbpController;
  final TextEditingController dbpController;
  final VoidCallback onCalc;

  final int? sbp;
  final int? dbp;
  final String? label;
  final BpCategory? category;
  final Color Function(BpCategory) colorForCategory;

  const _BpTab({
    required this.sbpController,
    required this.dbpController,
    required this.onCalc,
    required this.sbp,
    required this.dbp,
    required this.label,
    required this.category,
    required this.colorForCategory,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _NumberField(
          label: 'Systolic (SBP)',
          controller: sbpController,
          hint: '120',
          suffix: 'mmHg',
        ),
        const SizedBox(height: 12),
        _NumberField(
          label: 'Diastolic (DBP)',
          controller: dbpController,
          hint: '80',
          suffix: 'mmHg',
        ),
        const SizedBox(height: 14),
        _PrimaryButton(text: 'Calculate', onTap: onCalc),
        const SizedBox(height: 14),
        if (category != null && label != null && sbp != null && dbp != null)
          _ChipBox(
            color: colorForCategory(category!),
            text: 'BP: $sbp/$dbp • $label',
          ),
      ],
    );
  }
}

// ====================== RISK TAB ======================

class _RiskTab extends StatelessWidget {
  final TextEditingController ageController;

  final Sex sex;
  final ValueChanged<Sex> onSexChanged;

  final bool smoker;
  final ValueChanged<bool> onSmokerChanged;

  final double? bmi;
  final String? bmiLabel;

  final String? bpLabel;
  final BpCategory? bpCategory;

  final SugarInputMode sugarMode;
  final double? glucoseValue;
  final String? glucoseLabel;
  final double? a1cValue;
  final String? a1cLabel;

  final int score;
  final (String, Color) Function(int) bandForScore;

  const _RiskTab({
  required this.ageController,
  required this.sex,
  required this.onSexChanged,
  required this.smoker,
  required this.onSmokerChanged,
  required this.bmi,
  required this.bmiLabel,
  required this.bpLabel,
  required this.bpCategory,
  required this.sugarMode,
  required this.glucoseValue,
  required this.glucoseLabel,
  required this.a1cValue,
  required this.a1cLabel,
  required this.score,
  required this.bandForScore,
  });

  @override
  Widget build(BuildContext context) {
  final (band, color) = bandForScore(score);

  String sugarSummary = 'Not set';
  if (sugarMode == SugarInputMode.glucose &&
  glucoseValue != null &&
  glucoseLabel != null) {
  sugarSummary = '${glucoseValue!.toStringAsFixed(0)} mg/dL • $glucoseLabel';
  } else if (sugarMode == SugarInputMode.a1c &&
  a1cValue != null &&
  a1cLabel != null) {
  sugarSummary = '${a1cValue!.toStringAsFixed(1)}% • $a1cLabel';
  }

  String bmiSummary = 'Not set';
  if (bmi != null && bmiLabel != null) {
  bmiSummary = '${bmi!.toStringAsFixed(1)} • $bmiLabel';
  }

  final bpSummary = bpLabel ?? 'Not set';

  return ListView(
  children: [
  _NumberField(
  label: 'Age',
  controller: ageController,
  hint: '35',
  suffix: 'years',
  ),
  const SizedBox(height: 12),
  Container(
  padding: const EdgeInsets.all(6),
  decoration: BoxDecoration(
  color: const Color(0xFFF7FAFF),
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: const Color(0xFFE1ECFF)),
  ),
  child: Row(
  children: [
  _SegButton(
  text: 'Male',
  selected: sex == Sex.male,
  onTap: () => onSexChanged(Sex.male),
  ),
  const SizedBox(width: 8),
  _SegButton(
  text: 'Female',
  selected: sex == Sex.female,
  onTap: () => onSexChanged(Sex.female),
  ),
  ],
  ),
  ),
  const SizedBox(height: 12),
  SwitchListTile(
  value: smoker,
  onChanged: onSmokerChanged,
  title: const Text(
  'Smoker',
  style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF1B2B55)),
  ),
  subtitle: const Text('Toggles risk score contribution'),
  activeColor: const Color(0xFF2F73FF),
  contentPadding: EdgeInsets.zero,
  ),
  const SizedBox(height: 10),
  Container(
  padding: const EdgeInsets.all(14),
  decoration: BoxDecoration(
  color: const Color(0xFFF7FAFF),
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: const Color(0xFFE1ECFF)),
  ),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  const Text(
  'Inputs used (from other tabs)',
  style: TextStyle(
  fontWeight: FontWeight.w900,
  color: Color(0xFF1B2B55),
  ),
  ),
  const SizedBox(height: 10),
  _kv('BMI', bmiSummary),
  const SizedBox(height: 6),
  _kv('Blood Pressure', bpSummary),
  const SizedBox(height: 6),
  _kv('Blood Sugar', sugarSummary),
  ],
  ),
  ),
  const SizedBox(height: 14),
  _ChipBox(
  color: color,
  text: 'Screening Score: $score • $band',
  ),
  const SizedBox(height: 12),
  const Text(
  'This is a simplified screening score, not a clinical ASCVD calculator. For official 10-year ASCVD risk, use a validated tool with cholesterol inputs.',
  style: TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w600,
  color: Color(0xFF4E6A8F),
  height: 1.35,
  ),
  ),
  ],
  );
  }

  Widget _kv(String k, String v) {
  return Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  SizedBox(
  width: 120,
  child: Text(
  k,
  style: const TextStyle(
  fontWeight: FontWeight.w800,
  color: Color(0xFF1B2B55),
  ),
  ),
  ),
  Expanded(
  child: Text(
  v,
  style: const TextStyle(
  fontWeight: FontWeight.w700,
  color: Color(0xFF5A6D8A),
  ),
  ),
  ),
  ],
  );
  }
}
