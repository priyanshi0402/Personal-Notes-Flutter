import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_notes/src/model/users.dart';
import 'package:personal_notes/src/notes/my_notes.dart';
import 'package:personal_notes/src/provider/users/bloc/users_bloc.dart';

class UsersListWidget extends StatefulWidget {
  const UsersListWidget({super.key});

  @override
  State<UsersListWidget> createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  List<Users> allUsers = [];
  // bool _loading = true;
  final UsersBloc _usersBloc = UsersBloc();

  @override
  void initState() {
    super.initState();
    _usersBloc.add(const UsersEvent.getUsers());
    // NotesHelper.getAllUsers().then((value) {
    //   print(value);
    //   setState(() {
    //     _loading = false;
    //     allUsers = value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return _usersBloc;
      },
      child: _listView(),
    );
    // return _loading ? const CircularProgressIndicator.adaptive() : _listView();
  }

  Widget _listView() {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            return const SizedBox.shrink();
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          success: (users) {
            return ListView.separated(
              // padding: const EdgeInsets.all(10),
              itemCount: users.length,
              itemBuilder: (context, index) {
                return _cellItem(user: users[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  indent: 20,
                  thickness: 1,
                  height: 1,
                );
              },
            );
          },
          error: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _cellItem({required Users user}) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DisplayNotes(userId: user.id);
          },
        ));
      },
      leading: ClipOval(
        child: SizedBox.fromSize(
          size: const Size(50, 50),
          child: user.profileImage.isEmpty
              ? Container(
                  color: Colors.deepPurple[400],
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                )
              : Image.network(
                  user.profileImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator.adaptive(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
    );
  }
}
