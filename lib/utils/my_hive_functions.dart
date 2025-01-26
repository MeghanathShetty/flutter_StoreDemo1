import 'package:hive/hive.dart';
import '../models/products_model.dart';
import '../models/user_model.dart';

// User Model .................................................
// Register User Adapter Model
void registerUserAdapters() async{
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(InfoAdapter());
  Hive.registerAdapter(ResultAdapter());
  Hive.registerAdapter(DobAdapter());
  Hive.registerAdapter(IdAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(CoordinatesAdapter());
  Hive.registerAdapter(StreetAdapter());
  Hive.registerAdapter(TimezoneAdapter());
  Hive.registerAdapter(LoginAdapter());
  Hive.registerAdapter(NameAdapter());
  Hive.registerAdapter(PictureAdapter());
  Hive.registerAdapter(FavouritesAdapter());
}

// Function to save UserModel to Hive
void saveUserHive(UserModel userModel) async {
  var box = await Hive.openBox<UserModel>('userBox');
  await box.put('user_model', userModel);
  print('User data saved to Hive.');
}

// Function to retrieve user model from hive
Future<UserModel?> getUserHive() async {
  var box = await Hive.openBox<UserModel>('userBox');
  return box.get('user_model');
}

// Products Model .................................................
// Register Products Adapter Model
void registerProductsAdapters() async{
  Hive.registerAdapter(ProductsModelAdapter());
  Hive.registerAdapter(RatingAdapter());
}

// Function to save ProductsModel to Hive
Future<void> saveProductsHive(List<ProductsModel> productsList) async {
  var box = await Hive.openBox<ProductsModel>('productsBox');
  for (var product in productsList) {
    await box.put('product_${product.id}', product); // Save each product with a unique key
  }
  print('User data saved to Hive.');
}

// Function to retrieve all products from hive
Future<List<ProductsModel>> getAllProductsHive() async {
  var box = await Hive.openBox<ProductsModel>('productsBox');
  List<ProductsModel> allProducts = box.values.toList();
  return allProducts;
}

// Function to retrieve single product by ID from Hive
Future<ProductsModel?> getProductById(int id) async {
  var box = await Hive.openBox<ProductsModel>('productsBox');
  return box.get('product_$id');
}