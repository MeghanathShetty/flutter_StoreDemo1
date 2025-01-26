import 'package:flutter/material.dart';
import 'package:get/get.dart';

//custom
import 'package:store_demo1/utils/my_constants.dart';
import 'package:store_demo1/utils/my_widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top : 20, bottom: 0),
        child: Column(children : [
          SizedBox(height: 20),
          HomepageUserSection(),
          SizedBox(height: 20),
          HomepageSearchBar(),
          SizedBox(height: 30),
          HomepageCategory(initialItems: MyConstants.homeCategoryItems),
          SizedBox(height: 20),
          HomepageGridSection()
        ])
        )
    );
  }
}