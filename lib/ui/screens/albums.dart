import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/bloc/albums/albums_cubit.dart';
import 'package:json_typicode_test_app/ui/screens/album_details.dart';

class AlbumsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/albums";

  @override
  Widget build(BuildContext context) {
    final albumsBloc = context.bloc<UserAlbumsCubit>();
    final albums = albumsBloc.state.albums;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Albums"),
      ),
      body: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (_, index) {
          final album = albums[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AlbumDetailsScreen.ROUTE_NAME, arguments: album);
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Container(
                margin: EdgeInsets.all(8),
                height: 120,
                child: Row(
                  children: [
                    Expanded(
                        flex: 30,
                        child: Image.network(
                          album.photos.first.thumbnailUrl,
                          fit: BoxFit.fill,
                        )),
                    Expanded(
                      flex: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(album.title),
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
