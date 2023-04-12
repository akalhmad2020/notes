
import 'package:dartz/dartz.dart';
import 'package:notes/core/errors/exceptions/notes_exceptions.dart';
import 'package:notes/core/helpers/notes_helper.dart';
import 'package:notes/core/strings/const_strings_app.dart';
import 'package:notes/features/notes/data/data_sources/local_data_source_inter/notes_local_inter.dart';
import 'package:notes/features/notes/data/models/note_model.dart';


 class NotesLocalImpl implements NotesLocalInter{
  final NoteHelper noteHelper ;
  const NotesLocalImpl({required this.noteHelper});
  @override
  Future<Unit> addNote(NoteModel noteModel) async{

   await noteHelper.insertNote(table: kNoteTable, values: {
    kNoteTitleField : noteModel.title ,
    kNoteSubTitleField : noteModel.subtitle ,
    kNoteDateField : noteModel.date ,
    kNoteColorField : noteModel.color ,
   });

  return Future.value(unit);
  }

  @override
  Future<Unit> deleteNote(int id) async {
    await noteHelper.deleteNote(table: kNoteTable, where: 'id=?' , whereArgs: [id]);
     return Future.value(unit);
  }

  @override
  Future<List< NoteModel>> getAllNotes() async {

   List<Map<String, dynamic>> allNotes   =  await noteHelper.readData(table: kNoteTable);
   if(allNotes.isNotEmpty){
    List<NoteModel> noteModels = allNotes.map<NoteModel>((notModelAsJson) => NoteModel.fromJson(notModelAsJson)).toList();
    return noteModels ;
   }else {
    throw EmptyCacheException();
   }
  }

  @override
  Future<Unit> updateNote(NoteModel noteModel) async{
   Map<String,dynamic> value = noteModel.toJson() ;
     await noteHelper.updateNote(table: kNoteTable, values: value , where: 'id=?', whereArgs: [noteModel.id]);
     return Future.value(unit);
  }

}