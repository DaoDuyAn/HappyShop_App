import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/theme.dart';
import 'package:shop_app/helpers/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:shop_app/provider/app_provider.dart';
import 'package:shop_app/screens/welcome_screen.dart';
import 'package:shop_app/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDahLuq28YbtOcUE8J-eP-kSF7oiQlBYQ8",
      appId: "1:176085573822:web:f5b6fd498e90a174443eef",
      messagingSenderId: "176085573822",
      projectId: "shop-app-de84b",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Hàm tạo

  @override
  Widget build(BuildContext context) {
    // Tạo ra giao diện cho Widget
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowMaterialGrid: false,
        title: "Shop App",

        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainScreen();
            }
            return const WelcomeScreen();
          },
        ),
       // home: MainScreen(),
        debugShowCheckedModeBanner: false,
        theme: themeData,
      ),
    );
  }
}
