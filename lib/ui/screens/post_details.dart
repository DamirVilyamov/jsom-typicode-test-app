import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/bloc/comments/comments_cubit.dart';
import 'package:json_typicode_test_app/bloc/comments/comments_state.dart';
import 'package:json_typicode_test_app/data/models/comment.dart';
import 'package:json_typicode_test_app/data/models/post.dart';

class PostDetailsScreen extends StatelessWidget {
  static const ROUTE_NAME = "/post_details";

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context).settings.arguments as Post;
    final commentsBloc = context.bloc<CommentsCubit>();
    commentsBloc.getComments(post.id.toString());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.comment_rounded),
        onPressed: () {
          _showCommentForm(context, commentsBloc, post);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Post Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
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
              buildAlbumsPreview(),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }

  Widget buildAlbumsPreview() {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (ctx, commentsState) {
        List<Widget> commentItems = [];

        for (var comment in commentsState.comments) {
          var item = Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(8),
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Text("name: " + comment.name)),
                  Text("email: " + comment.email),
                  Container(margin: EdgeInsets.symmetric(vertical: 16), child: Text(comment.body)),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          );
          commentItems.add(item);
        }

        return Column(
          children: commentItems,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        );
      },
    );
  }

  void _showCommentForm(BuildContext context, CommentsCubit bloc, Post post) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final bodyController = TextEditingController();
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 4,
      context: context,
      builder: (ctx) => AnimatedPadding(
        duration: Duration(milliseconds: 500),
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, top: 16, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email', alignLabelWithHint: true),
            ),
            TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              maxLength: 140,
              decoration: InputDecoration(labelText: 'Comment', alignLabelWithHint: true),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  var name = nameController.value.text;
                  var email = emailController.value.text;
                  var body = bodyController.value.text;
                  var id = 501 + Random().nextInt(1000); //500 only available in api
                  bloc.saveComment(Comment(
                    name: name,
                    email: email,
                    body: body,
                    id: id,
                    postId: post.id,
                  ));
                  Navigator.pop(context);
                },
                child: Text('Submit')),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
