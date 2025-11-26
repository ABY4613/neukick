import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/utilits/image_const.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.WHITE,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorConstants.PRIMARYCOLOR),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'All Services',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorConstants.GREYSHADE3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: 120, // Increased from 130 to 150
                ),
                itemCount: serviceIcons.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Handle service tap
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.PRIMARYCOLOR.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 70, // Increased from 60 to 80
                              child: Center(
                                child: serviceIcons[index],heightFactor: 12,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Text(
                                serviceTitles[index],
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.black,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  final List<Image> serviceIcons = [
    Image.asset(ImageConstants.police, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.elctricity, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.ff, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.postofice, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.petrescue, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.resturant, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.bus, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.healthcare, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.waste, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.jobs, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.banking, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.education, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.library, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.gas, scale: 0.5, fit: BoxFit.contain),
    Image.asset(ImageConstants.internet, scale: 0.5, fit: BoxFit.contain),
  ];

  final List<String> serviceTitles = [
    'Police',
    'Electricity',
    'Fire Force',
    'Post Office',
    'Pet Rescue',
    'Restaurant',
    'Bus Service',
    'Health Care',
    'Waste\nManagement',
    'Jobs',
    'Banking',
    'Education',
    'Library',
    'Gas Service',
    'Internet',
  ];
}
