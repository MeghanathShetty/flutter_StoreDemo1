import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:store_demo1/models/products_model.dart';
import 'package:store_demo1/pages/detailspage.dart';
import 'package:store_demo1/pages/homepage.dart';
import 'package:store_demo1/utils/my_controllers.dart';
import 'my_apis.dart';
import 'package:get/get.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

import 'my_constants.dart';

// var emojiParser = EmojiParser();

class HomepageUserSection extends StatelessWidget {
  HomepageUserSection({super.key});

  final UserDioController userDioController = Get.put(UserDioController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userDioController.user.value == null) {
        return Center(child: Text("Fetching....."));
      }

      final data = userDioController.user.value!;
      final user = data.results[0];

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hello message
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Welcome \u{1F44B}\u{1F3FB}",
                style: TextStyle(fontSize: 11),
              ),
              Text(
                '${user.name.first} ${user.name.last}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          // User Image
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Make the container circular
              ),
              child: ClipOval(
                child: Image.network(
                  user.picture.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class HomepageSearchBar extends StatelessWidget {
  HomepageSearchBar({super.key});
  final MySearchController searchController = Get.put(MySearchController());
  // late String str;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Bar
        Expanded(
            child: Container(
          height: 40,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(MyConstants.borderRad),
            border: Border.all(color: MyConstants.borderColor, width: 1),
          ),
          child: TextField(
            onChanged: (value) {
              searchController.setSearch(value);
            },
            decoration: InputDecoration(
              hintText: 'Search clothes...',
              prefixIcon: Icon(Icons.search, color: MyConstants.secondaryColor),
              contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              border: InputBorder.none,
            ),
          ),
        )),
        SizedBox(
          width: 20,
        ),

        // Filter Icon
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: MyConstants.primaryColor,
            borderRadius: BorderRadius.circular(MyConstants.borderRad),
          ),
          child: Icon(
            Icons.filter_list,
            color: MyConstants.foregroundColor,
            size: 24,
          ),
        ),
      ],
    );
  }
}

class HomepageCategory extends StatelessWidget {
  final RxList<Map<String, dynamic>> items;

  HomepageCategory(
      {super.key, required List<Map<String, dynamic>> initialItems})
      : items = RxList(initialItems
            .map((item) => {
                  'name': item['name'],
                  'category': item['category'],
                  'icon': item['icon'],
                  'isChecked': RxBool(item['isChecked'] ?? false),
                })
            .toList());

  HomepageCategoryController catController =
      Get.put(HomepageCategoryController());

  @override
  Widget build(BuildContext context) {
    catController.setItems(items);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          spacing: 20,
          children: catController.items.map((item) {
            return GestureDetector(
              onTap: () {
                catController.toggleCheck(catController.items.indexOf(item));
              },
              child: Obx(() => Container(
                    // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item['isChecked'].value
                          ? MyConstants.primaryColor
                          : MyConstants.foregroundColor,
                      borderRadius:
                          BorderRadius.circular(MyConstants.borderRad),
                      border: Border.all(
                        color: MyConstants.borderColor,
                        width: 1,
                      ),
                    ),
                    child: Row(children: [
                      Icon(
                        item['icon'],
                        color: item['isChecked'].value
                            ? MyConstants.foregroundColor
                            : MyConstants.primaryColor,
                        size: 24,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        item['name'],
                        style: TextStyle(
                          color: item['isChecked'].value
                              ? MyConstants.foregroundColor
                              : MyConstants.primaryColor,
                        ),
                      )
                    ]),
                  )),
            );
          }).toList()),
    );
  }
}

class HomepageGridSection extends StatelessWidget {
  HomepageGridSection({super.key});

  ProductDioController productController = Get.put(ProductDioController());
  MySearchController searchController = Get.put(MySearchController());
  @override
  Widget build(BuildContext context) {
    productController.getProducts(); // Warning
    return Expanded(child: Obx(() {
      if (productController.products.isEmpty) {
        return Center(
            child: Text('Nothing to display',
                style: TextStyle(fontWeight: FontWeight.bold)));
      }
      // Search
      var searchedItems = productController.products.where((item) {
        return item.title
            .toLowerCase()
            .contains(searchController.query.value.toLowerCase());
      }).toList();

      if (productController.products.isEmpty || searchedItems.isEmpty) {
        return Center(
            child: Text(
          "Nothing to display",
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
      }

      return MyMasonryGridView(searchedItems: searchedItems);
    }));
  }
}

class MyRatingSection extends StatelessWidget {
  late var item;
  MyRatingSection({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // Rating Icon
      Icon(
        Icons.star,
        color: Colors.yellow,
        size: 18,
      ),
      SizedBox(
        width: 5,
      ),
      // Rating Text
      Text(
        item.rating.rate.toString(),
        style: TextStyle(
          color: MyConstants.secondaryColor,
        ),
      ),
    ]);
  }
}

class MyFavIcon extends StatelessWidget {
  var item;
  double width, height, heartSize;
  MyFavIcon({super.key, required this.item, this.width = 27.0, this.height = 27.0, this.heartSize = 18});

