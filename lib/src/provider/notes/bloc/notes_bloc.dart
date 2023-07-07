import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:personal_notes/src/helper/notes_utils.dart';

import '../../../model/notes.dart';

part 'notes_event.dart';
part 'notes_state.dart';
part 'notes_bloc.freezed.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  List<Notes> notes = [];
  NotesBloc() : super(const _Initial()) {
    on<NotesEvent>((event, emit) async {
      emit(const _Initial());
      if (event is _GetPost) {
        emit(const _Loading());
        await NotesHelper.getAllNotesFuture(event.userID).then((value) {
          notes = value;
          emit(_Success(notes));
        });
      } else if (event is _DeletePost) {
        // emit(const _Initial());
        await NotesHelper.deleteNotesFromDB(event.note).then((value) {
          notes.removeWhere((element) => element.id == event.note.id);
          emit(_Success(notes));
          // add(const _SortPost());
          // notesBloc.add(const NotesEvent.sortPost());
        });
      } else if (event is _SortPost) {
        // emit(const _Initial());
        notes.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        emit(_Success(notes));
      } else if (event is _SearchPost) {
        // emit(const _Initial());
        List<Notes> result = List.from(notes.where((element) =>
            element.title.toLowerCase().contains(event.value.toLowerCase()) ||
            element.description
                .toLowerCase()
                .contains(event.value.toLowerCase())));
        emit(_Success(result));
      }
    });
  }
}

// final NotesBloc notesBloc = NotesBloc();
