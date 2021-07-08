import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/bloc/albums/albums_cubit.dart';
import 'package:json_typicode_test_app/bloc/albums/albums_state.dart';
import 'package:json_typicode_test_app/bloc/photos/photos_cubit.dart';
import 'package:json_typicode_test_app/bloc/photos/photos_state.dart';
import 'package:json_typicode_test_app/bloc/posts/user_posts_cubit.dart';
import 'package:json_typicode_test_app/bloc/posts/user_posts_state.dart';
import 'package:json_typicode_test_app/data/models/user/user.dart';
import 'package:json_typicode_test_app/ui/screens/albums.dart';
import 'package:json_typicode_test_app/ui/screens/posts.dart';

class UserInfoScreen extends StatelessWidget {
  static const ROUTE_NAME = "/user_info";

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context).settings.arguments as User;
    final postsBloc = context.bloc<UserPostsCubit>();
    postsBloc.getPosts(user.id.toString());
    final albumsBloc = context.bloc<UserAlbumsCubit>();
    albumsBloc.getAlbums(user.id.toString());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${user.username}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "General info:",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                title: Text(user.name),
                subtitle: Text("name"),
              ),
              ListTile(
                title: Text(user.email),
                subtitle: Text("email"),
              ),
              ListTile(
                title: Text(user.phone),
                subtitle: Text("phone"),
              ),
              ListTile(
                title: Text(user.website),
                subtitle: Text("website"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Company info:",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                title: Text(user.company.name),
                subtitle: Text("company name"),
              ),
              ListTile(
                title: Text(user.company.bs),
                subtitle: Text("bs"),
              ),
              ListTile(
                title: Text(
                  user.company.catchPhrase,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                subtitle: Text("catch phrase"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Address:",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ListTile(
                title: Text(user.address.street),
                subtitle: Text("street"),
              ),
              ListTile(
                title: Text(user.address.suite),
                subtitle: Text("suite"),
              ),
              ListTile(
                title: Text(user.address.city),
                subtitle: Text("city"),
              ),
              ListTile(
                title: Text(user.address.zipcode),
                subtitle: Text("zipcode"),
              ),
              ListTile(
                title: Text("lat: ${user.address.geo.lat}, lng: ${user.address.geo.lng}"),
                subtitle: Text("geo data"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Posts:",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              buildPostsPreview(context),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }

  Widget buildPostsPreview(BuildContext context) {
    return BlocBuilder<UserPostsCubit, UserPostsState>(
      builder: (ctx, state) {
        List<Widget> postItems = [];
        state.posts.take(3).toList().forEach((element) {
          postItems.add(
            ListTile(
              title: Text(element.title),
              subtitle: Text('post title'),
            ),
          );
        });
        if (state.posts.isNotEmpty) {
          postItems.add(Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PostsScreen.ROUTE_NAME);
              },
              child: Text(
                'See all',
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
            ),
          ));
        }
        return Column(
          children: postItems,
          crossAxisAlignment: CrossAxisAlignment.center,
        );
      },
    );
  }

  Widget buildAlbumsPreview(BuildContext context) {
    return BlocBuilder<UserAlbumsCubit, UserAlbumsState>(
      builder: (ctx, state) {
        return BlocBuilder<AlbumPhotosCubit, AlbumPhotosState>(builder: (_, photosState) {
          List<Widget> albumItems = [];
          state.albums.take(3).toList().forEach((element) {
            albumItems.add(Card(
              child: Container(
                height: 120,
                child: Row(
                  children: [
                   /* Expanded(flex: 30, child: Image.network(src)),*/
                    Expanded(
                      child: Column(
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
            ));
          });
          if (state.albums.isNotEmpty) {
            albumItems.add(Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AlbumsScreen.ROUTE_NAME);
                },
                child: Text(
                  'See all',
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                ),
              ),
            ));
          }
          return Column(
            children: albumItems,
            crossAxisAlignment: CrossAxisAlignment.center,
          );
        });
      },
    );
  }
}
