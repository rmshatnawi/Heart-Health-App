# health_app

A Flutter-based mobile health application focused on Congenital Heart Disease (CHD) management and general wellness tracking. Targets Android, iOS, Web, macOS, and Windows from a single codebase.

---

## Features

### Authentication
- Email/password login and registration via Firebase Authentication
- Password reset flow
- Sign-out from any screen via the app menu

### Home Dashboard
A 3×3 grid of navigation tiles linking to all major sections:

| Tile | Description |
|---|---|
| Medical Info | Hub for clinical reference content |
| Medical Store | Product catalog with cart |
| Calculator | BMI, blood sugar, blood pressure, and cardiac risk tools |
| Wellness | Daily metrics dashboard with goal tracking |
| Documents | User document management |
| Medical Consultation | Doctor directory with video, voice, and chat options |
| Patient Care | Care plan and reminder dashboard |
| Solutions | General symptom-to-solution reference |

### Medical Info (sub-pages)
Accessed through the Medical Info tile:
- **Symptoms** — CHD symptom catalog categorized by severity
- **Diseases** — Descriptions of congenital heart conditions (ASD, Tetralogy of Fallot, PDA, Coarctation of the Aorta, Transposition of Great Arteries, and others)
- **Medications** — Medicine reference and usage information
- **Prevention Tips** — Daily care, infection prevention, and lifestyle guidance
- **Heart Health** — Cardiovascular care tips
- **Lab Tests** — Blood work, imaging (Echo, MRI, CT), and monitoring tests (ECG, Holter, Pulse Oximetry)

### Health Calculator (`lib/src/pages/calculator.dart`)
- BMI calculation with classification
- Blood glucose interpretation (fasting and HbA1c)
- Blood pressure classification (Normal / Elevated / Stage 1 / Stage 2 / Crisis)
- Color-coded result indicators

### Wellness Dashboard (`lib/src/pages/wellness.dart`)
- Tracks: steps, heart rate, calories burned, sleep hours, active minutes, water intake
- User-defined daily goals for each metric
- Progress rings per goal
- Streak counter
- Edit dialog for entering current values and goals
- Reset action clears daily data and streak

### Medical Store + Payment (`lib/src/pages/store.dart`, `lib/src/pages/payment.dart`)
- Product listing with add-to-cart
- Cart with item removal and running total
- Checkout with Credit/Debit Card and Cash on Delivery options
- Card details form (number, cardholder, expiry, CVV)
- Order placement confirmation

### Medical Consultation (`lib/src/pages/consultation.dart`)
- Doctor directory with specialty, years of experience, and availability status
- Per-doctor actions: Video call, Voice call, Chat

### Patient Care (`lib/src/pages/patient_care.dart`)
- Care plan summary
- Reminder and task tracking

### Solutions (`lib/src/pages/solutions.dart`)
- Symptom-grouped solution cards (e.g., Insomnia and Sleep Difficulty)
- Severity indicators (low / medium / high)
- Lists of actionable recommendations per condition

### Profile, Settings, Privacy
- Profile page displays Firebase user email and UID
- Settings and Privacy pages accessible from the app menu on any screen

---

## Project Structure

```
lib/
├── main.dart                  # App entry point, Firebase initialization
├── firebase_options.dart      # Platform-specific Firebase config
└── src/
    ├── components/
    │   └── app_menu.dart      # Shared hamburger/menu button
    └── pages/
        ├── home.dart
        ├── login.dart
        ├── medical_info.dart
        ├── symptoms.dart
        ├── diseases.dart
        ├── medications.dart
        ├── prevention_tips.dart
        ├── heart_health.dart
        ├── lab_tests.dart
        ├── solutions.dart
        ├── calculator.dart
        ├── wellness.dart
        ├── store.dart
        ├── payment.dart
        ├── documents.dart
        ├── consultation.dart
        ├── patient_care.dart
        ├── profile.dart
        ├── settings.dart
        ├── privacy.dart
        └── _simple_info_page.dart   # Shared scrollable info page scaffold
assets/
└── images/
    ├── logo.png
    └── logonly.png
```

---

## Firebase Configuration

The app connects to Firebase project `heart-health-app-7d200`. Each platform has its own app registration defined in `lib/firebase_options.dart`. If forking or deploying independently, replace the values in that file with your own Firebase project credentials via `flutterfire configure`.

Supported platforms: Android
