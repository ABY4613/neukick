import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/utilits/image_const.dart';
import 'package:shoe_store/view/restaurant_screen/restaurant_details_screen.dart';
import 'package:shoe_store/view/shopping_screen/shopping_details_screen.dart';
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _showSearch = false;
  late ScrollController _scrollController;
  String _selectedShoppingCategory = 'All';

  // Define colors for each tab
  final List<Color> _tabBackgroundColors = [
    ColorConstants.all,  // Green for "All" tab
    ColorConstants.place,  // Blue for "Places" tab
     // Purple for "Shopping" tab
    ColorConstants.shopping,
      ColorConstants.restrnt,  // Pink for "Restaurant" tab
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    
    // Add listener for tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});  // Rebuild to update background image
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: const [
            StretchMode.fadeTitle,
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
          ],
          centerTitle: true,
          title: Center(
            child: Container(
              height: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _showSearch 
                  ? TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: const TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          // Update search results
                        });
                      },
                    )
                  : Text(
                      _getTabTitle(_tabController.index),
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),
            ),
          ),
          background: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: _tabBackgroundColors[_tabController.index],
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 35),
            child: IconButton(
              icon: Icon(_showSearch ? Icons.close : Icons.search, 
                   color: Colors.white),
              onPressed: () {
                setState(() {
                  _showSearch = !_showSearch;
                  if (!_showSearch) {
                    _searchController.clear();
                  }
                });
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: const Border(
                bottom: BorderSide(color: Colors.white24, width: 0.5),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: ColorConstants.PRIMARYCOLOR,
              unselectedLabelColor: ColorConstants.WHITE,
              labelStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedLabelStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorConstants.PRIMARYCOLOR,
                    width: 3,
                  ),
                ),
              ),
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Places'),
                Tab(text: 'Shopping'),
                Tab(text: 'Restaurant'),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20), // Add gap below AppBar
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllTab(),
                _buildPlacesTab(),
                _buildShoppingTab(),
                _buildRestaurantTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllTab() {
    final List<Map<String, dynamic>> allItems = [
      {
        'type': 'place',
        'title': 'Tourist Spot 1',
        'location': 'Location A',
        'image': ImageConstants.WelcomeScreen,
        'rating': 4.5,
        'description': 'A beautiful tourist destination with scenic views.',
        'mapUrl': 'https://maps.app.goo.gl/y8KHNsdRhDqiA3Lq8',
        'isOpen': true,
      },
      {
        'type': 'shopping',
        'title': 'Shopping Mall',
        'location': 'Location B',
        'image': ImageConstants.news1,
        'isOpen': true,
        'description': 'A modern shopping complex with various retail outlets.',
        'type_detail': 'Shopping Complex',
      },
      {
        'type': 'restaurant',
        'title': 'Fine Dining',
        'location': 'Location C',
        'image': ImageConstants.demo,
        'rating': 4.8,
        'isOpen': true,
        'description': 'Experience fine dining at its best.',
        'mapUrl': 'https://maps.app.goo.gl/y8KHNsdRhDqiA3Lq8',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: allItems.length,
        itemBuilder: (context, index) {
          final item = allItems[index];
          
          return GestureDetector(
            onTap: () {
              switch (item['type']) {
                case 'place':
                 
                  break;
                case 'shopping':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingDetailsScreen(
                        name: item['title'],
                        type: item['type_detail'],
                        imageUrl: item['image'],
                        isOpen: item['isOpen'],
                        description: item['description'],
                      ),
                    ),
                  );
                  break;
                case 'restaurant':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantDetailsScreen(
                        name: item['title'],
                        location: item['location'],
                        imageUrl: item['image'],
                        rating: item['rating'],
                        isOpen: item['isOpen'],
                        mapUrl: item['mapUrl'],
                        description: item['description'],
                      ),
                    ),
                  );
                  break;
              }
            },
            child: _buildCardByType(item),
          );
        },
      ),
    );
  }

  Widget _buildCardByType(Map<String, dynamic> item) {
    switch (item['type']) {
      case 'place':
        return _buildPlaceCard(
          title: item['title'],
          location: item['location'],
          imageUrl: item['image'],
          rating: item['rating'],
        );
      case 'shopping':
        return _buildShoppingCard(
          title: item['title'],
          location: item['location'],
          imageUrl: item['image'],
          isOpen: item['isOpen'],
        );
      case 'restaurant':
        return _buildRestaurantCard(
          title: item['title'],
          location: item['location'],
          imageUrl: item['image'],
          rating: item['rating'],
          isOpen: item['isOpen'],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPlaceCard({
    required String title,
    required String location,
    required String imageUrl,
    required double rating,
  }) {
    return Card(
      elevation: 4,
      color: Colors.white.withOpacity(0.4),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        rating.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShoppingCard({
    required String title,
    required String location,
    required String imageUrl,
    required bool isOpen,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(location),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(isOpen ? 'Open Now' : 'Closed'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantCard({
    required String title,
    required String location,
    required String imageUrl,
    required double rating,
    required bool isOpen,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        rating.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(location),
                    const Spacer(),
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(isOpen ? 'Open Now' : 'Closed'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlacesTab() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Popular Places Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular Places',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.place,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Popular Places Horizontal List
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                  
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.asset(
                              ImageConstants.WelcomeScreen,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Popular Place ${index + 1}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    Text(' 4.${index + 5}'),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.place.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Open',
                                        style: TextStyle(
                                          color: ColorConstants.place,
                                          fontSize: 12,
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
                },
              ),
            ),

            const SizedBox(height: 24),

            // Places To Visit Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Places To Visit',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.place,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Places To Visit Vertical List
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                   
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(15),
                          ),
                          child: Image.asset(
                            ImageConstants.WelcomeScreen,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Place ${index + 1}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        'Location ${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    Text(' 4.${index + 5}'),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.place.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Open',
                                        style: TextStyle(
                                          color: ColorConstants.place,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShoppingTab() {
    final List<String> categories = [
      'All',
      'Clothing',
      'Electronics',
      'Groceries',
      'Home & Living',
      'Beauty & Care',
      'Books & Stationery',
      'Sports & Fitness',
    ];

    // Dummy data for each category
    final Map<String, List<Map<String, dynamic>>> categoryData = {
      'All': [
        {'name': 'City Mall', 'type': 'Shopping Complex', 'image': ImageConstants.demo},
        {'name': 'Metro Mall', 'type': 'Shopping Complex', 'image': ImageConstants.demo},
        {'name': 'Central Mall', 'type': 'Shopping Complex', 'image': ImageConstants.demo},
      ],
      'Clothing': [
        {'name': 'Fashion Store', 'type': 'Clothing Store', 'image': ImageConstants.demo},
        {'name': 'Trends', 'type': 'Fashion Outlet', 'image': ImageConstants.demo},
        {'name': 'Designer Hub', 'type': 'Boutique', 'image': ImageConstants.demo},
      ],
      'Electronics': [
        {'name': 'Digital World', 'type': 'Electronics Store', 'image': ImageConstants.demo},
        {'name': 'Gadget Zone', 'type': 'Mobile Shop', 'image': ImageConstants.demo},
        {'name': 'Tech Hub', 'type': 'Computer Store', 'image': ImageConstants.demo},
      ],
      'Groceries': [
        {'name': 'Fresh Mart', 'type': 'Supermarket', 'image': ImageConstants.demo},
        {'name': 'Daily Needs', 'type': 'Grocery Store', 'image': ImageConstants.demo},
        {'name': 'Super Fresh', 'type': 'Hypermarket', 'image': ImageConstants.demo},
      ],
      'Home & Living': [
        {'name': 'Home Center', 'type': 'Furniture Store', 'image': ImageConstants.demo},
        {'name': 'Living Space', 'type': 'Home Decor', 'image': ImageConstants.demo},
        {'name': 'Decor World', 'type': 'Interior Store', 'image': ImageConstants.demo},
      ],
      'Beauty & Care': [
        {'name': 'Beauty Plus', 'type': 'Cosmetics Store', 'image': ImageConstants.demo},
        {'name': 'Glamour', 'type': 'Beauty Salon', 'image': ImageConstants.demo},
        {'name': 'Style Hub', 'type': 'Spa & Beauty', 'image': ImageConstants.demo},
      ],
      'Books & Stationery': [
        {'name': 'Book World', 'type': 'Book Store', 'image': ImageConstants.demo},
        {'name': 'Study Mall', 'type': 'Stationery Shop', 'image': ImageConstants.demo},
        {'name': 'Knowledge Hub', 'type': 'Book Store', 'image': ImageConstants.demo},
      ],
      'Sports & Fitness': [
        {'name': 'Sports Zone', 'type': 'Sports Store', 'image': ImageConstants.demo},
        {'name': 'Fitness World', 'type': 'Gym Equipment', 'image': ImageConstants.demo},
        {'name': 'Active Life', 'type': 'Sports Gear', 'image': ImageConstants.demo},
      ],
    };

    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(
                    category,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _selectedShoppingCategory == category ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: _selectedShoppingCategory == category,
                  selectedColor: ColorConstants.shopping.withOpacity(0.8),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedShoppingCategory = selected ? category : 'All';
                    });
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemCount: categoryData[_selectedShoppingCategory]?.length ?? 0,
              itemBuilder: (context, index) {
                final shop = categoryData[_selectedShoppingCategory]![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingDetailsScreen(
                          name: shop['name'] as String,
                          type: shop['type'] as String,
                          imageUrl: shop['image'] as String,
                          isOpen: true,
                          description: 'This is a detailed description of ${shop['name']}. Here you can find information about the shop, its specialties, and what makes it unique. The shop offers a wide range of products and services to meet customer needs.', // Add your actual description here
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          shop['image'] as String,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        shop['name'] as String,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            shop['type'] as String,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorConstants.shopping.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Open',
                                  style: TextStyle(
                                    color: ColorConstants.shopping,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantTab() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 20, // Added padding for bottom nav
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Popular Restaurants Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular Restaurants',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.restrnt,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Popular Restaurants Horizontal List
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantDetailsScreen(
                            name: 'Restaurant ${index + 1}',
                            location: 'Location ${index + 1}',
                            imageUrl: ImageConstants.demo,
                            rating: 4.0 + (index * 0.1),
                            isOpen: true, mapUrl: '', description: '',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.asset(
                              ImageConstants.demo,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Restaurant ${index + 1}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    Text(' 4.${index + 5}'),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.restrnt.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Open',
                                        style: TextStyle(
                                          color: ColorConstants.PRIMARYCOLOR,
                                          fontSize: 12,
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
                },
              ),
            ),

            const SizedBox(height: 14),

            // Top Restaurants Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Top Restaurants',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.restrnt,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Top Restaurants List
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailsScreen(
                          name: 'Restaurant ${index + 1}',
                          location: 'Location ${index + 1}',
                          imageUrl: ImageConstants.demo,
                          rating: 4.0 + (index * 0.1),
                          isOpen: true, mapUrl: '', description: '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
                          child: Image.asset(
                            ImageConstants.demo,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Restaurant ${index + 1}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text('Location ${index + 1}'),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  Text(' 4.${index + 5}'),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.restrnt.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Open',
                                      style: TextStyle(
                                        color: ColorConstants.PRIMARYCOLOR,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  )]),
                    ),
                  );
                },
              ),
           ] ),
          
        ),
      );
  
  }

  // Helper method to get tab title
  String _getTabTitle(int index) {
    switch (index) {
      case 0:
        return 'Discover Thodupuzha';
      case 1:
        return 'Discover the Hidden Gems of Thodupuzha';
      case 2:
        return 'Discover the Shopping Centres at Thodupuzha';
      case 3:
        return 'Discover the Restaurants of Thodupuzha';
      default:
        return 'Explore';
    }
  }
}
