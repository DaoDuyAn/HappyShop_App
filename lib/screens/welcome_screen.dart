
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants/assest_images.dart';
import 'package:shop_app/constants/routes.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/signup_screen.dart';
import 'package:shop_app/widgets/primary_button.dart';
import 'package:shop_app/widgets/top_titles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Center(
                child: Image.asset(AssetsImages.instance.welcomeImage,
                alignment: Alignment.center,
                  scale: 4.5,
            )),

            // Logo FB & GG <3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.facebook,
                    size: 35,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: Image.asset(AssetsImages.instance.googleLogo,
                    alignment: Alignment.center,
                    scale: 48,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            PrimaryButton(
              title: "Login",
              onPressed: () {
                Routes.instance.push(widget: const LoginScreen(), context: context);
              }
            ),
            const SizedBox(
              height: 18,
            ),
            PrimaryButton(
                title: "Sign Up",
                onPressed: () {
                  Routes.instance.push(widget: const SignUpScreen(), context: context);
                }
            ),
          ],
        ),
      )
    );
  }
}
