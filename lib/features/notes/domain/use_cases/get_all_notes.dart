
import 'package:dartz/dartz.dart';
import 'package:notes/core/errors/failures/notes_failures.dart';
import 'package:notes/features/notes/domain/entities/note.dart';
import 'package:notes/features/notes/domain/repositories/notes_repository_interface.dart';

class GetAllNotesUseCase {
  final NotesRepositoryInter notesRepositoryInter ;
  const GetAllNotesUseCase({required this.notesRepositoryInter});

  Future<Either<Failure, List<Note>>> call ()async{
    return await notesRepositoryInter.getAllNotes();
  }

}