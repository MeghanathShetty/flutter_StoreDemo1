import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  List<Result> results;

  @HiveField(1)
  Info info;

  @HiveField(2)
  Favourites favourites; // Favourites object

  @HiveField(3)
  Map<int,Map<String, dynamic>> checkouts; // Map of maps for checkout data

  UserModel({
    required this.results,
    required this.info,
    required this.favourites,
    required this.checkouts,
  });

  // Factory method to parse JSON into UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    info: Info.fromJson(json["info"]),
    favourites: Favourites.fromJson(json["favourites"] ?? {}),
      checkouts: {}
  );

  // Toggle favorite functionality
  void toggleFavourite(int id) {
    favourites.toggleFavorite(id); // Delegate toggle action to Favourites
  }

  // Check if an item is a favorite
  bool isFav(int id) {
    return favourites.isFav(id);
  }

  // Get all favorite IDs
  List<int> getAllFavorites() {
    return favourites.favoritesList;
  }

  void addCheckoutItem(int id, Map<String, dynamic> item){
    checkouts[id] = item;
  }

  void removeCheckoutItem(int id) {
    if (checkouts.containsKey(id)) {
      checkouts.remove(id);
    }
  }

}

// Annotate the Info class
@HiveType(typeId: 1)
class Info {
  @HiveField(0)
  String seed;

  @HiveField(1)
  int results;

  @HiveField(2)
  int page;

  @HiveField(3)
  String version;

  Info({
    required this.seed,
    required this.results,
    required this.page,
    required this.version,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    seed: json["seed"],
    results: json["results"],
    page: json["page"],
    version: json["version"],
  );
}

// Annotate the Result class
@HiveType(typeId: 2)
class Result {
  @HiveField(0)
  String gender;

  @HiveField(1)
  Name name;

  @HiveField(2)
  Location location;

  @HiveField(3)
  String email;

  @HiveField(4)
  Login login;

  @HiveField(5)
  Dob dob;

  @HiveField(6)
  Dob registered;

  @HiveField(7)
  String phone;

  @HiveField(8)
  String cell;

  @HiveField(9)
  Id id;

  @HiveField(10)
  Picture picture;

  @HiveField(11)
  String nat;

  Result({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    gender: json["gender"],
    name: Name.fromJson(json["name"]),
    location: Location.fromJson(json["location"]),
    email: json["email"],
    login: Login.fromJson(json["login"]),
    dob: Dob.fromJson(json["dob"]),
    registered: Dob.fromJson(json["registered"]),
    phone: json["phone"],
    cell: json["cell"],
    id: Id.fromJson(json["id"]),
    picture: Picture.fromJson(json["picture"]),
    nat: json["nat"],
  );
}

// Annotate the Dob class
@HiveType(typeId: 3)
class Dob {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int age;

  Dob({
    required this.date,
    required this.age,
  });

  factory Dob.fromJson(Map<String, dynamic> json) => Dob(
    date: DateTime.parse(json["date"]),
    age: json["age"],
  );
}

// Annotate the Id class
@HiveType(typeId: 4)
class Id {
  @HiveField(0)
  String name;

  @HiveField(1)
  String value;

  Id({
    required this.name,
    required this.value,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    name: json["name"] ?? "",
    value: json["value"] ?? "",
  );
}

// Annotate the Location class
@HiveType(typeId: 5)
class Location {
  @HiveField(0)
  Street street;

  @HiveField(1)
  String city;

  @HiveField(2)
  String state;

  @HiveField(3)
  String country;

  @HiveField(4)
  dynamic postcode;

  @HiveField(5)
  Coordinates coordinates;

  @HiveField(6)
  Timezone timezone;

  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    street: Street.fromJson(json["street"]),
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postcode: json["postcode"],
    coordinates: Coordinates.fromJson(json["coordinates"]),
    timezone: Timezone.fromJson(json["timezone"]),
  );
}

// Annotate the Coordinates class
@HiveType(typeId: 6)
class Coordinates {
  @HiveField(0)
  String latitude;

  @HiveField(1)
  String longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );
}

// Annotate the Street class
@HiveType(typeId: 7)
class Street {
  @HiveField(0)
  int number;

  @HiveField(1)
  String name;

  Street({
    required this.number,
    required this.name,
  });

  factory Street.fromJson(Map<String, dynamic> json) => Street(
    number: json["number"],
    name: json["name"],
  );
}

// Annotate the Timezone class
@HiveType(typeId: 8)
class Timezone {
  @HiveField(0)
  String offset;

  @HiveField(1)
  String description;

  Timezone({
    required this.offset,
    required this.description,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
    offset: json["offset"],
    description: json["description"],
  );
}

// Annotate the Login class
@HiveType(typeId: 9)
class Login {
  @HiveField(0)
  String uuid;

  @HiveField(1)
  String username;

  @HiveField(2)
  String password;

  @HiveField(3)
  String salt;

  @HiveField(4)
  String md5;

  @HiveField(5)
  String sha1;

  @HiveField(6)
  String sha256;

  Login({
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    uuid: json["uuid"],
    username: json["username"],
    password: json["password"],
    salt: json["salt"],
    md5: json["md5"],
    sha1: json["sha1"],
    sha256: json["sha256"],
  );
}

// Annotate the Name class
@HiveType(typeId: 10)
class Name {
  @HiveField(0)
  String title;

  @HiveField(1)
  String first;

  @HiveField(2)
  String last;

  Name({
    required this.title,
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    title: json["title"],
    first: json["first"],
    last: json["last"],
  );
}

// Annotate the Picture class
@HiveType(typeId: 11)
class Picture {
  @HiveField(0)
  String large;

  @HiveField(1)
  String medium;

  @HiveField(2)
  String thumbnail;

  Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    large: json["large"],
    medium: json["medium"],
    thumbnail: json["thumbnail"],
  );
}

@HiveType(typeId: 80)
class Favourites {
  @HiveField(0)
  List<int> favoritesList;

  Favourites({
    List<int>? favorites,
  }) : favoritesList = favorites ?? []; // Initialize with an empty list if null

  // Factory method to create an instance from JSON
  factory Favourites.fromJson(Map<String, dynamic> json) {
    return Favourites(
      favorites: json['favorites'] != null
          ? List<int>.from(json['favorites'])
          : [], // Handles null cases by defaulting to an empty list
    );
  }
  // Method to convert the class to JSON
  Map<String, dynamic> toJson() {
    return {
      'favorites': favoritesList,
    };
  }

  void toggleFavorite(int favorite) {
    if (!favoritesList.contains(favorite)) {
      favoritesList.add(favorite); // Add only if it doesn't already exist
    } else {
      favoritesList.remove(favorite); // Removes the favorite if it exists
    }
  }

  bool isFav(int id){
    if(favoritesList.contains(id)) {
      return true;
    } else {
      return false;
    }
  }
}
