import 'package:flutter/material.dart';
import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/view/auth/otp_screen/newpass_screen.dart';

class ForgotOtpScreen extends StatefulWidget {
  const ForgotOtpScreen({super.key});

  @override
  State<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends State<ForgotOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;

  void _handleSendOTP() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement your OTP sending logic here
      setState(() {
        _otpSent = true;
      });
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent to your email'),
          backgroundColor: ColorConstants.PRIMARYCOLOR,
        ),
      );
    }
  }

  void _handleVerifyOTP() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement your OTP verification logic here
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NewPasswordScreen()),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
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
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.PRIMARYCOLOR,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _otpSent
                      ? 'Please enter the OTP sent to your email'
                      : 'Enter your email to receive OTP',
                  style: const TextStyle(color: ColorConstants.GREYSHADE3),
                ),
                const SizedBox(height: 30),
                if (!_otpSent) ...[
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: ColorConstants.GREYSHADE3,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _handleSendOTP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.PRIMARYCOLOR,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.WHITE,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
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
                        onPressed: _handleSendOTP,
                        child: const Text(
                          'Resend OTP',
                          style: TextStyle(color: ColorConstants.PRIMARYCOLOR),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}
