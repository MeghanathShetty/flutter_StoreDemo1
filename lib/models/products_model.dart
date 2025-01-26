import 'package:hive/hive.dart';

part 'products_model.g.dart';

@HiveType(typeId: 12)
class ProductsModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double price;

  @HiveField(3)
  String description;

  @HiveField(4)
  String category;

  @HiveField(5)
  String image;

  @HiveField(6)
  Rating rating;

  // // Since RxBool cannot be stored directly in Hive, you can store it as a regular bool
  // @HiveField(7)
  // bool isFav;

  ProductsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    // required this.isFav,
  });

  // Factory method to parse JSON into a ProductsModel object
  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
      // isFav: false, // Convert RxBool to regular bool
    );
  }

  // Method to convert a ProductsModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }
}

// Annotate the Rating class
@HiveType(typeId: 13)
class Rating {
  @HiveField(0)
  double rate;

  @HiveField(1)
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}