import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:store_demo1/models/products_model.dart';
import 'package:store_demo1/models/user_model.dart';
import 'package:store_demo1/utils/my_constants.dart';

import 'my_hive_functions.dart';

class UserDioController extends GetxController {
  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  // var user = {}.obs;
  var user = Rxn<UserModel>();
  Future<void> getUser() async{
    try{
      var storedUser = await getUserHive(); // Retrieve from Hive
      if (storedUser != null) {
        user.value = storedUser;
        print('User data retrieved from Hive: ${user.value}');
      } else { // Retrieve from API and then store to hive
        final response = await dio.get(MyConstants.fetchUserUrl);
        user.value = UserModel.fromJson(response.data);
        // Save the userModel to Hive
        if (user.value != null) {
          saveUserHive(user.value!);
        }
      }
    }catch(e){
      // user.value = {'error':'${MyConstants.errorMsg} : $e'};
      print('getUser Error = $e');
    }
  }
}

class ProductDioController extends GetxController {
  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  // var products = <Map<String, dynamic>>[].obs;
  var products = <ProductsModel>[].obs;
  Future<void> getProducts() async {
    try {

      var storedProducts = await getAllProductsHive();

      if (storedProducts.isEmpty) {
          final response = await dio.get(MyConstants.fetchProductUrl);
          final List data = response.data;

          // Map the API response to ProductsModel
          products.value = data.map((item) => ProductsModel.fromJson(item)).toList();

          // Save the fetched products to Hive
          await saveProductsHive(products.value!);
      } else {
        // If products exist in Hive, load from Hive
        products.value = storedProducts;

        print('Products data retrieved from Hive: ${products.value}');
      }
    } catch (e) {
      print('getProducts Error = $e');
    }
  }
}

class BackupProductDioController extends GetxController {
  final Dio dio = Dio();

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  var products = <ProductsModel>[].obs;
  Future<void> getProducts() async {
    try {
        final response = await dio.get(MyConstants.fetchProductUrl);
        final List data = response.data;

        products.value = data.map((item) => ProductsModel.fromJson(item)).toList();
    } catch (e) {
      print('Backup getProducts Error = $e');
    }
  }
}