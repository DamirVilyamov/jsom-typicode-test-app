import 'package:flutter/material.dart';

class AlbumsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/albums";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Albums"),
      ),
      body: Center(
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text("ALBUMS"),
          ),
        ),
      ),
    );
  }
}
