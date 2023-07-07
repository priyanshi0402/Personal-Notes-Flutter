import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_notes/src/helper/notes_utils.dart';

import '../../../model/users.dart';

part 'users_event.dart';
part 'users_state.dart';
part 'users_bloc.freezed.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(const _Initial()) {
    on<UsersEvent>((event, emit) async {
      emit(const _Loading());
      await NotesHelper.getAllUsers().then((value) {
        // print('-- $value');
        emit(_Success(value));
      });
    });
  }
}
