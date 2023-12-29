import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants/constants_colors.dart';
import 'package:shop_app/constants/routes.dart';
import 'package:shop_app/constants/toast.dart';
import 'package:shop_app/helpers/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shop_app/screens/main_screen.dart';
import 'package:shop_app/screens/signup_screen.dart';
import 'package:shop_app/widgets/primary_button.dart';
import 'package:shop_app/widgets/top_titles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopTitles(
                title: "Login",
                subtitle: "Welcome back to Happy Shop"
            ),
            const SizedBox(
              height: 66,
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "E-mail",
                prefixIcon: Icon(
                  Icons.email_outlined
                )
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: password,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(
                      Icons.password_sharp
                  ),
                suffixIcon: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    isShowPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 36,
            ),
            PrimaryButton(
              title: "Login",
              onPressed: () async {
                bool isVaildated = loginVaildation(email.text, password.text);
                if (isVaildated) {
                  bool isLogined = await FirebaseAuthHelper.instance
                      .login(email.text, password.text, context);
                  if (isLogined) {
                    Routes.instance.pushAndRemoveUntil(
                        widget: const MainScreen(), context: context);
                  }
                }
              },
            ),
            SizedBox(
              height: 24,
            ),
            const Center(
              child: Text(
                "Don't have an account?",
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Center(
              child: CupertinoButton(
                onPressed: () {
                  Routes.instance.push(widget: const SignUpScreen(), context: context);
                },
                child: const Text(
                  "Create an account",
                  style: TextStyle(
                    color: kprimaryColor
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
