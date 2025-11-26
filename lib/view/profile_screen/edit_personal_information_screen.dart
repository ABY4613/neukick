import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_store/utilits/color_const.dart';

class EditPersonalInformationScreen extends StatefulWidget {
  final Map<String, String> userInfo;

  const EditPersonalInformationScreen({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<EditPersonalInformationScreen> createState() =>
      _EditPersonalInformationScreenState();
}

class _EditPersonalInformationScreenState
    extends State<EditPersonalInformationScreen> {
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current values
    controllers = widget.userInfo.map((key, value) =>
        MapEntry(key, TextEditingController(text: value)));
  }

  @override
  void dispose() {
    // Dispose all controllers
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Widget _buildTextField(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controllers[label],
            decoration: InputDecoration(
              hintText: 'Enter $label',
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: ColorConstants.PRIMARYCOLOR,
                  width: 2,
                ),
              ),
            ),
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    // Create updated userInfo map
    Map<String, String> updatedUserInfo = {};
    controllers.forEach((key, controller) {
      updatedUserInfo[key] = controller.text;
    });

    // Return updated data to previous screen
    Navigator.pop(context, updatedUserInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Personal Information',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: Text(
              'Save',
              style: GoogleFonts.montserrat(
                color: ColorConstants.PRIMARYCOLOR,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: ColorConstants.PRIMARYCOLOR,
                      child: Text(
                        controllers['Full Name']!.text[0].toUpperCase(),
                        style: GoogleFonts.montserrat(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: ColorConstants.PRIMARYCOLOR,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ...widget.userInfo.keys.map((label) => _buildTextField(label)),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}