  FavoritesController favoritesController = Get.put(FavoritesController());
  @override
  Widget build(BuildContext context) {
    favoritesController.checkFav(item.id);
    return GestureDetector(
        onTap: () {
          favoritesController.toggleFavorite(item.id);
        },
        child: Container(
            width: width, // width & height should be same for circle
            height: height,
            decoration: BoxDecoration(
              color: MyConstants.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Obx(
              () => Icon(
                favoritesController.favouritesList.contains(item.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: MyConstants.foregroundColor,
                size: heartSize,
              ),
            )));
  }
}

class MyBackButton extends StatelessWidget {
  VoidCallback? onPressed;
  MyBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4,
      left: 4,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: MyConstants.primaryColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3), // Offset for shadow to appear below
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: MyConstants.foregroundColor,
            child: Icon(
              Icons.arrow_back,
              color: MyConstants.primaryColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsPageImageSection extends StatelessWidget {
  late var item;
  DetailsPageImageSection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.center,
      child:
          // Image
          SizedBox(
        height: screenHeight * 0.5,
        // Image
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.image,
            fit: BoxFit.cover, // Ensure image scales properly
          ),
        ),
      ),
    );
  }
}

class MyQuantitySection extends StatelessWidget {
  late var item;
  bool isDetailPage;
  MyQuantitySection({super.key, required this.item, this.isDetailPage = false});

  ChooseQuantityController chooseQuantityController =
      Get.put(ChooseQuantityController());
  @override
  Widget build(BuildContext context) {
    chooseQuantityController.refreshQtyObs();

    return Row(children: [
      // Minus Container
      GestureDetector(
        onTap: () {
          chooseQuantityController.removeQty(item, isDetailPage: isDetailPage);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: MyConstants.primaryColor,
              width: 1,
            ),
          ),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: MyConstants.foregroundColor,
            child: Icon(
              Icons.remove,
              color: MyConstants.primaryColor,
              size: 20,
            ),
          ),
        ),
      ),

      SizedBox(
        width: 10,
      ),
      // Count
      Obx(
        () => Text(
          isDetailPage
              ? (chooseQuantityController.qtys.containsKey(item['id'])
                  ? chooseQuantityController.qtys[item['id']]?.toString() ?? '0'
                  : chooseQuantityController.qty.value.toString())
              : chooseQuantityController.qtys[item['id']]?.toString() ?? '0',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        width: 10,
      ),

      // Plus Container
      GestureDetector(
        onTap: () {
          chooseQuantityController.addQty(item, isDetailPage: isDetailPage);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: MyConstants.primaryColor,
              width: 1,
            ),
          ),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: MyConstants.foregroundColor,
            child: Icon(Icons.add, color: MyConstants.primaryColor, size: 20),
          ),
        ),
      ),
    ]);
  }
}

class ChooseSizeSection extends StatelessWidget {
  final RxList<Map<String, dynamic>> items;

  ChooseSizeSection(
      {super.key, required List<Map<String, dynamic>> initialItems})
      : items = RxList(initialItems
            .map((item) => {
                  'text': item['text'],
                  'isChecked': RxBool(item['isChecked'] ?? false),
                })
            .toList());

  ChooseSizeController sizeController = Get.put(ChooseSizeController());
  @override
  Widget build(BuildContext context) {
    sizeController.setItems(items);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Size",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        // items
        Row(
            spacing: 10,
            children: sizeController.items.map((item) {
              return Obx(() => GestureDetector(
                    onTap: () {
                      sizeController
                          .toggleCheck(sizeController.items.indexOf(item));
                    },
                    child: Container(
                      padding: EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyConstants.primaryColor,
                          width: 1,
                        ),
                        color: item['isChecked'].value
                            ? MyConstants.primaryColor
                            : MyConstants.foregroundColor,
                      ),
                      child: CircleAvatar(
                          radius: 10,
                          backgroundColor: item['isChecked'].value
                              ? MyConstants.primaryColor
                              : MyConstants.foregroundColor,
                          child: Text(
                            item['text'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: item['isChecked'].value
                                    ? MyConstants.foregroundColor
                                    : MyConstants.primaryColor),
                          )),
                    ),
                  ));
            }).toList()),
      ],
    );
  }
}

