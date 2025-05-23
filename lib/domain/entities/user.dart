class Geolocation {
  final String lat;
  final String long;

  const Geolocation({required this.lat, required this.long});
}

class Address {
  final Geolocation geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  const Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });
}

class Name {
  final String firstname;
  final String lastname;

  const Name({required this.firstname, required this.lastname});
}

class User {
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final Address address;
  final String phone;
  final int v;

  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
    required this.v,
  });
}
