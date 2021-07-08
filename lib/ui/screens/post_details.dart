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
        body: Column(
          children: [
            Text(post.title),
            Text(post.body),
          ],
        ));
  }
}
