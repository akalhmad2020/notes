
import 'package:dartz/dartz.dart';
import 'package:notes/features/notes/domain/repositories/notes_repository_interface.dart';

class DeleteNoteUseCase {
  final NotesRepositoryInter notesRepositoryInter ;
  const DeleteNoteUseCase({required this.notesRepositoryInter});

  Future<Unit> call(int id)async{
    return await notesRepositoryInter.deleteNote(id);
  }
}