import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  String _selectedTab = 'Popular';
  int _cartCount = 2;
  double _cartTotal = 24.98;

  final List<String> _tabs = [
    'Popular',
    'Pizzas',
    'Sides',
    'Drinks',
    'Desserts',
  ];

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'Margherita',
      'description': 'San Marzano tomato, fior di latte, fresh basil',
      'price': 10.99,
      'badge': 'BESTSELLER',
      'image':
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=300&q=80',
    },
    {
      'title': 'Diavola',
      'description': 'Spicy salami, chilli, mozzarella, oregano',
      'price': 12.49,
      'badge': null,
      'image':
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=300&q=80',
    },
    {
      'title': 'Garlic Bread',
      'description': 'Wood-fired with rosemary butter',
      'price': 4.99,
      'badge': null,
      'image':
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=300&q=80',
    },
    {
      'title': 'Tiramisu',
      'description': 'Classic mascarpone & espresso',
      'price': 5.49,
      'badge': 'NEW',
      'image':
          'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=300&q=80',
    },
  ];

  void _addItem(Map<String, dynamic> item) {
    setState(() {
      _cartCount += 1;
      _cartTotal += (item['price'] as double);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${item['title']} to basket'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF1E1B18),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // 1. Hero Image with Floating Action Buttons
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: const Color(0xFFFAF7F2),
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xFF1E1B18),
                        size: 20,
                      ),
                    ),
                  ),
                ),
                actions: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.share_outlined,
                      color: Color(0xFF1E1B18),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      color: Color(0xFFFF5E3A),
                      size: 20,
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&q=80',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // 2. Overlapping White Restaurant Info Card
              SliverToBoxAdapter(
                child: Container(
                  transform: Matrix4.translationValues(0.0, -28.0, 0.0),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFEFEBE6)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title & Rating Badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Napoli Street Pizza',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1E1B18),
                                letterSpacing: -0.3,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF9E6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: const Color(0xFFFFE79A)),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.star_rounded,
                                      color: Color(0xFFFFB800), size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1E1B18),
                                    ),
                                  ),
                                  Text(
                                    ' (1.2k)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF78716C),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Subtitle
                        const Text(
                          'Italian · Pizza · ££ · 1.2 km away',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF8C847E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Delivery Metadata Row
                        Row(
                          children: const [
                            Icon(Icons.access_time_rounded,
                                size: 14, color: Color(0xFF78716C)),
                            SizedBox(width: 4),
                            Text('25–35 min',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF78716C),
                                    fontWeight: FontWeight.w600)),
                            Text('   ·   ',
                                style: TextStyle(color: Color(0xFF78716C))),
                            Icon(Icons.delivery_dining_rounded,
                                size: 16, color: Color(0xFF78716C)),
                            SizedBox(width: 4),
                            Text('£1.49 delivery',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF78716C),
                                    fontWeight: FontWeight.w600)),
                            Text('   ·   ',
                                style: TextStyle(color: Color(0xFF78716C))),
                            Icon(Icons.shopping_bag_outlined,
                                size: 14, color: Color(0xFF78716C)),
                            SizedBox(width: 4),
                            Text('Min. £8',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF78716C),
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Promo Callout Container (20% off)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 11),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF4F0),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFFFDDD2)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.percent_rounded,
                                      color: Color(0xFFFF5E3A), size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    '20% off orders over £20',
                                    style: TextStyle(
                                      color: Color(0xFFFF5E3A),
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'Auto-applied',
                                style: TextStyle(
                                  color: Color(0xFF8C847E),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 3. Category Filter Chips Row
              SliverToBoxAdapter(
                child: Container(
                  transform: Matrix4.translationValues(0.0, -14.0, 0.0),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 38,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _tabs.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final tab = _tabs[index];
                            final isSelected = _selectedTab == tab;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTab = tab;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF1E1B18)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF1E1B18)
                                        : const Color(0xFFEFEBE6),
                                  ),
                                ),
                                child: Text(
                                  tab,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF1E1B18),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Section Title
                      const Text(
                        'Popular',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E1B18),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              // 4. Menu Items List
              SliverPadding(
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 95),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = _menuItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFEFEBE6)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title, description, price & badge
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1E1B18),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['description'] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF78716C),
                                      height: 1.35,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        '£${(item['price'] as double).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF1E1B18),
                                        ),
                                      ),
                                      if (item['badge'] != null) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFFEDE8),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            item['badge'] as String,
                                            style: const TextStyle(
                                              color: Color(0xFFFF5E3A),
                                              fontSize: 9.5,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 14),
                            // Food photo with overlapping orange plus button
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.network(
                                    item['image'] as String,
                                    width: 78,
                                    height: 78,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: -6,
                                  right: -6,
                                  child: GestureDetector(
                                    onTap: () => _addItem(item),
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF5E3A),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFFF5E3A)
                                                .withOpacity(0.4),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: _menuItems.length,
                  ),
                ),
              ),
            ],
          ),

          // 5. Floating Dark Charcoal Cart Bar
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1B18),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5E3A),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$_cartCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'View basket',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '£${_cartTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
