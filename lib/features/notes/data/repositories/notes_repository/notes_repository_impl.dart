
import 'package:dartz/dartz.dart';
import 'package:notes/core/errors/exceptions/notes_exceptions.dart';
import 'package:notes/core/errors/failures/notes_failures.dart';
import 'package:notes/features/notes/data/data_sources/local_data_source_inter/notes_local_inter.dart';
import 'package:notes/features/notes/data/models/note_model.dart';
import 'package:notes/features/notes/domain/entities/note.dart';
import 'package:notes/features/notes/domain/repositories/notes_repository_interface.dart';

class NotesRepositoryImpl implements NotesRepositoryInter{
  final NotesLocalInter notesLocalInter ;
  const NotesRepositoryImpl({required this.notesLocalInter});

  @override
  Future<Unit> addNote(Note note) async{
    NoteModel noteModel = NoteModel(date: note.date, subtitle: note.subtitle, title: note.title, color: note.color);
    await notesLocalInter.addNote(noteModel);

    return Future.value(unit);
  }

  @override
  Future<Unit> deleteNote(int id) async{
    await notesLocalInter.deleteNote(id);
   return Future.value(unit);
  }

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
     try{
       List<Note> notes =  await  notesLocalInter.getAllNotes();
       return Right(notes);
     } on EmptyCacheException {
       return Left(EmptyCacheFailure());
     }
  }

  @override
  Future<Unit> updateNote(Note note) async{
    NoteModel noteModel = NoteModel(date: note.date, subtitle: note.subtitle, title: note.title, color: note.color ,
    id: note.id);
    await notesLocalInter.updateNote(noteModel);
    return Future.value(unit);
  }


}