import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _emailCtrl.addListener(() => setState(() {}));
    _passCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
      );

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = e.message ?? 'Login failed';
        _isLoading = false;
      });
    } catch (_) {
      setState(() {
        _error = 'Login failed';
        _isLoading = false;
      });
    }
  }

  Future<void> _forgotPassword() async {
    final email = _emailCtrl.text.trim();

    if (email.isEmpty) {
      setState(() => _error = 'Enter your email first');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Password reset sent'),
          content: Text('Reset link sent to:\n$email'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message ?? 'Failed to send reset email');
    } catch (_) {
      setState(() => _error = 'Failed to send reset email');
    }
  }

  void _goToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: _buildCard(size),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Size size) {
    return Container(
      width: size.width * 0.9,
      constraints: const BoxConstraints(maxWidth: 520),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(height: 18),

          Image.asset('assets/images/logo.png', height: 400),

          const SizedBox(height: 12),
          Text(
            'Login',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF5A7FB3),
            ),
          ),

          const SizedBox(height: 22),

          _emailField(size),
          const SizedBox(height: 10),
          _passwordField(size),
          const SizedBox(height: 6),

          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: _forgotPassword,
              child: Text(
                'Forgot password?',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF5A7FB3),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          if (_error != null) ...[
            const SizedBox(height: 10),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 12.5),
            ),
          ],

          const SizedBox(height: 18),
          _signInButton(size),
          const SizedBox(height: 14),

          _dividerText('Don’t have an account?'),
          const SizedBox(height: 10),
          _createAccountButton(size),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _emailField(Size size) {
    return _inputField(
      size: size,
      controller: _emailCtrl,
      hint: 'Enter your email',
      icon: Icons.mail_outline_rounded,
      obscure: false,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _passwordField(Size size) {
    return _inputField(
      size: size,
      controller: _passCtrl,
      hint: 'Enter your password',
      icon: Icons.lock_outline_rounded,
      obscure: true,
      keyboardType: TextInputType.visiblePassword,
    );
  }

  Widget _inputField({
    required Size size,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool obscure,
    required TextInputType keyboardType,
  }) {
    final hasText = controller.text.isNotEmpty;

    return SizedBox(
      height: size.height / 12,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: GoogleFonts.inter(fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: hasText ? Colors.transparent : const Color(0xFFF8F7FB),
          prefixIcon: Icon(icon, size: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: hasText ? const Color(0xFF2CB9B0) : Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Color(0xFF2CB9B0)),
          ),
        ),
      ),
    );
  }

  Widget _signInButton(Size size) {
    return SizedBox(
      width: double.infinity,
      height: size.height / 13,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5A7FB3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
          'Sign in',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _dividerText(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFF5A7FB3))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF5A7FB3),
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFF5A7FB3))),
      ],
    );
  }

  Widget _createAccountButton(Size size) {
    return SizedBox(
      width: double.infinity,
      height: size.height / 13,
      child: OutlinedButton(
        onPressed: _goToSignUp,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF5A7FB3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          'Create account',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: const Color(0xFF5A7FB3),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
