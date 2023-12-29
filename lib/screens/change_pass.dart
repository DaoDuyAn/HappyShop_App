import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shop_app/screens/account_screen.dart';

import '../constants/constants_colors.dart';
import '../constants/toast.dart';
import '../helpers/firebase_auth_helper/firebase_auth_helper.dart';
import '../widgets/primary_button.dart';
import 'main_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcontentColor,
        centerTitle: true,
        title: const Text(
          "Change Password",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 56,
        leading: Container(
          margin: EdgeInsets.only(left: 20),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Container(
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AccountScreen()),
                  );
                },
                icon: const Icon(
                  Ionicons.chevron_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: 50,
          ),
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "New Password",
              prefixIcon: const Icon(
                Icons.password_sharp,
              ),
              suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  )),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            decoration: const InputDecoration(
              hintText: "Confirm Password",
              prefixIcon: Icon(
                Icons.password_sharp,
              ),

            ),
          ),
          const SizedBox(
            height: 36.0,
          ),
          PrimaryButton(
            title: "Update",
            onPressed: () async {
              if (newpassword.text.isEmpty) {
                showMessage("New Password is empty");
              } else if (confirmpassword.text.isEmpty) {
                showMessage("Confirm Password is empty");
              } else if (confirmpassword.text == newpassword.text) {
                FirebaseAuthHelper.instance
                    .changePassword(newpassword.text, context);
              } else {
                showMessage("Confrim Password is not match");
              }
            },
          ),
        ],
      ),
    );
  }
}