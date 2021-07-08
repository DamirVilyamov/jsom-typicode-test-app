import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/bloc/posts/user_posts_state.dart';
import 'package:json_typicode_test_app/data/repository.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  UserPostsCubit() : super(UserPostsState([]));

  void getPosts(String userId) async {
    final posts = await Repository().getUserPosts(userId);
    emit(UserPostsState(posts));
  }
}
