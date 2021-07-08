import 'package:flutter/material.dart';
import 'package:json_typicode_test_app/ui/screens/album_details.dart';
import 'package:json_typicode_test_app/ui/screens/albums.dart';
import 'package:json_typicode_test_app/ui/screens/post_details.dart';
import 'package:json_typicode_test_app/ui/screens/posts.dart';
import 'package:json_typicode_test_app/ui/screens/user_info.dart';
import 'package:json_typicode_test_app/ui/screens/users.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => UsersScreen());
        break;

      case UserInfoScreen.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => UserInfoScreen(), settings: routeSettings);
        break;

      case PostsScreen.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => PostsScreen(), settings: routeSettings);
        break;

      case AlbumsScreen.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => AlbumsScreen(), settings: routeSettings);
        break;

      case PostDetailsScreen.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => PostDetailsScreen(), settings: routeSettings);
        break;

      case AlbumDetailsScreen.ROUTE_NAME:
        return MaterialPageRoute(builder: (_) => AlbumDetailsScreen(), settings: routeSettings);
        break;

      default:
        return null;
    }
  }
}
