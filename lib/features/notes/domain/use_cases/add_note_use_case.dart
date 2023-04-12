
import 'package:dartz/dartz.dart';
import 'package:notes/features/notes/domain/entities/note.dart';
import 'package:notes/features/notes/domain/repositories/notes_repository_interface.dart';

class AddNoteUseCase {

  final NotesRepositoryInter notesRepositoryInter ;
  const AddNoteUseCase({required this.notesRepositoryInter});

  Future<Unit> call(Note note)async{
    return await notesRepositoryInter.addNote(note);
  }

}