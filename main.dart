import 'package:flutter/material.dart';

void main() {
  runApp(const FoodMenuApp());
}

// ==========================================
// 1. Model Class for Food Item
// ==========================================
class FoodItem {
  final String name;
  final double price;
  final double rating;
  final String imageUrl;

  const FoodItem({
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });
}

// ==========================================
// 2. Root App with Custom Light & Dark Themes
// ==========================================
class FoodMenuApp extends StatefulWidget {
  const FoodMenuApp({super.key});

  @override
  State<FoodMenuApp> createState() => _FoodMenuAppState();
}

class _FoodMenuAppState extends State<FoodMenuApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  // Custom Light Theme
  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Colors.deepOrange,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepOrange,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E1E1E),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF555555),
        ),
      ),
    );
  }

  // Custom Dark Theme
  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Colors.orangeAccent,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepOrange,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F1F1F),
        foregroundColor: Colors.orangeAccent,
        elevation: 2,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.orangeAccent,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFBDBDBD),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Menu',
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: FoodMenuScreen(
        isDarkMode: _isDarkMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

// ==========================================
// 3. Responsive Food Menu Screen
// ==========================================
class FoodMenuScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const FoodMenuScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  static const List<FoodItem> _foodItems = [
    FoodItem(
      name: 'Classic Cheese Burger',
      price: 8.99,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
    ),
    FoodItem(
      name: 'Margherita Wood-Fired Pizza',
      price: 12.50,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=500',
    ),
    FoodItem(
      name: 'Spicy Chicken Biryani',
      price: 10.75,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=500',
    ),
    FoodItem(
      name: 'Creamy Alfredo Pasta',
      price: 11.20,
      rating: 4.5,
      imageUrl:
          'https://images.unsplash.com/photo-1645112411341-6c4fd023714a?w=500',
    ),
    FoodItem(
      name: 'Grilled Chicken Salad',
      price: 7.80,
      rating: 4.4,
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500',
    ),
    FoodItem(
      name: 'Chocolate Lava Cake',
      price: 6.50,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1624353365286-3f8d62daad51?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Menu', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            tooltip: isDarkMode
                ? 'Switch to Light Mode'
                : 'Switch to Dark Mode',
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Breakpoint: < 600px = Phone (ListView), >= 600px = Wider screen (GridView)
            final bool isWideScreen = constraints.maxWidth >= 600;

            if (!isWideScreen) {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _foodItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FoodCard(food: _foodItems[index], isGrid: false),
                  );
                },
              );
            }

            // Wider screens (Tablets / Landscape mode)
            final int crossAxisCount = constraints.maxWidth >= 950 ? 3 : 2;

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _foodItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent:
                    250, // Fixed height prevents overflow in landscape
              ),
              itemBuilder: (context, index) {
                return FoodCard(food: _foodItems[index], isGrid: true);
              },
            );
          },
        ),
      ),
    );
  }
}

// ==========================================
// 4. Reusable FoodCard Widget (Row, Column, Stack, Expanded)
// ==========================================
class FoodCard extends StatelessWidget {
  final FoodItem food;
  final bool isGrid;

  const FoodCard({super.key, required this.food, required this.isGrid});

  // Reusable Image + Rating Badge built with Stack
  Widget _buildImageWithRating(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          food.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Icon(Icons.fastfood, size: 40),
            );
          },
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 14),
                const SizedBox(width: 4),
                Text(
                  food.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Reusable Details Section using Column, Row & Expanded
  Widget _buildDetails(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          food.name,
          style: textTheme.titleMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                '\$${food.price.toStringAsFixed(2)}',
                style: textTheme.bodyMedium?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.add_circle, color: primaryColor, size: 24),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: isGrid
          // GridView Layout: Column + Expanded + Stack + Row
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildImageWithRating(context)),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: _buildDetails(context),
                ),
              ],
            )
          // ListView Layout: Row + Stack + Expanded + Column
          : SizedBox(
              height: 112,
              child: Row(
                children: [
                  SizedBox(
                    width: 125,
                    height: double.infinity,
                    child: _buildImageWithRating(context),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: _buildDetails(context),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
