import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:store_demo1/models/products_model.dart';
import 'package:store_demo1/utils/my_apis.dart';
import '../models/user_model.dart';
import 'my_constants.dart';

class HomepageCategoryController extends GetxController {
  late RxList<Map<String, dynamic>> items;

  ProductDioController productController = Get.put(ProductDioController());

  void setItems(RxList<Map<String, dynamic>> newItems) {
    items = newItems;
  }

  void toggleCheck(int index) {
    // handling "All" logic
    if (items[index]['name'] != "All") {
      for (var item in items) {
        if (item['name'] == "All" && item['isChecked'].value) {
          item['isChecked'].value = !(item['isChecked'] as RxBool).value;
          productController.products.clear();
        }
      }
    } else {
      if (items[index]['isChecked'].value == false) {
        for (var item in items) {
          if (item['isChecked'].value) {
            item['isChecked'].value = !(item['isChecked'] as RxBool).value;
            productController.products.clear();
          }
        }
      }
    }

    // Toggle the checkbox for the category
    bool isChecked = (items[index]['isChecked'] as RxBool).value;
    items[index]['isChecked'].value = !isChecked; // Toggle

    final Dio dio = Dio();
    Future<void> getProducts() async {
      try {
        if (items[index]['name'] != "All") {
          // if not "All" category
          final response = await dio.get(
              '${MyConstants.fetchProductByCategory}/${items[index]['category']}');

          if (items[index]['isChecked'].value == true) {
            // if checked true then add
            // Map the response data to ProductsModel
            var products = List<ProductsModel>.from(
                response.data.map((item) => ProductsModel.fromJson(item)));

            productController.products
                .addAll(products); // Add the ProductsModel list
          } else {
            // else remove
            final responseData = List<ProductsModel>.from(
                response.data.map((item) => ProductsModel.fromJson(item)));

            productController.products.removeWhere((product) {
              // print("responseProduct ${product.id}");
              return responseData
                  .any((responseProduct) => responseProduct.id == product.id);
            });
          }
        } else {
          // if "All" category
          if (items[index]['isChecked'] == false) {
            productController.products.clear();
          } else {
            productController.products.clear(); // clear first
            productController.getProducts(); // get All products
          }
        }
      } catch (e) {
        print('Category change Error = $e');
      }
    }

    getProducts();
  }
}

class MySearchController extends GetxController {
  var query = "".obs;

  void setSearch(String str) {
    query.value = str;
  }
}

class ChooseQuantityController extends GetxController {
  RxMap<int, int> qtys = RxMap<int, int>();
  var qty = 1.obs;

  CartController cartController = Get.put(CartController());
  ShippingPageController shippingPageController =
      Get.put(ShippingPageController());

  void addQty(Map<String, dynamic> item, {bool isDetailPage = false}) {
    int itemId = item['id'];
    print("duuuuuuuuuuuuu = ${qty.value}");
    if (isDetailPage && !qtys.containsKey(itemId)) {
      if (qty.value < 10) {
        qty.value++;
      }
      if (cartController.checkoutsObs.containsKey(itemId)) {
        cartController.addToCart(itemId, qty.value, item); // Add meaning update
      }
    } else if (qtys.containsKey(itemId)) {
      if (qtys[itemId]! < 10) {
        qtys[itemId] = qtys[itemId]! + 1;
      }

      // Update in Hive if required
      if (cartController.checkoutsObs.containsKey(itemId)) {
        cartController.addToCart(
            itemId, qtys[itemId]!, item); // Add meaning update
        refreshQtyObs();
        shippingPageController.calculateTotal();
      }
    } else {
      if (qty.value < 10) {
        qty.value++;
      }
    }
  }

  void removeQty(Map<String, dynamic> item, {bool isDetailPage = false}) {
    int itemId = item['id'];

    if (isDetailPage && !qtys.containsKey(itemId)) {
      if (qty.value > 1) {
        qty.value--;
      }
      if (cartController.checkoutsObs.containsKey(itemId)) {
        cartController.addToCart(
            itemId, qtys[itemId]!, item); // Add meaning update
      }
    } else if (qtys.containsKey(itemId)) {
      if (qtys[itemId]! > 1) {
        qtys[itemId] = qtys[itemId]! - 1;
      }

      // Update in Hive if required
      if (cartController.checkoutsObs.containsKey(itemId)) {
        cartController.addToCart(
            itemId, qtys[itemId]!, item); // Add meaning update
        refreshQtyObs();
        shippingPageController.calculateTotal();
      }
    } else {
      if (qty.value > 1) {
        qty.value--;
      }
    }
  }

  void refreshQtyObs() async {
    qty.value = 1; // refersh qty to 1
    var box = await Hive.openBox<UserModel>('userBox');
    var user = box.get('user_model');
    var checkouts;
    if (user != null) {
      checkouts = Map.from(user.checkouts);

      checkouts.forEach((key, value) {
        // refresh qtys to appropriate values
        qtys[value['id']] = value['quantity'];
      });
    }
  }
}

class ChooseSizeController extends GetxController {
  late RxList<Map<String, dynamic>> items;

  void setItems(RxList<Map<String, dynamic>> newItems) {
    items = newItems;
  }

