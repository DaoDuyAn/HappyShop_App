import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/welcome_screen.dart';

import '../constants/constants_colors.dart';
import '../constants/routes.dart';
import '../helpers/firebase_auth_helper/firebase_auth_helper.dart';
import '../provider/app_provider.dart';
import '../widgets/primary_button.dart';
import 'change_pass.dart';
import 'main_screen.dart';
import 'order_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kcontentColor,
        centerTitle: true,
        title: const Text(
          "Account",
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
                    MaterialPageRoute(builder: (context) => MainScreen()),
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 240,
            child: Column(
              children: [
                appProvider.getUserInformation.image == null
                    ? const Icon(
                        Icons.person_outline,
                        size: 120,
                      )
                    : CircleAvatar(
                        backgroundImage:
                            NetworkImage(appProvider.getUserInformation.image!),
                        radius: 60,
                      ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  appProvider.getUserInformation.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  appProvider.getUserInformation.email,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  width: 130,
                  child: PrimaryButton(
                    title: "Edit Profile",
                    onPressed: () {
                      // Routes.instance
                      //     .push(widget: const EditProfile(), context: context);
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const OrderScreen(), context: context);
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Your Orders"),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("Favourite"),
                ),
                ListTile(
                  onTap: () {
                    // Routes.instance
                    //     .push(widget: const AboutUs(), context: context);
                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About us"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const ChangePassword(), context: context);
                  },
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("Change Password"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut();
                    Routes.instance
                        .push(widget: WelcomeScreen(), context: context);

                    setState(() {});
                  },
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Log out"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
