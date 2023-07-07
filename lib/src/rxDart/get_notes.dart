import 'package:personal_notes/src/helper/notes_utils.dart';
import 'package:personal_notes/src/model/notes.dart';
import 'package:rxdart/rxdart.dart';

class NotesBloc {
  List<Notes> notes = [];

  final BehaviorSubject<List<Notes>> _subjectNotes =
      BehaviorSubject<List<Notes>>();

  Stream<List<Notes>> get notesObservable => _subjectNotes.stream;

  Future<void> getNotes({required String userID}) async {
    await NotesHelper.getAllNotesFuture(userID).then((value) {
      notes = value;
    });
    _subjectNotes.sink.add(notes);
  }

  Future<void> deleteNote({required Notes note}) async {
    await NotesHelper.deleteNotesFromDB(note).then((value) {
      notes.removeWhere((element) => element.id == note.id);
    });
    _subjectNotes.sink.add(notes);
  }

  void sortNotes() {
    notes
        .sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    _subjectNotes.sink.add(notes);
  }

  void searchNotes(String value) {
    if (value.isEmpty) {
      _subjectNotes.sink.add(notes);
      return;
    }

    List<Notes> result = List.from(notes.where((element) =>
        element.title.toLowerCase().contains(value.toLowerCase()) ||
        element.description.toLowerCase().contains(value.toLowerCase())));
    _subjectNotes.sink.add(result);
  }
}
