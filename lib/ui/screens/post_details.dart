import 'package:flutter/material.dart';
import 'package:json_typicode_test_app/data/models/post.dart';

class PostDetailsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/post_details";

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context).settings.arguments as Post;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Post Details"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Text(
                post.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post.body,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
