
import 'package:dartz/dartz.dart';
import 'package:notes/features/notes/data/models/note_model.dart';

abstract class NotesLocalInter{
  Future<List< NoteModel>> getAllNotes();
  Future<Unit> addNote(NoteModel noteModel);
  Future<Unit> updateNote(NoteModel noteModel);
  Future<Unit> deleteNote(int id);
}