import 'package:http/http.dart' as http;

class Api {
  static final Api _api = Api._private();

  Api._private();

  factory Api() {
    return _api;
  }

  final int STATUS_SUCCESS = 200;

  String checkResponseForSuccess(http.Response response) {
    if (response.statusCode == STATUS_SUCCESS) {
      return response.body;
    } else {
      throw Exception('Failed to get ${response.request.url}');
    }
  }

  Future<String> fetchAllUsers() async {
    final response = await http.get(Uri.parse(ApiRoutes.ALL_USERS));
    return checkResponseForSuccess(response);
  }

  Future<String> fetchUserPosts(String userId) async {
    final response = await http.get(Uri.parse(ApiRoutes.USER_POSTS(userId)));
    return checkResponseForSuccess(response);
  }

  Future<String> fetchUserAlbums(String userId) async {
    final response = await http.get(Uri.parse(ApiRoutes.USER_ALBUMS(userId)));
    return checkResponseForSuccess(response);
  }

  Future<String> fetchAlbumPhotos(String albumId) async {
    final response = await http.get(Uri.parse(ApiRoutes.ALBUM_PHOTOS(albumId)));
    return checkResponseForSuccess(response);
  }
}

class ApiRoutes {
  static const String BASE_URL = "https://jsonplaceholder.typicode.com/";
  static const String ALL_USERS = BASE_URL + "users";

  static String USER_POSTS(String userId) => BASE_URL + "posts?userId=$userId";

  static String USER_ALBUMS(String userId) => BASE_URL + "albums?userId=$userId";

  static String ALBUM_PHOTOS(String albumId) => BASE_URL + "photos?albumId=$albumId";
}
