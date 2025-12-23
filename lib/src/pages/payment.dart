// lib/src/pages/payment.dart
import 'package:flutter/material.dart';

enum PaymentMethod { card, wallet, cod }

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentMethod _method = PaymentMethod.card;

  final _cardNumber = TextEditingController();
  final _cardholder = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();

  @override
  void dispose() {
    _cardNumber.dispose();
    _cardholder.dispose();
    _expiry.dispose();
    _cvv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SecureBanner(),
                    const SizedBox(height: 14),
                    const _TotalAmountCard(amountText: '\$00.00'),
                    const SizedBox(height: 18),
                    const Text(
                      'Select Payment Method',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _MethodTile(
                      title: 'Credit / Debit Card',
                      subtitle: 'Visa, Mastercard, etc.',
                      icon: Icons.credit_card_rounded,
                      selected: _method == PaymentMethod.card,
                      onTap: () => setState(() => _method = PaymentMethod.card),
                    ),
                    const SizedBox(height: 12),
                    _MethodTile(
                      title: 'Digital Wallet',
                      subtitle: 'Apple Pay, Google Pay',
                      icon: Icons.account_balance_wallet_rounded,
                      selected: _method == PaymentMethod.wallet,
                      onTap: () => setState(() => _method = PaymentMethod.wallet),
                    ),
                    const SizedBox(height: 12),
                    _MethodTile(
                      title: 'Cash on Delivery',
                      subtitle: 'Pay when you receive',
                      icon: Icons.payments_rounded,
                      selected: _method == PaymentMethod.cod,
                      onTap: () => setState(() => _method = PaymentMethod.cod),
                    ),
                    const SizedBox(height: 16),

                    if (_method == PaymentMethod.card) ...[
                      const _SectionCardTitle(title: 'Card Details'),
                      const SizedBox(height: 10),
                      _CardDetailsForm(
                        cardNumber: _cardNumber,
                        cardholder: _cardholder,
                        expiry: _expiry,
                        cvv: _cvv,
                      ),
                      const SizedBox(height: 18),
                    ] else ...[
                      _InfoCard(
                        title: _method == PaymentMethod.wallet
                            ? 'Digital Wallet'
                            : 'Cash on Delivery',
                        subtitle: _method == PaymentMethod.wallet
                            ? 'Payment will be completed using your wallet provider.'
                            : 'You will pay the total amount when the order arrives.',
                        icon: _method == PaymentMethod.wallet
                            ? Icons.account_balance_wallet_outlined
                            : Icons.payments_outlined,
                      ),
                      const SizedBox(height: 18),
                    ],

                    _PrimaryButton(
                      text: 'Pay Securely',
                      onTap: () {
                        // TODO: connect to backend/payment gateway later
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Payment action (UI only)')),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _SecondaryButton(
                      text: 'Cancel',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          const Spacer(),
          const Text(
            'Payment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1B2B55),
            ),
          ),
          const Spacer(),
          const SizedBox(width: 44), // balance back button
        ],
      ),
    );
  }
}

class _SecureBanner extends StatelessWidget {
  const _SecureBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 245),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EEFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.shield_rounded, color: Color(0xFF2F73FF)),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Payment',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1B2B55),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Your information is protected',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A6D8A),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.lock_outline_rounded, color: Color(0xFF2F73FF)),
        ],
      ),
    );
  }
}

class _TotalAmountCard extends StatelessWidget {
  final String amountText;
  const _TotalAmountCard({required this.amountText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 245),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EEFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Amount',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6B7C97),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            amountText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1B2B55),
            ),
          ),
        ],
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _MethodTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final border = selected ? const Color(0xFF2F73FF) : const Color(0xFFE6EEFF);
    final radio = selected ? const Color(0xFF1B2B55) : const Color(0xFFB8C4D8);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 245),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: border, width: selected ? 1.5 : 1.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 14,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF2FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: const Color(0xFF2F73FF)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.5,
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
                      color: Color(0xFF6B7C97),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.radio_button_checked, color: radio),
          ],
        ),
      ),
    );
  }
}

class _SectionCardTitle extends StatelessWidget {
  final String title;
  const _SectionCardTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 245),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EEFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: Color(0xFF1B2B55),
        ),
      ),
    );
  }
}

class _CardDetailsForm extends StatelessWidget {
  final TextEditingController cardNumber;
  final TextEditingController cardholder;
  final TextEditingController expiry;
  final TextEditingController cvv;

  const _CardDetailsForm({
    required this.cardNumber,
    required this.cardholder,
    required this.expiry,
    required this.cvv,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 245),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EEFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Card Number',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1B2B55),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: cardNumber,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration(
              hint: '1234 5678 9012 3456',
              suffix: const Icon(Icons.credit_card_rounded, color: Color(0xFF9FB0C9)),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Cardholder Name',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1B2B55),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: cardholder,
            decoration: _inputDecoration(hint: 'John Doe'),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Expiry Date',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: expiry,
                      keyboardType: TextInputType.datetime,
                      decoration: _inputDecoration(hint: 'MM/YY'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CVV',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B2B55),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: cvv,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: _inputDecoration(
                        hint: '123',
                        suffix: const Icon(Icons.lock_outline_rounded, color: Color(0xFF9FB0C9)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static InputDecoration _inputDecoration({required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF7FAFF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE1ECFF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF2F73FF), width: 1.3),
      ),
      suffixIcon: suffix,
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _InfoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 245),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EEFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFF2F73FF)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1B2B55),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7C97),
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

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PrimaryButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F73FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _SecondaryButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF2F73FF),
          side: const BorderSide(color: Color(0xFFE1ECFF)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white.withValues(alpha: 245),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
