import 'dart:convert';

import 'package:json_typicode_test_app/data/api.dart';
import 'package:json_typicode_test_app/data/models/album.dart';
import 'package:json_typicode_test_app/data/models/photo.dart';
import 'package:json_typicode_test_app/data/models/post.dart';

import 'models/user/user.dart';

class Repository {
  final Api _api = Api();
  static Repository _repository = Repository._private();

  Repository._private();

  factory Repository() {
    return _repository;
  }

  Future<List<User>> getAllUsers() async {
    final json = await _api.fetchAllUsers();
    final usersJson = List.from(jsonDecode(json));
    List<User> users = usersJson.map((e) => User.fromJson(e)).toList();

    print("!@# REPO CALLEd for users");
    print(users);
    return users;
  }

  Future<List<Post>> getUserPosts(String userId) async {
    final json = await _api.fetchUserPosts(userId);
    final postsJsonObjects = List.from(jsonDecode(json));
    List<Post> posts = postsJsonObjects.map((e) => Post.fromJson(e)).toList();
    print(posts);
    print("!@# REPO CALLEd for user posts");
    return posts;
  }

  Future<List<Album>> getUserAlbums(String userId) async {
    final json = await _api.fetchUserAlbums(userId);
    final albumsJsonObjects = List.from(jsonDecode(json));
    List<Album> albums = albumsJsonObjects.map((e) => Album.fromJson(e)).toList();
    print(albums);
    print("!@# REPO CALLEd for albums");
    return albums;
  }

  Future<List<Photo>> getAlbumPhotos(String albumId) async {
    final json = await _api.fetchAlbumPhotos(albumId);
    final photosJsonObjects = List.from(jsonDecode(json));
    List<Photo> photos = photosJsonObjects.map((e) => Photo.fromJson(e)).toList();
    print(photos);
    print("!@# REPO CALLEd for album photos");
    return photos;
  }
}
