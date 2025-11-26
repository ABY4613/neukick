import 'package:flutter/material.dart';
import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/view/home_screen/bottomnavigation/explore_page.dart';
import 'package:shoe_store/view/home_screen/bottomnavigation/home_page.dart';
import 'package:shoe_store/view/home_screen/bottomnavigation/cart_screen.dart';
import 'package:shoe_store/view/home_screen/bottomnavigation/profile_page.dart';

class Homescreen extends StatefulWidget {
  final String? selectedLevel;
  const Homescreen({super.key, this.selectedLevel});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _pages = [
    ShoeStoreHomePage(),
    ExplorePage(),
    CartScreen(), // Cart/Bag page
    CartScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      extendBody: true,
  bottomNavigationBar: Container(
  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
  height: 40,
  decoration: BoxDecoration(
    color: Colors.transparent, // ✅ Fully transparent
    borderRadius: BorderRadius.circular(40),
    boxShadow: [], // ❌ Remove shadow for full transparency
  ),
  child: Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Positioned.fill(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home_outlined, 0),
            _buildNavItem(Icons.favorite_border, 1),
            const SizedBox(width: 70),
            _buildNavItem(Icons.notifications_outlined, 3),
            _buildNavItem(Icons.person_outline, 4),
          ],
        ),
      ),

      // Floating Center Button – keep as is
      Positioned(
        top: -50,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [ ColorConstants.PRIMARYCOLOR,ColorConstants.PRIMARYCOLOR.withOpacity(0.4),],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.PRIMARYCOLOR.withOpacity(0.4),
                blurRadius: 25,
                spreadRadius: 5,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
            
            Navigator.push(context, MaterialPageRoute(builder:  (context)=> CartScreen()));
              },
              customBorder: const CircleBorder(),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    ],
  ),
)
 );
  }

Widget _buildNavItem(IconData icon, int index) {
  final bool isSelected = _selectedIndex == index;

  return Expanded(
    child: Material(
      color: Colors.transparent, // 🔥 Prevents white flash
      child: InkWell(
        onTap: () => _onItemTapped(index),
        customBorder: const CircleBorder(),
        splashColor: Colors.transparent,    // 🔥 Remove splash
        highlightColor: Colors.transparent, // 🔥 Remove highlight
        hoverColor: Colors.transparent,
        child: Container(
          height: 80,
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: isSelected
                ? ColorConstants.PRIMARYCOLOR
                : Colors.grey,
            size: 26,
          ),
        ),
      ),
    ),
  );
}

}