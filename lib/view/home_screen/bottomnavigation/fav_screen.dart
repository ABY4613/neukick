import 'package:flutter/material.dart';
import 'package:shoe_store/view/details_screen/shoe_details_screen.dart';
import 'package:shoe_store/view/home_screen/bottomnavigation/home_page.dart';
import 'package:shoe_store/view/widget/ShoeProductCard.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

// --- SAMPLE DATA (4 ITEMS ONLY) ---
final List<ShoeProduct> popularShoes = [
  ShoeProduct(
    imageUrl: 'assets/images/shoe1.jpg',
    brand: 'Nike',
    name: 'Nike Jordan',
    rating: 4.8,
    price: '\$493.00',
    colors: [Colors.red, Colors.blue, Colors.grey],
    isBestSeller: true,
  ),
  ShoeProduct(
    imageUrl: 'assets/images/shoe2.jpg',
    brand: 'Nike',
    name: 'Nike Air Max',
    rating: 4.7,
    price: '\$897.99',
    colors: [Colors.blue, Colors.white],
    isBestSeller: true,
  ),
  ShoeProduct(
    imageUrl: 'assets/images/shoe1.jpg',
    brand: 'Adidas',
    name: 'Adidas Runner',
    rating: 4.6,
    price: '\$399.00',
    colors: [Colors.black, Colors.yellow],
    isBestSeller: true,
  ),
  ShoeProduct(
    imageUrl: 'assets/images/shoe1.jpg',
    brand: 'Puma',
    name: 'Puma Zoom',
    rating: 4.5,
    price: '\$299.00',
    colors: [Colors.green, Colors.white],
    isBestSeller: true,
  ),
];

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      
        title: const Text(
          'Favourite',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      // --- GRID VIEW 4 CARDS ---
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: popularShoes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
            
          ),
          itemBuilder: (context, index) {
            final shoe = popularShoes[index];
            return ShoeProductCard(
              shoe: shoe,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoeDetailsScreen(
                    //  shoe: shoe, // PASS THE SHOE
                    ),
                  ),
                );
              },
            );
            
          },
        ),
      ),
    );
  }
}
