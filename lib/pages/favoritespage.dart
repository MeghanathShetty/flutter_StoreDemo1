import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_demo1/utils/my_constants.dart';
import 'package:store_demo1/utils/my_controllers.dart';
import 'package:store_demo1/utils/my_widgets.dart';


class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  FavoritesController favoritesController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    favoritesController.getAllFavoriteItems();
    return Scaffold(
      backgroundColor: MyConstants.foregroundColor,
      body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 Text(
                  "Favorites",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20,),
              Obx(() {
                if (favoritesController.allFavoritesItems.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'Oops, No favorites',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: MyMasonryGridView(
                      isHomePage: false,
                    ),
                  );
                }
              }),
            ],
          ),
      ),
    );
  }
}
