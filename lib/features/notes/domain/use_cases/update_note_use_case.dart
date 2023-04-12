
import 'package:dartz/dartz.dart';
import 'package:notes/features/notes/domain/entities/note.dart';
import 'package:notes/features/notes/domain/repositories/notes_repository_interface.dart';

class UpdateNoteUseCase {
  final NotesRepositoryInter notesRepositoryInter ;
  const UpdateNoteUseCase({required this.notesRepositoryInter});

  Future<Unit> call(Note note)async{
    return await notesRepositoryInter.updateNote(note);
  }
}