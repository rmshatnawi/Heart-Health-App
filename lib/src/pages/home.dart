import 'package:flutter/material.dart';
import 'medical_info.dart';
import 'calculator.dart';
import 'payment.dart';
import 'store.dart';
import 'solutions.dart';
import 'wellness.dart';
import 'documents.dart';
import 'consultation.dart';
import 'patient_care.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD9E9FF),
              Color(0xFFCFE2FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Text(
                  'Healthcare Services',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    children: [
                      _HomeTile(
                        title: 'Medical Info',
                        icon: Icons.favorite_border,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MedicalInfoPage(),
                            ),
                          );
                        },
                      ),

                      // TODO: implement these pages later
                      _HomeTile(title: 'Medical Store', icon: Icons.store, onTap: () {Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const StorePage()),
                      );}),
                      _HomeTile(title: 'Calculator', icon: Icons.calculate, onTap: () { Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CalculatorPage(),
                        ),
                      );
                      },),
                      _HomeTile(title: 'Payment', icon: Icons.attach_money, onTap: () {Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const PaymentPage()),
                      );}),
                      _HomeTile(title: 'Solutions', icon: Icons.menu_book, onTap: () {Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SolutionsPage()),
                      );}),
                      _HomeTile(title: 'Outlook on Wellness', icon: Icons.show_chart, onTap: () { Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const WellnessPage()),
                      );}),
                      _HomeTile(title: 'Documents', icon: Icons.description, onTap: () { Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const DocumentsPage()),
                      );}),
                      _HomeTile(
                        title: 'Medical Consultation',
                        icon: Icons.medical_services,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MedicalConsultationPage(),
                            ),
                          );
                        },
                      ),

                      _HomeTile(title: 'Patient Care', icon: Icons.person, onTap: () {Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const PatientCarePage()),
                      );}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const _HomeTile({
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 150),
        borderRadius: BorderRadius.circular(22),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap, // <-- important
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF2F73FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1B2B55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
