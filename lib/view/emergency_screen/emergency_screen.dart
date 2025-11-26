import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/utilits/image_const.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
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
          'Emergency',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorConstants.PRIMARYCOLOR,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Women's Safety Section
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.5),
                      Colors.blue.withOpacity(0.4)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.shield_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Emergency Helpline Numbers",
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildEmergencyButton(
                                icon: Icons.local_police_outlined,
                                label: 'Police\n112',
                                onTap: () => _makeEmergencyCall('112'),
                              ),
                              _buildEmergencyButton(
                                icon: Icons.woman_outlined,
                                label: 'Women\nHelpline\n1091',
                                onTap: () => _makeEmergencyCall('1091'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildEmergencyButton(
                                icon: Icons.local_hospital_outlined,
                                label: 'Ambulance\n108',
                                onTap: () => _makeEmergencyCall('108'),
                              ),
                              _buildEmergencyButton(
                                icon: Icons.emergency_outlined,
                                label: 'Domestic\nAbuse\n181',
                                onTap: () => _makeEmergencyCall('181'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildEmergencyButton(
                                icon: Icons.warning_outlined,
                                label: 'Disaster\nHelpline\n1070',
                                onTap: () => _makeEmergencyCall('1070'),
                              ),
                              _buildEmergencyButton(
                                icon: Icons.local_fire_department_outlined,
                                label: 'Fire\nService\n101',
                                onTap: () => _makeEmergencyCall('101'),
                              ),
                            ],
                          ),
                        ],
                      ),
                     
                     
                    ])
                ),
              ),
              const SizedBox(height: 25),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 120,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: ColorConstants.WHITE.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.red, size: 30),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.aBeeZee(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }



  Future<void> _makeEmergencyCall(String number) async {
    final Uri url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  
  }

    

  final List<Image> serviceIcons = [
    Image.asset(ImageConstants.police, width: 45, height: 45, fit: BoxFit.contain),
    Image.asset(ImageConstants.elctricity, width: 45, height: 45, fit: BoxFit.contain),
    Image.asset(ImageConstants.ff, width: 45, height: 45, fit: BoxFit.contain),
    Image.asset(ImageConstants.postofice, width: 45, height: 45, fit: BoxFit.contain),
    Image.asset(ImageConstants.petrescue, width: 45, height: 45, fit: BoxFit.contain),
    Image.asset(ImageConstants.resturant, width: 45, height: 45, fit: BoxFit.contain),
    Image.asset(ImageConstants.bus, width: 45, height: 45, fit: BoxFit.contain),
    Image.asset(ImageConstants.healthcare, width: 45, height: 45, fit: BoxFit.contain),
    Image.asset(ImageConstants.healthcare, width: 45, height: 45, fit: BoxFit.contain),
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
    'More Services',
  ];

  final List<EmergencyService> emergencyServices = [
    EmergencyService(
      icon: Image.asset(ImageConstants.police, width: 30, height: 30),
      title: 'Police Emergency',
      subtitle: '24/7 Emergency Response',
    ),
    EmergencyService(
      icon: Image.asset(ImageConstants.ff, width: 30, height: 30),
      title: 'Fire & Rescue',
      subtitle: 'Immediate Fire Response',
    ),
    EmergencyService(
      icon: Image.asset(ImageConstants.healthcare, width: 30, height: 30),
      title: 'Medical Emergency',
      subtitle: 'Ambulance Services',
    ),
  ];

  final List<EmergencyContact> emergencyContacts = [
    EmergencyContact(name: 'Women Helpline', number: '1091'),
    EmergencyContact(name: 'Police Control Room', number: '112'),
    EmergencyContact(name: 'Domestic Abuse Helpline', number: '181'),
    EmergencyContact(name: 'Emergency Contact 1', number: '1234567890'),
    EmergencyContact(name: 'Emergency Contact 2', number: '0987654321'),
  ];


class EmergencyService {
  final Image icon;
  final String title;
  final String subtitle;

  EmergencyService({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class EmergencyContact {
  final String name;
  final String number;

  EmergencyContact({required this.name, required this.number});
}
