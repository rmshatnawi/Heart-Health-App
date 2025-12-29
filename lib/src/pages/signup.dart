import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _isLoading = false;
  String? _error;

  static const double _frameW = 412.0;
  static const double _frameH = 917.0;

  @override
  void initState() {
    super.initState();
    _emailCtrl.addListener(() => setState(() {}));
    _passCtrl.addListener(() => setState(() {}));
    _confirmCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    final confirm = _confirmCtrl.text;

    if (email.isEmpty || pass.isEmpty || confirm.isEmpty) {
      setState(() {
        _error = 'Fill all fields';
        _isLoading = false;
      });
      return;
    }

    if (pass.length < 6) {
      setState(() {
        _error = 'Password must be at least 6 characters';
        _isLoading = false;
      });
      return;
    }

    if (pass != confirm) {
      setState(() {
        _error = 'Passwords do not match';
        _isLoading = false;
      });
      return;
    }

    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      final uid = cred.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'role': 'patient',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
      );
    } catch (e) {
      setState(() {
        _error = 'Sign up failed';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: _frameW,
              height: _frameH,
              child: _FrameScaffold(
                child: Container(
                  // FIX: background fills the ENTIRE frame
                  width: _frameW,
                  height: _frameH,
                  color: const Color(0xFFF8F8F8),
                  child: _buildFrameContent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrameContent() {
    return Column(
      children: [
        SizedBox(
          height: 56,
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              child: _buildCard(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      width: _frameW * 0.92,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 170,
            width: 170,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            'Sign Up',
            style: GoogleFonts.inter(
              fontSize: 22,
              color: const Color(0xFF21899C),
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          _emailField(),
          const SizedBox(height: 10),
          _passwordField(_passCtrl, 'Create password'),
          const SizedBox(height: 10),
          _passwordField(_confirmCtrl, 'Confirm password'),
          const SizedBox(height: 10),
          if (_error != null) ...[
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 12.5),
            ),
            const SizedBox(height: 8),
          ],
          _signUpButton(),
        ],
      ),
    );
  }

  Widget _emailField() {
    final hasText = _emailCtrl.text.isNotEmpty;
    return _inputField(
      controller: _emailCtrl,
      hint: 'Enter your email',
      icon: Icons.mail_outline_rounded,
      hasText: hasText,
      obscure: false,
    );
  }

  Widget _passwordField(TextEditingController ctrl, String hint) {
    final hasText = ctrl.text.isNotEmpty;
    return _inputField(
      controller: ctrl,
      hint: hint,
      icon: Icons.lock_outline_rounded,
      hasText: hasText,
      obscure: true,
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool hasText,
    required bool obscure,
  }) {
    return SizedBox(
      height: 52,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: GoogleFonts.inter(fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor:
          hasText ? Colors.transparent : const Color(0xFFF8F7FB),
          prefixIcon: Icon(icon, size: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: hasText
                  ? const Color(0xFF2CB9B0)
                  : Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
            const BorderSide(color: Color(0xFF2CB9B0)),
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF21899C),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : Text(
          'Create account',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _FrameScaffold extends StatelessWidget {
  const _FrameScaffold({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return MediaQuery(
      data: mq.copyWith(textScaler: const TextScaler.linear(1.0)),
      child: child,
    );
  }
}
