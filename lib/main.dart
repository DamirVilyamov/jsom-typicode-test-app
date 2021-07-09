import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/bloc/albums/albums_cubit.dart';
import 'package:json_typicode_test_app/bloc/comments/comments_cubit.dart';
import 'package:json_typicode_test_app/bloc/posts/user_posts_cubit.dart';
import 'package:json_typicode_test_app/bloc/users/users_cubit.dart';
import 'package:json_typicode_test_app/router.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  MyApp({
    Key key,
    this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UsersCubit()),
        BlocProvider(create: (context) => UserPostsCubit()),
        BlocProvider(create: (context) => UserAlbumsCubit()),
        BlocProvider(create: (context) => CommentsCubit()),
      ],
      child: MaterialApp(
        title: 'JSON typicode',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
