import 'package:flutter/material.dart';
import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/view/home_screen/homescreen.dart';

class RegisterOtpScreen extends StatefulWidget {
  final String email;

  const RegisterOtpScreen({super.key, required this.email});

  @override
  State<RegisterOtpScreen> createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  void _handleVerifyOTP() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement your OTP verification logic here

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful'),
          backgroundColor: ColorConstants.PRIMARYCOLOR,
        ),
      );

      // Navigate to home screen and remove all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
        (route) => false,
      );
    }
  }

  void _handleResendOTP() {
    // TODO: Implement resend OTP logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP resent successfully'),
        backgroundColor: ColorConstants.PRIMARYCOLOR,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2B3467)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verify Email',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.PRIMARYCOLOR,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please enter the OTP sent to ${widget.email}',
                  style: const TextStyle(color: ColorConstants.GREYSHADE3),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter OTP',
                    prefixIcon: const Icon(
                      Icons.lock_clock,
                      color: ColorConstants.GREYSHADE3,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter OTP';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _handleResendOTP,
                      child: const Text(
                        'Resend OTP',
                        style: TextStyle(color: ColorConstants.PRIMARYCOLOR),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _handleVerifyOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.PRIMARYCOLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Verify OTP',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.WHITE,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
