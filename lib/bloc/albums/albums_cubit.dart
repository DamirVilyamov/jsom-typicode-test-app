import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/data/repository.dart';

import 'albums_state.dart';

class UserAlbumsCubit extends Cubit<UserAlbumsState> {
  UserAlbumsCubit() : super(UserAlbumsState([]));

  void getAlbums(String userId) async {
    final albums = await Repository().getUserAlbums(userId);
    emit(UserAlbumsState(albums));
  }
}
