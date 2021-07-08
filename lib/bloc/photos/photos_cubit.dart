import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/bloc/photos/photos_state.dart';
import 'package:json_typicode_test_app/data/repository.dart';

class AlbumPhotosCubit extends Cubit<AlbumPhotosState> {
  AlbumPhotosCubit() : super(AlbumPhotosState([]));

  void getPhotos(String albumId) async {
    final photos = await Repository().getAlbumPhotos(albumId);
    emit(AlbumPhotosState(photos));
  }
}
