// lib/src/pages/login.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/chd_scaffold.dart';
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
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _emailCtrl.text.trim().isNotEmpty && _passCtrl.text.isNotEmpty && !_isLoading;

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final email = _emailCtrl.text.trim();
      final pass = _passCtrl.text;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _error = _mapAuthError(e);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Login failed: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _forgotPassword() async {
    FocusScope.of(context).unfocus();

    final email = _emailCtrl.text.trim();
    if (email.isEmpty) {
      setState(() => _error = 'Enter your email first');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reset link sent to $email')),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _error = _mapAuthError(e));
    } catch (e) {
      setState(() => _error = 'Failed to send reset email: $e');
    }
  }

  void _goToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SignUpPage()),
    );
  }

  String _mapAuthError(FirebaseAuthException e) {
    // Use codes (stable) instead of raw message (varies by platform)
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email format';
      case 'user-disabled':
        return 'This account is disabled';
      case 'user-not-found':
        return 'No account found for this email';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Wrong email or password';
      case 'too-many-requests':
        return 'Too many attempts. Try again later';
      case 'network-request-failed':
        return 'Network error. Check your connection';
      case 'operation-not-allowed':
        return 'Email/password sign-in is disabled in Firebase';
      default:
        return e.message ?? 'Login failed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChdScaffold(
      titleEn: 'Login',
      titleAr: 'تسجيل الدخول',
      headerIcon: Icons.lock_outline,
      showBack: false,
      child: (isArabic) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: Image.asset(
                  'assets/images/logonly.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isArabic ? 'مرحباً بعودتك' : 'Welcome back',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1B2B55),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isArabic
                    ? 'سجّل دخولك للمتابعة'
                    : 'Sign in to continue',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A6C96),
                ),
              ),
              const SizedBox(height: 18),

              _Input(
                controller: _emailCtrl,
                hint: isArabic ? 'البريد الإلكتروني' : 'Email',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                obscure: false,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              _Input(
                controller: _passCtrl,
                hint: isArabic ? 'كلمة المرور' : 'Password',
                icon: Icons.lock_outline_rounded,
                keyboardType: TextInputType.visiblePassword,
                obscure: true,
                onSubmitted: (_) => _canSubmit ? _handleLogin() : null,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _isLoading ? null : _forgotPassword,
                  child: Text(
                    isArabic ? 'نسيت كلمة المرور؟' : 'Forgot password?',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF21899C),
                    ),
                  ),
                ),
              ),

              if (_error != null) ...[
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3F3),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFFFD4D4)),
                  ),
                  child: Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF9A2A2A),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _canSubmit ? _handleLogin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F73FF),
                    disabledBackgroundColor: const Color(0xFF2F73FF).withValues(alpha: 120),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                    isArabic ? 'تسجيل الدخول' : 'Sign in',
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFBFD3FF))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      isArabic ? 'ليس لديك حساب؟' : 'Don’t have an account?',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF5A6C96),
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFBFD3FF))),
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: _isLoading ? null : _goToSignUp,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2F73FF)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    isArabic ? 'إنشاء حساب' : 'Create account',
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF2F73FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Input extends StatefulWidget {
  const _Input({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.keyboardType,
    required this.obscure,
    this.onSubmitted,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscure;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;

  @override
  State<_Input> createState() => _InputState();
}

class _InputState extends State<_Input> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    final hasText = widget.controller.text.isNotEmpty;

    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscure ? !_show : false,
      onSubmitted: widget.onSubmitted,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: const Color(0xFFF8FAFF),
        prefixIcon: Icon(widget.icon, size: 20, color: const Color(0xFF5A6C96)),
        suffixIcon: widget.obscure
            ? IconButton(
          onPressed: () => setState(() => _show = !_show),
          icon: Icon(
            _show ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF5A6C96),
          ),
        )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: hasText ? const Color(0xFF2F73FF) : const Color(0xFFE3EBFF),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF2F73FF), width: 1.4),
        ),
      ),
    );
  }
}
