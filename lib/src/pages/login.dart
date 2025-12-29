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

  // Fixed design frame (Figma frame)
  static const double _frameW = 412.0;
  static const double _frameH = 917.0;

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
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Center(
          // Fixed frame (412x917) + scale entire page to fit any device
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            child: SizedBox(
              width: _frameW,
              height: _frameH,
              child: _FrameScaffold(
                child: _buildFrameContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrameContent() {
    // Everything inside assumes 412x917 coordinates.
    // Use SingleChildScrollView so keyboard / small screens never overflow.
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: _buildCard(),
      ),
    );
  }

  Widget _buildCard() {
    const double cardMaxWidth = 520; // irrelevant in fixed frame, kept safe

    return Container(
      width: _frameW * 0.92,
      constraints: const BoxConstraints(maxWidth: cardMaxWidth),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),

          // Logo constrained so it always fits in the 412x917 frame.
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 240,
              minHeight: 140,
            ),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 10),
          Text(
            'Login',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF5A7FB3),
            ),
          ),

          const SizedBox(height: 16),

          _emailField(),
          const SizedBox(height: 10),
          _passwordField(),
          const SizedBox(height: 6),

          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: _forgotPassword,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  'Forgot password?',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF5A7FB3),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 12.5),
            ),
          ],

          const SizedBox(height: 14),
          _signInButton(),
          const SizedBox(height: 12),

          _dividerText('Don’t have an account?'),
          const SizedBox(height: 10),

          _createAccountButton(),
        ],
      ),
    );
  }

  Widget _emailField() {
    return _inputField(
      controller: _emailCtrl,
      hint: 'Enter your email',
      icon: Icons.mail_outline_rounded,
      obscure: false,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _passwordField() {
    return _inputField(
      controller: _passCtrl,
      hint: 'Enter your password',
      icon: Icons.lock_outline_rounded,
      obscure: true,
      keyboardType: TextInputType.visiblePassword,
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool obscure,
    required TextInputType keyboardType,
  }) {
    final hasText = controller.text.isNotEmpty;

    return SizedBox(
      height: 52,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: GoogleFonts.inter(fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(fontSize: 14.5),
          filled: true,
          fillColor: hasText ? Colors.transparent : const Color(0xFFF8F7FB),
          prefixIcon: Icon(icon, size: 18),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: hasText ? const Color(0xFF2CB9B0) : Colors.transparent,
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Color(0xFF2CB9B0), width: 1.4),
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
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
            fontWeight: FontWeight.w700,
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
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFF5A7FB3))),
      ],
    );
  }

  Widget _createAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: _goToSignUp,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF5A7FB3), width: 1.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          'Create account',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: const Color(0xFF5A7FB3),
            fontWeight: FontWeight.w700,
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
      data: mq.copyWith(
        textScaler: const TextScaler.linear(1.0),
      ),
      child: child,
    );
  }
}
