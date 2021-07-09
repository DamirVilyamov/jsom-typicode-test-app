import 'dart:convert';

import 'package:json_typicode_test_app/data/models/album.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/comment.dart';
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

  String _getCommentKey(String postId, String commentId) {
    return "post/$postId/comments/$commentId";
  }

  void saveUsers(List<User> users) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var user in users) {
      final value = jsonEncode(user.toJson());
      prefs.setString(_getUserKey(user), value);
    }
  }

  Future<List<User>> getUsers() async {
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

    return users;
  }

  void saveUserPosts(List<Post> posts, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var post in posts) {
      final value = jsonEncode(post.toJson());
      prefs.setString(_getPostKey(post, userId), value);
    }
  }

  Future<List<Post>> getUserPosts(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> postKeys = [];
    List<Post> posts = [];
    prefs.getKeys().forEach((element) {
      if (element.startsWith('user/$userId/posts/')) {
        postKeys.add(element);
      }
    });

    for (var key in postKeys) {
      final rawJson = prefs.getString(key);

      final json = jsonDecode(rawJson);

      final post = Post.fromJson(json);

      posts.add(post);
    }
    return posts;
  }

  void saveUserAlbums(List<Album> albums, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var album in albums) {
      final value = jsonEncode(album.toJson());
      prefs.setString(_getAlbumKey(album, userId), value);
      saveAlbumPhotos(album.photos, album.id.toString());
    }
  }

  Future<List<Album>> getUserAlbums(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> albumKeys = [];
    List<Album> albums = [];
    prefs.getKeys().forEach((element) {
      if (element.startsWith('user/$userId/album/')) {
        albumKeys.add(element);
      }
    });

    for (var key in albumKeys) {
      final rawJson = prefs.getString(key);

      final json = jsonDecode(rawJson);

      final album = Album.fromJson(json);

      album.photos = await getAlbumPhotos(album.id.toString());
      albums.add(album);
    }

    return albums;
  }

  void saveAlbumPhotos(List<Photo> photos, String albumId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var photo in photos) {
      final value = jsonEncode(photo.toJson());
      prefs.setString(_getPhotoKey(photo, albumId), value);
    }
  }

  Future<List<Photo>> getAlbumPhotos(String albumId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> photoKeys = [];
    List<Photo> photos = [];
    prefs.getKeys().forEach((element) {
      if (element.startsWith('album/$albumId/photo/')) {
        photoKeys.add(element);
      }
    });

    for (var key in photoKeys) {
      final rawJson = prefs.getString(key);

      final json = jsonDecode(rawJson);

      final photo = Photo.fromJson(json);

      photos.add(photo);
    }

    return photos;
  }

  void savePostComments(List<Comment> comments) async {
    for (var comment in comments) {
      saveComment(comment);
    }
  }

  void saveComment(Comment comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final value = jsonEncode(comment.toJson());
    prefs.setString(_getCommentKey(comment.postId.toString(), comment.id.toString()), value);
  }

  Future<List<Comment>> getPostComments(String postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> commentKeys = [];
    List<Comment> comments = [];
    prefs.getKeys().forEach((element) {
      if (element.startsWith('post/$postId/comments/')) {
        commentKeys.add(element);
      }
    });

    for (var key in commentKeys) {
      final rawJson = prefs.getString(key);

      final json = jsonDecode(rawJson);

      final comment = Comment.fromJson(json);

      comments.add(comment);
    }

    return comments;
  }
}
