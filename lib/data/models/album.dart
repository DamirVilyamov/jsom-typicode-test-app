import 'package:json_typicode_test_app/data/models/photo.dart';

class Album {
  int userId;
  int id;
  String title;
  List<Photo> photos = [];

  Album({
    this.userId,
    this.id,
    this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
  };

  @override
  String toString() {
    return "Album ${this.id} ${this.title} ${this.userId}";
  }
}
