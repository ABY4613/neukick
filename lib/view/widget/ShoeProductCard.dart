import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/view/home_screen/bottomnavigation/home_page.dart';

class ShoeProductCard extends StatelessWidget {
  final ShoeProduct shoe;

  const ShoeProductCard({
    super.key,
    required this.shoe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          _buildProductDetails(),
        ],
      ),
    );
  }

  // -----------------------------
  // IMAGE SECTION
  // -----------------------------
  Widget _buildImageSection() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(shoe.imageUrl),
          fit: BoxFit.cover,
        ),
     //   color: ColorConstants.GREYSHADE4,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
   );
  }

  // -----------------------------
  // PRODUCT DETAILS
  // -----------------------------
  Widget _buildProductDetails() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            shoe.name,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorConstants.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                shoe.price,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.black,
                ),
              ),

              // Add Button
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: ColorConstants.PRIMARYCOLOR,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
