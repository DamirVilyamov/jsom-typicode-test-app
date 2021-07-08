import 'package:flutter/cupertino.dart';
import 'package:json_typicode_test_app/data/models/user/address.dart';
import 'package:json_typicode_test_app/data/models/user/company.dart';

class User {
  final int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  User({
    @required this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    Address address = Address.fromJson(json['address']);
    Company company = Company.fromJson(json['company']);

    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: address,
      phone: json['phone'],
      website: json['website'],
      company: company,
    );
  }

  @override
  String toString() {
    return "id: ${this.id} username: ${this.username} ${this.address} ${this.company}";
  }
}
