import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/view/details_screen/shoe_details_screen.dart';
import 'package:shoe_store/view/widget/ShoeProductCard.dart';

class ShoeProduct {
  final String imageUrl;
  final String brand;
  final String name;
  final double rating;
  final String price;
  final List<Color> colors;
  final bool isBestSeller;
  final bool isBestChoice;
  final bool isFavorite;

  ShoeProduct({
    required this.imageUrl,
    required this.brand,
    required this.name,
    required this.rating,
    required this.price,
    required this.colors,
    this.isBestSeller = false,
    this.isBestChoice = false,
    this.isFavorite = false,
  });
}

// Main Home Page
class ShoeStoreHomePage extends StatefulWidget {
  const ShoeStoreHomePage({super.key});

  @override
  State<ShoeStoreHomePage> createState() => _ShoeStoreHomePageState();
}

class _ShoeStoreHomePageState extends State<ShoeStoreHomePage> {
  final RefreshController _refreshController = RefreshController();
  String _selectedBrand = 'Nike';

  final List<Map<String, dynamic>> brands = [
    {'name': 'Nike', 'logo': Icons.checkroom},
    {'name': 'Puma', 'logo': Icons.sports_soccer},
    {'name': 'Under Armour', 'logo': Icons.fitness_center},
    {'name': 'Adidas', 'logo': Icons.sports_basketball},
    {'name': 'Converse', 'logo': Icons.star},
  ];

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
  ];

  final List<ShoeProduct> newArrivals = [
    ShoeProduct(
      imageUrl: 'assets/images/shoe2.jpg',
      brand: 'Nike',
      name: 'Nike Air Jordan',
      rating: 4.9,
      price: '\$849.69',
      colors: [Colors.white, Colors.blue],
      isBestChoice: true,
    ),
  ];

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu Icon
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.grid_view_rounded,
              color: ColorConstants.black,
              size: 24,
            ),
          ),

          // Location
          Column(
            children: [
              Text(
                'Store location',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: ColorConstants.GREYSHADE3,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Mondolibug, Sylhet',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: ColorConstants.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Cart Icon with Badge
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: ColorConstants.black,
                  size: 24,
                ),
              ),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: ColorConstants.GREYSHADE4.withOpacity(0.2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Looking for shoes',
            hintStyle: GoogleFonts.poppins(
              color: ColorConstants.GREYSHADE3,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: ColorConstants.GREYSHADE3,
              size: 24,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandsList() {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          final isSelected = _selectedBrand == brand['name'];
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedBrand = brand['name'];
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? ColorConstants.PRIMARYCOLOR : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : ColorConstants.GREYSHADE4.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      brand['logo'],
                      color: ColorConstants.black,
                      size: 20,
                    ),
                  ),
                  if (isSelected) ...[
                    SizedBox(width: 8),
                    Text(
                      brand['name'],
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorConstants.black,
            ),
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'See all',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.PRIMARYCOLOR,
                ),
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildNewArrivalCard(ShoeProduct shoe) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(

        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorConstants.PRIMARYCOLOR,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'BEST CHOICE',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  shoe.name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  shoe.price,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(shoe.imageUrl),
                fit: BoxFit.cover,
              ) ,
              borderRadius: BorderRadius.circular(16),
            ),
   ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.WHITE,
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          header: const ClassicHeader(
            refreshStyle: RefreshStyle.UnFollow,
            idleIcon: null,
            refreshingIcon: CupertinoActivityIndicator(),
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),

                // Search Bar
                _buildSearchBar(),

                // Brands List
                _buildBrandsList(),

                SizedBox(height: 24),

                // Popular Shoes Section
                _buildSectionHeader('Popular Shoes', onSeeAll: () {}),
                
                Container(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 20),
                    itemCount: popularShoes.length,
                    itemBuilder: (context, index) {
                      return ShoeProductCard(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShoeDetailsScreen( ),
      ),
    );
  }, shoe: popularShoes[index],
);

                    },
                  ),
                ),

                SizedBox(height: 24),

                // New Arrivals Section
                _buildSectionHeader('New Arrivals', onSeeAll: () {}),
                
                ...newArrivals.map((shoe) => Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: _buildNewArrivalCard(shoe),
                )),

                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}