  void toggleCheck(int index) {
    // Toggle the checkbox for the size
    if (items[index]['isChecked'].value == false) {
      // only toggle unchecked ones
      bool isChecked = (items[index]['isChecked'] as RxBool).value;
      items[index]['isChecked'].value = !isChecked; // Toggle
    } else {
      // don't let to uncheck an already checked radio btn
      return;
    }
    // Uncheck Others
    for (var item in items) {
      if (item['isChecked'].value == true &&
          item['text'] != '${items[index]['text']}') {
        item['isChecked'].value = !(item['isChecked'] as RxBool).value;
      }
    }
  }
}

class ChooseColorController extends GetxController {
  late RxList<Map<String, dynamic>> items;

  void setItems(RxList<Map<String, dynamic>> newItems) {
    items = newItems;
  }

  void toggleCheck(int index) {

    // don't toggle an already checked item
    if(items[index]['isChecked'].value == true){
      return;
    }
    // Toggle the checkbox for the color
    bool isChecked = (items[index]['isChecked'] as RxBool).value;
    items[index]['isChecked'].value = !isChecked; // Toggle

    // Uncheck Others
    for (var item in items) {
      if (item['isChecked'].value == true &&
          item['name'] != '${items[index]['name']}') {
        item['isChecked'].value = !(item['isChecked'] as RxBool).value;
      }
    }
  }
}

class FavoritesController extends GetxController {
  final favouritesList = <int>[].obs;
  final allFavoritesIds = <int>[].obs;

  var allFavoritesItems = <ProductsModel>[].obs;
  BackupProductDioController productDioController =
      Get.put(BackupProductDioController());

  void getAllFavoriteItems() async {
    await getAllFavoritesIDs();
    var allProducts = productDioController.products;
    var favoritedItems = allProducts.where((product) {
      return allFavoritesIds.contains(product.id);
    }).toList();

    allFavoritesItems.value = favoritedItems;
  }

  Future<void> checkFav(int id) async {
    if (await isFav(id)) {
      if (!favouritesList.contains(id)) {
        favouritesList.add(id);
      }
    } else {
      if (favouritesList.contains(id)) {
        favouritesList.remove(id);
      }
    }
  }

  void toggleFavorite(int id) async {
    var box = await Hive.openBox<UserModel>('userBox');
    var user = box.get('user_model');

    if (user != null) {
      // Call the toggleFavourite method on the retrieved user object
      user.toggleFavourite(id);
      // Save the updated user back to the box
      await box.put('user_model', user);
    }
    checkFav(id); // to re-trigger rendering
  }

  Future<bool> isFav(int id) async {
    var box = await Hive.openBox<UserModel>('userBox');
    var user = box.get('user_model');
    return user?.isFav(id) ?? false;
  }

  Future<void> getAllFavoritesIDs() async {
    var box = await Hive.openBox<UserModel>('userBox');
    var user = box.get('user_model');
    allFavoritesIds.value = user!.getAllFavorites();
  }
}

class CartController extends GetxController {
  final RxMap<int, Map<String, dynamic>> checkoutsObs =
      <int, Map<String, dynamic>>{}.obs;

  ShippingPageController shippingPageController =
      Get.put(ShippingPageController());
  void addToCart(int id, int qty, Map<String, dynamic> item) async {
    var box = await Hive.openBox<UserModel>('userBox');
    var user = box.get('user_model');
    // add qty to item
    var updatedItem = {...item, "quantity": qty};
    user?.addCheckoutItem(id, updatedItem);
    await box.put('user_model', user!); // save
    refreshToObsCart();
  }

  void removeFromCart(int id) async {
    var box = await Hive.openBox<UserModel>('userBox');
    var user = box.get('user_model');

    user?.removeCheckoutItem(id);
    await box.put('user_model', user!); // save
    refreshToObsCart();
    shippingPageController.calculateTotal();
  }

  void clearCheckoutItems() async {
    var box = await Hive.openBox<UserModel>('userBox');
    var user = box.get('user_model');

    user?.checkouts.clear();
    await box.put('user_model', user!); // save
    refreshToObsCart();
  }

  void refreshToObsCart() async {
    var box = await Hive.openBox<UserModel>('userBox');
    var user = box.get('user_model');

    if (user != null) {
      // checkoutsObs.value = user.checkouts;
      checkoutsObs.value =
          Map.from(user.checkouts); // Make a new map to trigger update
      // checkoutsObs.refresh();
    } else {
      // Handle the case where the user is null (if needed)
      checkoutsObs.value = {};
    }
  }
}

class ShippingPageController extends GetxController {
  var total = 0.0.obs;
  var subTotal = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    calculateTotal();
  }

  void calculateTotal() async {
    var box = await Hive.openBox<UserModel>('userBox');
    var user = box.get('user_model');
    var checkouts;
    if (user != null) {
      total.value = 0; // clear
      subTotal.value = 0; // clear
      checkouts = Map.from(user.checkouts);
      checkouts.forEach((key, value) {
        double price = value['price'] ?? 0.0;
        double qty = value['quantity'] ?? 1;
        double t = price * qty;
        total.value += t;
        total.value = double.parse(total.value.toStringAsFixed(2));
      });
    }
    double t1 = total.value;
    t1 = t1 + 23.0; // add shipping fee
    t1 = t1 - 40.0; // discount
    subTotal.value = double.parse(t1.toStringAsFixed(2));
  }
}

class BottomNavigationController extends GetxController {
  var index = 2.obs; // 2 because 1 is HomePage

  void setIndex(int i) {
    index.value = i;
  }
}
