part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}
class LoadingState extends NotesState {}
class ErrorState extends NotesState {
  final String message ;
  ErrorState({required this.message});
}
class SuccessState extends NotesState {
  final String message ;
  SuccessState({required this.message});
}
class LoadedState extends NotesState {
  final List<Note> notes ;
   LoadedState({required this.notes});
}
