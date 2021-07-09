import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/data/models/comment.dart';
import 'package:json_typicode_test_app/data/repository.dart';

import 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsState([]));

  void getComments(String postId) async {
    final comments = await Repository().getPostComments(postId);
    emit(CommentsState(comments));
  }

  void saveComment(Comment comment) async {
    await Repository().savePostComment(comment);
    getComments(state.comments[0].postId.toString());
  }
}
