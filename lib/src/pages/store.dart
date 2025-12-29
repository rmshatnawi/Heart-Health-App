// lib/src/pages/store.dart (or your store file name)
import 'package:flutter/material.dart';
import 'payment.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  static const double _frameW = 412.0;
  static const double _frameH = 917.0;

  final TextEditingController _search = TextEditingController();

  final List<String> _categories = const [
    'All',
    'Monitors',
    'Thermometers',
    'Masks',
    'Medication',
  ];

  int _selectedCategory = 0;

  final List<StoreProduct> _allProducts = const [
    StoreProduct(
      title: 'Digital Blood Pressure Monitor',
      price: 49.99,
      category: 'Monitors',
      imageUrl:
      'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?auto=format&fit=crop&w=1200&q=70',
    ),
    StoreProduct(
      title: 'Digital Infrared Thermometer',
      price: 24.99,
      category: 'Thermometers',
      imageUrl:
      'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?auto=format&fit=crop&w=1200&q=70',
    ),
    StoreProduct(
      title: 'Disposable Medical Face Masks (50 pcs)',
      price: 19.99,
      category: 'Masks',
      imageUrl:
      'https://images.unsplash.com/photo-1584634731339-252c581abfc5?auto=format&fit=crop&w=1200&q=70',
    ),
    StoreProduct(
      title: 'Pain Relief Medication - Extra Strength',
      price: 12.99,
      category: 'Medication',
      imageUrl:
      'https://images.unsplash.com/photo-1587854692152-cbe660dbde88?auto=format&fit=crop&w=1200&q=70',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<StoreProduct> get _filtered {
    final q = _search.text.trim().toLowerCase();
    final selected = _categories[_selectedCategory];

    return _allProducts.where((p) {
      final matchCategory = selected == 'All' || p.category == selected;
      final matchQuery = q.isEmpty || p.title.toLowerCase().contains(q);
      return matchCategory && matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Scaffold(
      // outside background (web/desktop)
      backgroundColor: const Color(0xFFEEF2FA),
      body: SafeArea(
        child: Center(
          // FIXED FRAME SIZE
          child: SizedBox(
            width: _frameW,
            height: _frameH,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Scaffold(
                backgroundColor: const Color(0xFFF3F6FF),
                body: SafeArea(
                  child: Column(
                    children: [
                      _TopHeader(
                        title: 'You Need It Store',
                        subtitle: 'Medical Supplies',
                        onBack: () => Navigator.of(context).pop(),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder<int>(
                                valueListenable: cart.itemCount,
                                builder: (_, count, __) {
                                  return _SearchRow(
                                    controller: _search,
                                    cartCount: count,
                                    onCartTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => const PaymentPage(),
                                        ),
                                      );
                                    },
                                    onChanged: (_) => setState(() {}),
                                  );
                                },
                              ),
                              const SizedBox(height: 18),
                              const Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1B2B55),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 44,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _categories.length,
                                  separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                                  itemBuilder: (context, i) {
                                    final selected = i == _selectedCategory;
                                    return _CategoryChip(
                                      text: _categories[i],
                                      selected: selected,
                                      icon: _categoryIcon(_categories[i]),
                                      onTap: () =>
                                          setState(() => _selectedCategory = i),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 18),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Featured Products',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF1B2B55),
                                    ),
                                  ),
                                  Text(
                                    '${items.length} items',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF6B7C97),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              GridView.builder(
                                itemCount: items.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 14,
                                  crossAxisSpacing: 14,
                                  childAspectRatio: 0.74,
                                ),
                                itemBuilder: (context, index) {
                                  final p = items[index];
                                  return _ProductCard(
                                    product: p,
                                    onFavTap: () {},
                                    onAddTap: () {
                                      // (1) add to basket model
                                      cart.add(p);
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 18),
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2F73FF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const PaymentPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Go to Payment',
                                    style: TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData? _categoryIcon(String name) {
    switch (name) {
      case 'Monitors':
        return Icons.monitor_heart_outlined;
      case 'Thermometers':
        return Icons.thermostat_outlined;
      case 'Masks':
        return Icons.masks_outlined;
      case 'Medication':
        return Icons.medication_outlined;
      default:
        return null;
    }
  }
}

class _TopHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;

  const _TopHeader({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF2F73FF);

    return Container(
      color: blue,
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
          ),
          const SizedBox(width: 6),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.favorite_border, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xE6FFFFFF),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _SearchRow extends StatelessWidget {
  final TextEditingController controller;
  final int cartCount;
  final VoidCallback onCartTap;
  final ValueChanged<String> onChanged;

  const _SearchRow({
    required this.controller,
    required this.cartCount,
    required this.onCartTap,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 245),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE6EEFF)),
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Search medical supplies...',
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onCartTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF2F73FF),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 14,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.white),
              ),
              if (cartCount > 0)
                Positioned(
                  right: -2,
                  top: -6,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE53935),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String text;
  final bool selected;
  final IconData? icon;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.text,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xFF2F73FF) : const Color(0xFFEAF2FF);
    final fg = selected ? Colors.white : const Color(0xFF2F73FF);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: fg),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: fg,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final StoreProduct product;
  final VoidCallback onFavTap;
  final VoidCallback onAddTap;

  const _ProductCard({
    required this.product,
    required this.onFavTap,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFEAF2FF),
                        child: const Center(
                          child: Icon(Icons.image_not_supported_outlined),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: onFavTap,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 235),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          size: 18,
                          color: Color(0xFF6B7C97),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: Color(0xFF1B2B55),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF2F73FF),
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 34,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2F73FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onPressed: onAddTap,
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Add',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
