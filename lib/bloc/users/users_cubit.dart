import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/bloc/users/users_state.dart';
import 'package:json_typicode_test_app/data/repository.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersState([]));

  void getUsers() async {
    final users = await Repository().getAllUsers();
    emit(UsersState(users));
  }
}