class ChooseColorSection extends StatelessWidget {
  final RxList<Map<String, dynamic>> items;

  ChooseColorSection(
      {super.key, required List<Map<String, dynamic>> initialItems})
      : items = RxList(initialItems
            .map((item) => {
                  'name': item['name'],
                  'color': item['color'],
                  'isChecked': RxBool(item['isChecked'] ?? false),
                })
            .toList());

  ChooseColorController colorController = Get.put(ChooseColorController());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double selectedItemSize = screenWidth>600? 12 : 12;
    colorController.setItems(items);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        // items
        Row(
            spacing: 10,
            children: colorController.items.map((item) {
              return GestureDetector(
                onTap: () {
                  colorController
                      .toggleCheck(colorController.items.indexOf(item));
                },
                child: Obx(() => CircleAvatar(
                      radius: item['isChecked'].value ? selectedItemSize : 10,
                      backgroundColor: item['color'],
                    )),
              );
            }).toList()),
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const MyButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth > 600 ? 300 : double.maxFinite,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(MyConstants.primaryColor)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            text,
            style: TextStyle(fontSize: 17, color: MyConstants.foregroundColor),
          ),
        ),
      ),
    );
  }
}

class CheckoutListSection extends StatelessWidget {
  CheckoutListSection({super.key});
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.4,
      child: ListView.builder(
          itemCount: cartController.checkoutsObs.value.length,
          itemBuilder: (context, index) {
            var key = cartController.checkoutsObs.value.keys.elementAt(index);
            var item = cartController.checkoutsObs.value[key];
            return GestureDetector(
              // onTap: () => Get.to(() => DetailsPage(item: item,)),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MyConstants.borderRad),
                  border: Border.all(
                    color: MyConstants.borderColor,
                    width: 1,
                  ),
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        width: 80,
                        item?['image'],
                        fit: BoxFit.cover, // Ensure image scales properly
                      ),
                    ),

                    // Other Details such as Name, category, etc.
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name and Remove Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name
                              SizedBox(
                                width: screenWidth > 600 ? 500 : 120,
                                child: Text(
                                  item?['title'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cartController.removeFromCart(key);
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: screenWidth > 600 ? 22 : 18,
                                ),
                              )
                            ],
                          ),

