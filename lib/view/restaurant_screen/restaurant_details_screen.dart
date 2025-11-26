import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/utilits/image_const.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final bool isOpen;

  const RestaurantDetailsScreen({
    Key? key,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.isOpen, required String mapUrl, required String description,
  }) : super(key: key);

  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  late String currentImage;
  final List<String> galleryImages = [
    ImageConstants.demo,
    ImageConstants.news1,
    ImageConstants.WelcomeScreen,
    ImageConstants.demo,
  ];

  @override
  void initState() {
    super.initState();
    currentImage = widget.imageUrl;
  }

  Future<void> _launchMaps() async {
    const String googleMapsUrl = "https://maps.app.goo.gl/CXuexGuNe1jY63TSA";
    final Uri url = Uri.parse(googleMapsUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Call Restaurant',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstants.restrnt,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Would you like to call $phoneNumber?',
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final Uri url = Uri.parse('tel:$phoneNumber');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Could not make the call. Please try again.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Call',
                style: TextStyle(
                  color: ColorConstants.PRIMARYCOLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                currentImage,
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConstants.restrnt.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: galleryImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentImage = galleryImages[index];
                      });
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: currentImage == galleryImages[index]
                              ? ColorConstants.PRIMARYCOLOR
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          galleryImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.name,
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.restrnt,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: widget.isOpen
                              ? ColorConstants.restrnt.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.isOpen ? 'Open Now' : 'Closed',
                          style: TextStyle(
                            color: widget.isOpen ? ColorConstants.PRIMARYCOLOR : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
              
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text(
                        widget.rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(),
                  ),
                  Text(
                    'About',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.restrnt,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Contact Information',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.restrnt,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading:  Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.restrnt.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.call,
                        color: ColorConstants.PRIMARYCOLOR,
                        size: 20,
                      ),
                    ),
                    title: const Text('+91 1234567890'),
                    contentPadding: EdgeInsets.zero,
                    onTap: () => _makePhoneCall(context, '+911234567890'),
                  
                  ),
                  ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.restrnt.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),child: const Icon(Icons.access_time, color: ColorConstants.PRIMARYCOLOR)),
                    title: const Text('Mon - Sun: 8:00 AM - 10:00 PM'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Location',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.restrnt,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _launchMaps,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(ImageConstants.map),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.WHITE,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.directions,
                                color: ColorConstants.restrnt),
                              SizedBox(width: 8),
                              Text(
                                'Get Directions',
                                style: TextStyle(
                                  color: ColorConstants.restrnt,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
