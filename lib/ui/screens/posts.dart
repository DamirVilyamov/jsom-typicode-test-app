import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/bloc/posts/user_posts_cubit.dart';
import 'package:json_typicode_test_app/data/models/post.dart';
import 'package:json_typicode_test_app/ui/screens/post_details.dart';

class PostsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/posts";

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<UserPostsCubit>();
    List<Post> posts = bloc.state.posts;

    return Scaffold(
      backgroundColor: Color(0xCCFFFFFF),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Posts"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (ctx, index) {
          Post post = posts[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              elevation: 4,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PostDetailsScreen.ROUTE_NAME, arguments: post);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        post.title,
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(margin: EdgeInsets.only(top: 8), child: Text(post.body)),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
