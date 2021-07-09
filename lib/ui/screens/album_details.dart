import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:json_typicode_test_app/data/models/album.dart';
import 'package:json_typicode_test_app/data/models/photo.dart';

class AlbumDetailsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/album_details";
  final textTitleKey = GlobalKey<_DynamicTextTitleState>();

  @override
  Widget build(BuildContext context) {
    final album = ModalRoute.of(context).settings.arguments as Album;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Album Details"),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: 400,
                initialPage: 0,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setTitle(index, album.photos);
                }),
            items: album.photos.map((photo) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.network(photo.url);
                },
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: DynamicTextTitle(
              textTitleKey,
              defaultTitle: album.photos[0].title,
            ),
          )
        ],
      ),
    );
  }

  void setTitle(int index, List<Photo> photos) {
    textTitleKey.currentState.setTitle(photos[index].title);
  }
}

class DynamicTextTitle extends StatefulWidget {
  String defaultTitle;

  DynamicTextTitle(key, {this.defaultTitle}) : super(key: key);

  @override
  State<DynamicTextTitle> createState() => _DynamicTextTitleState(title: defaultTitle);
}

class _DynamicTextTitleState extends State<DynamicTextTitle> {
  String title = '';

  _DynamicTextTitleState({this.title});

  setTitle(String inTitle) {
    setState(() {
      title = inTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 24),
    );
  }
}
