import 'package:flutter/material.dart';
import 'package:store_demo1/pages/checkoutpage.dart';
import 'package:store_demo1/pages/favoritespage.dart';
import 'package:store_demo1/pages/homepage.dart';
import 'package:store_demo1/pages/userprofile.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_demo1/utils/my_controllers.dart';
import 'package:store_demo1/utils/my_hive_functions.dart';
import 'package:store_demo1/utils/my_widgets.dart';

Future<void> main() async {
  // Hive Logic..............
  await Hive.initFlutter();
  registerUserAdapters();
  registerProductsAdapters();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Store Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final BottomNavigationController bottomNavigationController =
  Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      body: Stack(
        children: [
          Obx(()=>
          // Main content based on the current index
          Positioned.fill(
            child: bottomNavigationController.index == 0
                ? CheckoutPage()
                : bottomNavigationController.index == 1
                ? FavoritesPage()
                : bottomNavigationController.index == 2? Homepage() :
                UserProfile()
          )
          ),

          // Bottom navigation bar aligned to the bottom center
          Align(
            alignment: Alignment.bottomCenter,
            child: MyBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}
