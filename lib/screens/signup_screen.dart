import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants/constants_colors.dart';
import 'package:shop_app/constants/routes.dart';
import 'package:shop_app/constants/toast.dart';
import 'package:shop_app/helpers/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/main_screen.dart';
import 'package:shop_app/widgets/primary_button.dart';
import 'package:shop_app/widgets/top_titles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTitles(
                  title: "Create Account",
                  subtitle: "Welcome to Happy Shop"
              ),
              const SizedBox(
                height: 66,
              ),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(
                        Icons.person_outline
                    )
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
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
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintText: "Phone",
                    prefixIcon: Icon(
                        Icons.phone_outlined
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
                title: "Create an account",
                onPressed: () async {
                  bool isVaildated = signUpVaildation(
                      email.text, password.text, name.text, phone.text);

                  if (isVaildated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .signUp(name.text, email.text, password.text, context);

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
                  "Already have an account?",
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
                    Routes.instance.push(widget: const LoginScreen(), context: context);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: kprimaryColor
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
