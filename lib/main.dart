import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'src/pages/login.dart';
import 'src/pages/prevention_tips.dart';
import 'src/pages/symptoms.dart';
import 'src/pages/medical_info.dart';
import 'src/pages/calculator.dart';
import 'src/pages/payment.dart';
import 'src/pages/store.dart';
import 'src/pages/solutions.dart';
import 'src/pages/wellness.dart';
import 'src/pages/documents.dart';
import 'src/pages/consultation.dart';
import 'src/pages/patient_care.dart';
import 'src/pages/heart_health.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // await clearRememberedLogin();
  runApp(const MyApp());
}

/*Future<void> clearRememberedLogin() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}*/


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
     // home: PreventionTipsPage(),
      //home: LoginPage(),
      //  home: SymptomsPage(),
      //  home: HeartHealthPage(),
        home: MedicalInfoPage(),
    );
  }
}
