import 'dart:convert';

import 'package:json_typicode_test_app/data/models/album.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/photo.dart';
import 'models/post.dart';
import 'models/user/user.dart';

class SharedPrefs {
  String _getUserKey(User user) {
    return "user/${user.id}";
  }

  String _getAlbumKey(Album album, String userId) {
    return "user/$userId/album/${album.id}";
  }

  String _getPhotoKey(Photo photo, String albumId) {
    return "album/$albumId/photo/${photo.id}";
  }

  String _getPostKey(Post post, String userId) {
    return "user/$userId/posts/${post.id}";
  }

  void saveUsers(List<User> users) async {
    print('!@# save users to cache');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var user in users) {
      final value = jsonEncode(user.toJson());
      prefs.setString(_getUserKey(user), value);
    }
  }

  Future<List<User>> getUsers() async {
    print('!@# get users from cache');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> userKeys = [];
    List<User> users = [];
    prefs.getKeys().forEach((element) {
      if (element.startsWith('user/')) {
        userKeys.add(element);
      }
    });

    for (var key in userKeys) {
      final rawJson = prefs.getString(key);

      final json = jsonDecode(rawJson);

      final user = User.fromJson(json);

      users.add(user);
    }
    print('!@# users ' + users.toString());
    return users;
  }

  void saveUserPosts(List<Post> posts, String userId) async {
    print('!@# save posts to cache');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var post in posts) {
      final value = jsonEncode(post.toJson());
      prefs.setString(_getPostKey(post, userId), value);
    }
  }

  Future<List<Post>> getUserPosts(String userId) async {
    print('!@# get posts from cache');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> postKeys = [];
    List<Post> posts = [];
    prefs.getKeys().forEach((element) {
      if (element.startsWith('user/$userId/posts/')) {
        postKeys.add(element);
      }
    });

    print("!@# post keys " + postKeys.toString());
    for (var key in postKeys) {
      final rawJson = prefs.getString(key);
      print('!@# rawJson ' + rawJson);

      final json = jsonDecode(rawJson);
      print('!@# json ' + json.toString());

      final post = Post.fromJson(json);
      print('!@# post ' + post.toString());

      posts.add(post);
      print('!@# post ' + posts.toString());
    }
    return posts;
  }

  void saveUserAlbums(List<Album> albums, String userId) async {
    print('!@# save albums to cache');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var album in albums) {
      final value = jsonEncode(album.toJson());
      prefs.setString(_getAlbumKey(album, userId), value);
      saveAlbumPhotos(album.photos, album.id.toString());
    }
  }

  Future<List<Album>> getUserAlbums(String userId) async {
    print('!@# get albums from cache');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> albumKeys = [];
    List<Album> albums = [];
    prefs.getKeys().forEach((element) {
      if (element.startsWith('user/$userId/album/')) {
        albumKeys.add(element);
      }
    });

    print("!@# album keys " + albumKeys.toString());
    for (var key in albumKeys) {
      final rawJson = prefs.getString(key);
      print('!@# rawJson ' + rawJson);

      final json = jsonDecode(rawJson);
      print('!@# json ' + json.toString());

      final album = Album.fromJson(json);
      print('!@# album ' + album.toString());

      album.photos = await getAlbumPhotos(album.id.toString());
      albums.add(album);
    }
    print('!@# albums ' + albums.toString());
    return albums;
  }

  void saveAlbumPhotos(List<Photo> photos, String albumId) async {
    print('!@# save photos to cache');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var photo in photos) {
      final value = jsonEncode(photo.toJson());
      prefs.setString(_getPhotoKey(photo, albumId), value);
    }
  }

  Future<List<Photo>> getAlbumPhotos(String albumId) async {
    print('!@# get photos from cache');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> photoKeys = [];
    List<Photo> photos = [];
    prefs.getKeys().forEach((element) {
      if (element.startsWith('album/$albumId/photo/')) {
        photoKeys.add(element);
      }
    });

    print("!@# photo keys " + photoKeys.toString());
    for (var key in photoKeys) {
      final rawJson = prefs.getString(key);
      print('!@# rawJson ' + rawJson);

      final json = jsonDecode(rawJson);
      print('!@# json ' + json.toString());

      final photo = Photo.fromJson(json);
      print('!@# photo ' + photo.toString());

      photos.add(photo);
    }
    print('!@# photos ' + photos.toString());
    return photos;
  }
}
