import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_typicode_test_app/bloc/users/users_cubit.dart';
import 'package:json_typicode_test_app/bloc/users/users_state.dart';
import 'package:json_typicode_test_app/data/models/user/user.dart';
import 'package:json_typicode_test_app/ui/screens/user_info.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('!@# users page build called');
    final bloc = context.bloc<UsersCubit>();
    bloc.getUsers();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Users"),
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          return Container(
            child: ListView.builder(
              itemBuilder: (_, index) {
                return buildUserItem(state.users[index], context);
              },
              itemCount: state.users.length,
            ),
          );
        },
      ),
    );
  }

  Widget buildUserItem(User user, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, UserInfoScreen.ROUTE_NAME, arguments: user);
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  child: Text(user.username),
                  margin: EdgeInsets.only(bottom: 8),
                ),
                Text(user.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
