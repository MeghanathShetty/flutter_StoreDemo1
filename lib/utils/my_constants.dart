import 'package:flutter/material.dart';
import 'package:store_demo1/pages/homepage.dart';
import 'package:store_demo1/pages/userprofile.dart';

import '../pages/checkoutpage.dart';

class MyConstants {
  // API URL constants
  static const String fetchUserUrl = "https://randomuser.me/api/";
  static const String fetchProductUrl = "https://fakestoreapi.com/products";
  static const String fetchProductByCategory =
      "https://fakestoreapi.com/products/category";

  // Error messages
  static const String errorMsg = "Something went wrong!";
  static const String invalidResponseError = "Invalid response from server.";

  static const double borderRad = 8.0;

  // Colors
  static const Color primaryColor = Colors.black;
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color secondaryColor = Colors.grey;
  static const Color foregroundColor = Colors.white;
  static const Color ratingsCountColor = Colors.blue;

  static const List<Map<String, dynamic>> homeCategoryItems = [
    {
      'name': 'All',
      'category': 'All',
      'icon': Icons.all_inclusive,
      'isChecked': true,
    },
    {
      'name': 'Men',
      'category': 'men\'s clothing',
      'icon': Icons.male,
      'isChecked': false,
    },
    {
      'name': 'Women',
      'category': 'women\'s clothing',
      'icon': Icons.female,
      'isChecked': false,
    },
    {
      'name': 'Jewelry',
      'category': 'jewelery',
      'icon': Icons.style,
      'isChecked': false,
    },
    {
      'name': 'Electronics',
      'category': 'electronics',
      'icon': Icons.devices,
      'isChecked': false,
    },
  ];

  static const List<Map<String, dynamic>> chooseSizeItems = [
    {
      'text': 'S',
      'isChecked': false,
    },
    {
      'text': 'M',
      'isChecked': true,
    },
    {
      'text': 'L',
      'isChecked': false,
    },
    {
      'text': 'XL',
      'isChecked': false,
    },
  ];

  static const List<Map<String, dynamic>> chooseColorItems = [
    {
      'name': 'grey',
      'color': Colors.grey,
      'isChecked': false,
    },
    {
      'name': 'black',
      'color': Colors.black,
      'isChecked': true,
    },
    {
      'name': 'green',
      'color': Colors.lightGreen,
      'isChecked': false,
    }
  ];

  static List<Widget> bottomNavigationItems = [
    CheckoutPage(),
    Homepage(),
    UserProfile()
  ];
}
