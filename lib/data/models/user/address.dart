import 'geo.dart';

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    Geo geo = Geo.fromJson(json['geo']);

    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: geo,
    );
  }

  @override
  String toString() {
    return "${this.street} ${this.geo}";
  }
}
