// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      results: (fields[0] as List).cast<Result>(),
      info: fields[1] as Info,
      favourites: fields[2] as Favourites,
      checkouts: (fields[3] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as int, (v as Map).cast<String, dynamic>())),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.results)
      ..writeByte(1)
      ..write(obj.info)
      ..writeByte(2)
      ..write(obj.favourites)
      ..writeByte(3)
      ..write(obj.checkouts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InfoAdapter extends TypeAdapter<Info> {
  @override
  final int typeId = 1;

  @override
  Info read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Info(
      seed: fields[0] as String,
      results: fields[1] as int,
      page: fields[2] as int,
      version: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Info obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.seed)
      ..writeByte(1)
      ..write(obj.results)
      ..writeByte(2)
      ..write(obj.page)
      ..writeByte(3)
      ..write(obj.version);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResultAdapter extends TypeAdapter<Result> {
  @override
  final int typeId = 2;

  @override
  Result read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Result(
      gender: fields[0] as String,
      name: fields[1] as Name,
      location: fields[2] as Location,
      email: fields[3] as String,
      login: fields[4] as Login,
      dob: fields[5] as Dob,
      registered: fields[6] as Dob,
      phone: fields[7] as String,
      cell: fields[8] as String,
      id: fields[9] as Id,
      picture: fields[10] as Picture,
      nat: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Result obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.gender)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.login)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.registered)
      ..writeByte(7)
      ..write(obj.phone)
      ..writeByte(8)
      ..write(obj.cell)
      ..writeByte(9)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.picture)
      ..writeByte(11)
      ..write(obj.nat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DobAdapter extends TypeAdapter<Dob> {
  @override
  final int typeId = 3;

  @override
  Dob read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dob(
      date: fields[0] as DateTime,
      age: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Dob obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DobAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IdAdapter extends TypeAdapter<Id> {
  @override
  final int typeId = 4;

  @override
  Id read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Id(
      name: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Id obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 5;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      street: fields[0] as Street,
      city: fields[1] as String,
      state: fields[2] as String,
      country: fields[3] as String,
      postcode: fields[4] as dynamic,
      coordinates: fields[5] as Coordinates,
      timezone: fields[6] as Timezone,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.street)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.state)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.postcode)
      ..writeByte(5)
      ..write(obj.coordinates)
      ..writeByte(6)
      ..write(obj.timezone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CoordinatesAdapter extends TypeAdapter<Coordinates> {
  @override
  final int typeId = 6;

  @override
  Coordinates read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Coordinates(
      latitude: fields[0] as String,
      longitude: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Coordinates obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordinatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StreetAdapter extends TypeAdapter<Street> {
  @override
  final int typeId = 7;

  @override
  Street read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Street(
      number: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Street obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StreetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TimezoneAdapter extends TypeAdapter<Timezone> {
  @override
  final int typeId = 8;

  @override
  Timezone read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Timezone(
      offset: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Timezone obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.offset)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimezoneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LoginAdapter extends TypeAdapter<Login> {
  @override
  final int typeId = 9;

  @override
  Login read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Login(
      uuid: fields[0] as String,
      username: fields[1] as String,
      password: fields[2] as String,
      salt: fields[3] as String,
      md5: fields[4] as String,
      sha1: fields[5] as String,
      sha256: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Login obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.salt)
      ..writeByte(4)
      ..write(obj.md5)
      ..writeByte(5)
      ..write(obj.sha1)
      ..writeByte(6)
      ..write(obj.sha256);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NameAdapter extends TypeAdapter<Name> {
  @override
  final int typeId = 10;

  @override
  Name read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Name(
      title: fields[0] as String,
      first: fields[1] as String,
      last: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Name obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.first)
      ..writeByte(2)
      ..write(obj.last);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PictureAdapter extends TypeAdapter<Picture> {
  @override
  final int typeId = 11;

  @override
  Picture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Picture(
      large: fields[0] as String,
      medium: fields[1] as String,
      thumbnail: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Picture obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.large)
      ..writeByte(1)
      ..write(obj.medium)
      ..writeByte(2)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PictureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavouritesAdapter extends TypeAdapter<Favourites> {
  @override
  final int typeId = 80;

  @override
  Favourites read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourites()..favoritesList = (fields[0] as List).cast<int>();
  }

  @override
  void write(BinaryWriter writer, Favourites obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.favoritesList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
