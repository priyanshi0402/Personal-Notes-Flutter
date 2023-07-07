part of 'notes_bloc.dart';

@freezed
class NotesEvent with _$NotesEvent {
  const factory NotesEvent.getPost(String userID) = _GetPost;
  const factory NotesEvent.deletePost(Notes note) = _DeletePost;
  const factory NotesEvent.searchPost(String value) = _SearchPost;
  const factory NotesEvent.sortPost() = _SortPost;
}
