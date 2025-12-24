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

      // Create user in Firestore (minimal model)
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
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message ?? 'Sign up failed';
        _isLoading = false;
      });
    } catch (_) {
      setState(() {
        _error = 'Sign up failed';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              width: size.width * 0.9,
              constraints: const BoxConstraints(maxWidth: 520),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 6),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 180,
                    width: 180,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Sign Up',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      color: const Color(0xFF21899C),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 22),

                  _emailField(size),
                  const SizedBox(height: 10),
                  _passwordField(size, _passCtrl, 'Create password'),
                  const SizedBox(height: 10),
                  _passwordField(size, _confirmCtrl, 'Confirm password'),
                  const SizedBox(height: 10),

                  if (_error != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 12.5),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  const SizedBox(height: 10),
                  _signUpButton(size),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField(Size size) {
    final hasText = _emailCtrl.text.isNotEmpty;

    return SizedBox(
      height: size.height / 12,
      child: TextField(
        controller: _emailCtrl,
        style: GoogleFonts.inter(fontSize: 16.0, color: const Color(0xFF151624)),
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        cursorColor: const Color(0xFF151624),
        decoration: InputDecoration(
          hintText: 'Enter your email',
          hintStyle: GoogleFonts.inter(
            fontSize: 14.0,
            color: const Color(0xFF151624).withValues(alpha: 128),
          ),
          fillColor: hasText ? Colors.transparent : const Color.fromRGBO(248, 247, 251, 1),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: hasText ? const Color.fromRGBO(44, 185, 176, 1) : Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Color.fromRGBO(44, 185, 176, 1)),
          ),
          prefixIcon: Icon(
            Icons.mail_outline_rounded,
            color: hasText
                ? const Color.fromRGBO(44, 185, 176, 1)
                : const Color(0xFF151624).withValues(alpha: 128),
            size: 18,
          ),
        ),
      ),
    );
  }

  Widget _passwordField(Size size, TextEditingController ctrl, String hint) {
    final hasText = ctrl.text.isNotEmpty;

    return SizedBox(
      height: size.height / 12,
      child: TextField(
        controller: ctrl,
        style: GoogleFonts.inter(fontSize: 16.0, color: const Color(0xFF151624)),
        maxLines: 1,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        cursorColor: const Color(0xFF151624),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            fontSize: 14.0,
            color: const Color(0xFF151624).withValues(alpha: 128),
          ),
          fillColor: hasText ? Colors.transparent : const Color.fromRGBO(248, 247, 251, 1),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: hasText ? const Color.fromRGBO(44, 185, 176, 1) : Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Color.fromRGBO(44, 185, 176, 1)),
          ),
          prefixIcon: Icon(
            Icons.lock_outline_rounded,
            color: hasText
                ? const Color.fromRGBO(44, 185, 176, 1)
                : const Color(0xFF151624).withValues(alpha: 128),
            size: 18,
          ),
        ),
      ),
    );
  }

  Widget _signUpButton(Size size) {
    return SizedBox(
      width: double.infinity,
      height: size.height / 13,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF21899C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 0,
        ),
        onPressed: _isLoading ? null : _handleSignUp,
        child: _isLoading
            ? const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        )
            : Text(
          'Create account',
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
