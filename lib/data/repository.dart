import 'dart:convert';

import 'package:json_typicode_test_app/data/api.dart';
import 'package:json_typicode_test_app/data/models/album.dart';
import 'package:json_typicode_test_app/data/models/photo.dart';
import 'package:json_typicode_test_app/data/models/post.dart';
import 'package:json_typicode_test_app/data/shared_preferences.dart';

import 'models/comment.dart';
import 'models/user/user.dart';

class Repository {
  final Api _api = Api();
  final prefs = SharedPrefs();
  static Repository _repository = Repository._private();

  Repository._private();

  factory Repository() {
    return _repository;
  }

  Future<List<User>> getAllUsers() async {
    List<User> users = [];
    final cachedUsers = await prefs.getUsers();
    if (cachedUsers.isNotEmpty) {
      users = cachedUsers;
    } else {
      final json = await _api.fetchAllUsers();
      final usersJson = List.from(jsonDecode(json));
      users = usersJson.map((e) => User.fromJson(e)).toList();
      prefs.saveUsers(users);
    }
    return users;
  }

  Future<List<Post>> getUserPosts(String userId) async {
    List<Post> posts = [];
    final cachedPosts = await prefs.getUserPosts(userId);

    if (cachedPosts.isNotEmpty) {
      posts = cachedPosts;
    } else {
      final json = await _api.fetchUserPosts(userId);
      final postsJsonObjects = List.from(jsonDecode(json));
      posts = postsJsonObjects.map((e) => Post.fromJson(e)).toList();
      prefs.saveUserPosts(posts, userId);
    }

    return posts;
  }

  Future<List<Album>> getUserAlbums(String userId) async {
    List<Album> albums = [];
    final cachedAlbums = await prefs.getUserAlbums(userId);
    if (cachedAlbums.isNotEmpty) {
      albums = cachedAlbums;
    } else {
      final json = await _api.fetchUserAlbums(userId);
      final albumsJsonObjects = List.from(jsonDecode(json));
      albums = albumsJsonObjects.map((e) => Album.fromJson(e)).toList();

      for (var album in albums) {
        List<Photo> photos = await _getAlbumPhotos(album.id.toString());
        album.photos = photos;
      }
      prefs.saveUserAlbums(albums, userId);
    }

    return albums;
  }

  Future<List<Photo>> _getAlbumPhotos(String albumId) async {
    final json = await _api.fetchAlbumPhotos(albumId);
    final photosJsonObjects = List.from(jsonDecode(json));
    List<Photo> photos = photosJsonObjects.map((e) => Photo.fromJson(e)).toList();
    return photos;
  }

  Future<List<Comment>> getPostComments(String postId) async {
    List<Comment> comments = [];
    final cachedComments = await prefs.getPostComments(postId);

    if (cachedComments.isNotEmpty) {
      comments = cachedComments;
    } else {
      final json = await _api.fetchPostComments(postId);
      final commentJsonObjects = List.from(jsonDecode(json));
      comments = commentJsonObjects.map((e) => Comment.fromJson(e)).toList();
      prefs.savePostComments(comments);
    }

    return comments;
  }

  Future<void> savePostComment(Comment comment) async{
    prefs.saveComment(comment);
    await _api.sendPostComment(comment);
  }
}
