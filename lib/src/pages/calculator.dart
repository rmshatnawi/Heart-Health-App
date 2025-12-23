// lib/src/pages/calculator.dart
import 'dart:math';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  double? _bmi;
  String? _bmiLabel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

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
    } else {
      label = 'Obesity';
    }

    setState(() {
      _bmi = double.parse(bmi.toStringAsFixed(1));
      _bmiLabel = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            _TopTitle(
              title: 'Change Calculator',
              subtitle: 'Medical Calculator',
              icon: Icons.calculate_outlined,
              onBack: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _CardShell(
                  child: Column(
                    children: [
                      _TabsHeader(controller: _tabController),
                      const SizedBox(height: 14),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _BmiTab(
                              weightController: _weightController,
                              heightController: _heightController,
                              onCalculate: _calcBmi,
                              bmi: _bmi,
                              bmiLabel: _bmiLabel,
                            ),
                            const _PlaceholderTab(
                              title: 'Dosage',
                              subtitle: 'Not implemented yet',
                              icon: Icons.medication_outlined,
                            ),
                            const _PlaceholderTab(
                              title: 'Blood Sugar',
                              subtitle: 'Not implemented yet',
                              icon: Icons.monitor_heart_outlined,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'For medical guidance only - Consult your healthcare provider',
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
    );
  }
}

class _TopTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onBack;

  const _TopTitle({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          const Spacer(),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF2F73FF),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 16,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1B2B55),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A6D8A),
                ),
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  final Widget child;

  const _CardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 245),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 18,
            offset: Offset(0, 12),
          ),
        ],
        border: Border.all(color: const Color(0xFFE6EEFF)),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: child,
    );
  }
}

class _TabsHeader extends StatelessWidget {
  final TabController controller;

  const _TabsHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE3EBFF)),
      ),
      padding: const EdgeInsets.all(4),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        labelColor: const Color(0xFF1B2B55),
        unselectedLabelColor: const Color(0xFF6B7C97),
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        tabs: const [
          Tab(icon: Icon(Icons.monitor_weight_outlined, size: 18), text: 'BMI'),
          Tab(icon: Icon(Icons.medication_outlined, size: 18), text: 'Dosage'),
          Tab(icon: Icon(Icons.monitor_heart_outlined, size: 18), text: 'Blood Sugar'),
        ],
      ),
    );
  }
}

class _BmiTab extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController heightController;
  final VoidCallback onCalculate;
  final double? bmi;
  final String? bmiLabel;

  const _BmiTab({
    required this.weightController,
    required this.heightController,
    required this.onCalculate,
    required this.bmi,
    required this.bmiLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: Column(
        children: [
          const Text(
            'Body Mass Index Calculator',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF21899C),
            ),
          ),
          const SizedBox(height: 18),
          _LabeledField(
            label: 'Weight (kg)',
            controller: weightController,
            hint: 'Enter Weight',
          ),
          const SizedBox(height: 14),
          _LabeledField(
            label: 'Height (cm)',
            controller: heightController,
            hint: 'Enter Hight',
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B84F3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              onPressed: onCalculate,
              child: const Text(
                'Calculate',
                style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 14),
          if (bmi != null) _BmiResult(bmi: bmi!, label: bmiLabel ?? ''),
          if (bmi == null && bmiLabel != null) _ErrorText(text: bmiLabel!),
          const SizedBox(height: 14),
          const _InfoNote(
            text:
            'BMI is a screening tool and may not reflect body composition accurately for all individuals.',
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;

  const _LabeledField({
    required this.label,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B2B55),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF7FAFF),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE1ECFF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF0B84F3), width: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}

class _BmiResult extends StatelessWidget {
  final double bmi;
  final String label;

  const _BmiResult({required this.bmi, required this.label});

  @override
  Widget build(BuildContext context) {
    final v = bmi.clamp(10, 45);
    final pct = (v - 10) / (45 - 10);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1ECFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your BMI: $bmi',
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1B2B55),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5A6D8A),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 10,
              child: Stack(
                children: [
                  Container(color: const Color(0xFFE6EEFF)),
                  FractionallySizedBox(
                    widthFactor: max(0.02, pct),
                    child: Container(color: const Color(0xFF0B84F3)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoNote extends StatelessWidget {
  final String text;

  const _InfoNote({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1ECFF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF1B2B55), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.8,
                fontWeight: FontWeight.w600,
                color: Color(0xFF445C7D),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  final String text;

  const _ErrorText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _PlaceholderTab({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF7FAFF),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE1ECFF)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF2FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: const Color(0xFF2F73FF)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1B2B55),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5A6D8A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