                          // Category
                          Text(
                            item?['category'],
                            style: TextStyle(
                                fontSize: 12,
                                color: MyConstants.secondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          // Price
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$${item?['price'].toString()}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                MyQuantitySection(
                                  item: item,
                                )
                              ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class ShippingInfoSection extends StatelessWidget {
  ShippingInfoSection({super.key});

  CartController cartController = Get.put(CartController());
  ShippingPageController shippingPageController =
      Get.put(ShippingPageController());

  ChooseQuantityController chooseQuantityController =
      Get.put(ChooseQuantityController());
  @override
  Widget build(BuildContext context) {
    shippingPageController.calculateTotal(); // Warning
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            // Total items and its price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total (${cartController.checkoutsObs.length} items)',
                  style: TextStyle(color: MyConstants.secondaryColor),
                ),
                SizedBox(
                  width: 5,
                ),
                Obx(() => Text(
                      '\$${shippingPageController.total.value}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            // Shipping Fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Fee',
                  style: TextStyle(color: MyConstants.secondaryColor),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '\$23.0',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            // Discount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discount',
                  style: TextStyle(color: MyConstants.secondaryColor),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '\$40.0',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Sub Total
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: MyConstants.borderColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Obx(() => Text(
                          '\$${shippingPageController.subTotal.value}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Pay button
            Center(
                child: MyButton(
                    onPressed: () {
                      cartController.clearCheckoutItems();
                      chooseQuantityController.qtys.clear();
                    },
                    text: "Pay"))
          ],
        ),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({super.key});

  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.only(bottom: 5),
        width: screenWidth > 600 ? screenWidth * 0.3 : screenWidth * 0.95,
        height: 72,
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: MyConstants.foregroundColor.withOpacity(0.6),
              offset: Offset(0, screenWidth > 600 ? -5 : -15),
              blurRadius: 30,
              spreadRadius: screenWidth > 600 ? 10 : 20,
            ),
          ],
          // color: MyConstants.borderColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: MyConstants.borderColor,
            width: 1,
          ),
          color: MyConstants.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart
            GestureDetector(
              onTap: () {
                bottomNavigationController.setIndex(0);
              },
              child: Obx(() => Column(
                    children: [
                      Icon(Icons.shopping_cart,
                          color: bottomNavigationController.index.value == 0
                              ? Colors.purple
                              : MyConstants.foregroundColor),
                      Text(
                        "Cart",
                        style: TextStyle(
                            color: bottomNavigationController.index.value == 0
                                ? Colors.purple
                                : MyConstants.foregroundColor,
                            fontSize: 10),
                      )
                    ],
                  )),
            ),
            // Cart
            GestureDetector(
              onTap: () {
                bottomNavigationController.setIndex(1);
              },
              child: Obx(() => Column(
                    children: [
                      Icon(Icons.favorite,
                          color: bottomNavigationController.index.value == 1
                              ? Colors.purple
                              : MyConstants.foregroundColor),
                      Text(
                        "Favorites",
                        style: TextStyle(
                            color: bottomNavigationController.index.value == 1
                                ? Colors.purple
                                : MyConstants.foregroundColor,
                            fontSize: 10),
                      )
                    ],
                  )),
            ),
            // Home
            GestureDetector(
              onTap: () {
                bottomNavigationController.setIndex(2);
              },
              child: Obx(() => Column(
                    children: [
                      Icon(Icons.home,
                          color: bottomNavigationController.index.value == 2
                              ? Colors.purple
                              : MyConstants.foregroundColor),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: bottomNavigationController.index.value == 2
                                ? Colors.purple
                                : MyConstants.foregroundColor,
                            fontSize: 10),
                      )
                    ],
                  )),
            ),
            // User

            GestureDetector(
              onTap: () {
                bottomNavigationController.setIndex(3);
              },
              child: Obx(() => Column(
                    children: [
                      Icon(Icons.person,
                          color: bottomNavigationController.index.value == 3
                              ? Colors.purple
                              : MyConstants.foregroundColor),
                      Text(
                        "User",
                        style: TextStyle(
                            color: bottomNavigationController.index.value == 3
                                ? Colors.purple
                                : MyConstants.foregroundColor,
                            fontSize: 10),
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}

class MyMasonryGridView extends StatelessWidget {
  bool isHomePage;
  var searchedItems;
  MyMasonryGridView({super.key, this.isHomePage = true, this.searchedItems});

  ProductDioController productController = Get.put(ProductDioController());
  MySearchController searchController = Get.put(MySearchController());

  FavoritesController favoritesController = Get.put(FavoritesController());
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300, // Max width for each item
      ),
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      padding: EdgeInsets.only(bottom: 100),
      itemCount: isHomePage
          ? (searchController.query.value.isEmpty
              ? productController.products.length
              : searchedItems.length)
          : favoritesController.allFavoritesItems.length,
      itemBuilder: (context, index) {
        var item = isHomePage
            ? (searchController.query.value.isEmpty
                ? productController.products[index]
                : searchedItems[index])
            : favoritesController.allFavoritesItems[index];

        return GestureDetector(
          onTap: () => Get.to(() => DetailsPage(
                item: item,
              )),
          child: Container(
            // margin: EdgeInsets.all(screenWidth > 600 ? 10.0 : 5.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              // color: MyConstants.borderColor,
              borderRadius: BorderRadius.circular(MyConstants.borderRad),
              border: Border.all(
                color: MyConstants.borderColor,
                width: 1,
              ),
            ),
            child: Stack(children: [
              // Main data
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.image,
                      fit: BoxFit.cover, // Ensure image scales properly
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Name Text
                  Text(
                    item.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Category Text
                  Text(
                    item.category,
                    style: TextStyle(
                      color: MyConstants.secondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Price and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        '\$${item.price.toString()}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Rating Icon and Rating
                      MyRatingSection(item: item)
                    ],
                  )
                ],
              ),
              // Fav Icon Container
              Positioned(
                  top: 4,
                  right: 2,
                  child: MyFavIcon(
                    item: item,
                  ))
            ]),
          ),
        );
      },
    );
  }
}
