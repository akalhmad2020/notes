part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}
class GetAllNotesEvent extends NotesEvent {}
class AddNoteEvent extends NotesEvent {
  final Note note ;
    AddNoteEvent({required this.note});
}
class RefreshNotesEvent extends NotesEvent {}
class DeleteNotesEvent extends NotesEvent {
  final int id ;
  DeleteNotesEvent({required this.id});
}

class UpdateNoteEvent extends NotesEvent {
  final Note note ;
  UpdateNoteEvent({required this.note});
}