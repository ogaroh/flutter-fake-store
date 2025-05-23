import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class GeolocationModel {
  final String lat;
  final String long;

  const GeolocationModel({required this.lat, required this.long});

  factory GeolocationModel.fromJson(Map<String, dynamic> json) =>
      _$GeolocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeolocationModelToJson(this);

  Geolocation toEntity() => Geolocation(lat: lat, long: long);
}

@JsonSerializable()
class AddressModel {
  final GeolocationModel geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  const AddressModel({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  Address toEntity() => Address(
    geolocation: geolocation.toEntity(),
    city: city,
    street: street,
    number: number,
    zipcode: zipcode,
  );
}

@JsonSerializable()
class NameModel {
  final String firstname;
  final String lastname;

  const NameModel({required this.firstname, required this.lastname});

  factory NameModel.fromJson(Map<String, dynamic> json) =>
      _$NameModelFromJson(json);

  Map<String, dynamic> toJson() => _$NameModelToJson(this);

  Name toEntity() => Name(firstname: firstname, lastname: lastname);
}

@JsonSerializable()
class UserModel {
  final int id;
  final String email;
  final String username;
  final String password;
  final NameModel name;
  final AddressModel address;
  final String phone;
  @JsonKey(name: '__v')
  final int v;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toEntity() => User(
    id: id,
    email: email,
    username: username,
    password: password,
    name: name.toEntity(),
    address: address.toEntity(),
    phone: phone,
    v: v,
  );
}
