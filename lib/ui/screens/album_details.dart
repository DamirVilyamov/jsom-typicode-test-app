import 'package:flutter/material.dart';

class AlbumDetailsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/album_details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Album Details"),
      ),
      body: Center(
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text("USERS"),
          ),
        ),
      ),
    );
  }
}
