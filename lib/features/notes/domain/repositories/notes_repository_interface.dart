
import 'package:notes/core/errors/failures/notes_failures.dart';
import 'package:notes/features/notes/domain/entities/note.dart';
import 'package:dartz/dartz.dart';
abstract class NotesRepositoryInter{

 Future<Either<Failure , List<Note>>> getAllNotes();
 Future<Unit> addNote(Note note) ;
 Future<Unit> updateNote(Note note) ;
 Future<Unit> deleteNote(int id) ;

}