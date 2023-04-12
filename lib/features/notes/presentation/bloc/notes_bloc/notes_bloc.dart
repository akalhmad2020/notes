

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:notes/core/strings/failures.dart';
import 'package:notes/core/strings/messages.dart';
import 'package:notes/features/notes/domain/entities/note.dart';
import 'package:notes/features/notes/domain/use_cases/add_note_use_case.dart';
import 'package:notes/features/notes/domain/use_cases/delete_note_use_case.dart';
import 'package:notes/features/notes/domain/use_cases/get_all_notes.dart';
import 'package:notes/features/notes/domain/use_cases/update_note_use_case.dart';

import '../../../../../core/errors/failures/notes_failures.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetAllNotesUseCase getAllNotesUseCase ;
  final AddNoteUseCase addNoteUseCase ;
  final DeleteNoteUseCase deleteNoteUseCase ;
  final UpdateNoteUseCase updateNoteUseCase ;
  NotesBloc({required this.getAllNotesUseCase , required this.addNoteUseCase ,
    required this.deleteNoteUseCase , required this.updateNoteUseCase}) : super(NotesInitial()) {
    on<NotesEvent>((event, emit) async {
      if(event is GetAllNotesEvent || event is RefreshNotesEvent){
       // emit(LoadingState());
        Either<Failure, List<Note>> allNotesEither =  await getAllNotesUseCase.call();
         emit(mapFailureOrPostsToState(allNotesEither));
      } else if (event is AddNoteEvent){
      //  emit(LoadingState());
        await addNoteUseCase.call(event.note);
        emit(SuccessState(message: ADD_SUCCESS_MESSAGE));
      } else if (event is DeleteNotesEvent){
        await deleteNoteUseCase.call(event.id);
        emit(SuccessState(message: DELETE_SUCCESS_MESSAGE));
      } else if (event is UpdateNoteEvent){
        await updateNoteUseCase.call(event.note);
        emit(SuccessState(message: UPDATE_SUCCESS_MESSAGE));
      }
    });
  }



 NotesState mapFailureOrPostsToState (Either<Failure , List<Note>> either){
    return either.fold((failure) => ErrorState(message: _mapFailureMessage(failure)), (notes ) => LoadedState(notes: notes));
  }

  String  _mapFailureMessage (Failure failure){
    switch(failure.runtimeType){
      case EmptyCacheFailure :
        return  EMPTY_CACHE_FAILURE_MESSAGE ;
    }
    return '';
  }

}
