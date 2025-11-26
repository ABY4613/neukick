import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/utilits/image_const.dart';
import 'package:shoe_store/view/auth/login_screen/login_screen.dart';
import 'package:shoe_store/view/auth/register_screen/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.WHITE,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.WelcomeScreen),
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.6), BlendMode.colorBurn),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                SizedBox(height: 20),
                Text(
                  'Welcome Back!',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.WHITE,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Choose how you want to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorConstants.WHITE,
                  ),
                ),
                const SizedBox(height: 50),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.WHITE.withOpacity(0.11),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                       side: BorderSide(color: ColorConstants.WHITE.withOpacity(0.4)),
                      ),
                      elevation: 2,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.login),
                        SizedBox(width: 10),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  RegisterScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.WHITE.withOpacity(0.1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: ColorConstants.WHITE.withOpacity(0.4)),
                      ),
                      elevation: 2,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add),
                        SizedBox(width: 10),
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
}
