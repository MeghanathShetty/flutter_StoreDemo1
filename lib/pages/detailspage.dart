import 'package:flutter/material.dart';
import 'package:store_demo1/utils/my_constants.dart';
import 'package:store_demo1/utils/my_controllers.dart';
import 'package:store_demo1/utils/my_widgets.dart';
import 'package:get/get.dart';

class DetailsPage extends StatelessWidget {
  late var item;
  DetailsPage({super.key, required this.item});

  CartController addToCartController = Get.put(CartController());
  ChooseQuantityController chooseQuantityController =
      Get.put(ChooseQuantityController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    addToCartController.refreshToObsCart();
    return Scaffold(
        backgroundColor: MyConstants.foregroundColor,
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Stack(children: [
              // Main section
              Positioned.fill(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false), // Disable scrollbars
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          DetailsPageImageSection(item: item),
                          SizedBox(
                            height: 20,
                          ),
                          // Name, Ratings & Count, Qnty
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Name, Ratings & Count
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Name
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      // maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // Ratings & Count
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          MyRatingSection(item: item),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '(${item.rating.count.toString() ?? "--"} reviews)',
                                            style: TextStyle(
                                                color: MyConstants
                                                    .ratingsCountColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Qnty
                              MyQuantitySection(
                                  item: item.toJson(), isDetailPage: true)
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                  
                          // Description and others
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Description
                              Text(
                                item.description,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // Size and Color Section
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ChooseSizeSection(
                                      initialItems: MyConstants.chooseSizeItems),
                                  ChooseColorSection(
                                      initialItems: MyConstants.chooseColorItems)
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // Add to Cart Button
                              Center(
                                child: Obx(() => MyButton(
                                    onPressed: () {
                                      addToCartController.checkoutsObs.value
                                              .containsKey(item.id)
                                          ? addToCartController
                                              .removeFromCart(item.id)
                                          : addToCartController.addToCart(
                                              item.id,
                                              chooseQuantityController.qtys
                                                      .containsKey(item.id)
                                                  ? chooseQuantityController
                                                          .qtys[item.id] ??
                                                      chooseQuantityController
                                                          .qty.value
                                                  : chooseQuantityController
                                                      .qty.value,
                                              item.toJson());
                                    },
                                    text: addToCartController.checkoutsObs.value
                                            .containsKey(item.id)
                                        ? 'Remove from Cart'
                                        : 'Add to Cart | \$${item.price}')),
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
              // Fav Icon
              Positioned(
                top: 4, right: 2,
                child: MyFavIcon( item: item, width: 38.0, height: 38.0, heartSize: 25,)),
              // Back Button
              Positioned(
                top:4, left: 2,
                child: MyBackButton(onPressed: () => Get.back())),
            ])));
  }
}
