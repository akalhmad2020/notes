
import 'package:get_it/get_it.dart';
import 'package:notes/core/helpers/notes_helper.dart';
import 'package:notes/features/notes/data/data_sources/local_data_source_impl/notes_local_impl.dart';
import 'package:notes/features/notes/data/data_sources/local_data_source_inter/notes_local_inter.dart';
import 'package:notes/features/notes/data/repositories/notes_repository/notes_repository_impl.dart';
import 'package:notes/features/notes/domain/repositories/notes_repository_interface.dart';
import 'package:notes/features/notes/domain/use_cases/add_note_use_case.dart';
import 'package:notes/features/notes/domain/use_cases/delete_note_use_case.dart';
import 'package:notes/features/notes/domain/use_cases/get_all_notes.dart';
import 'package:notes/features/notes/domain/use_cases/update_note_use_case.dart';
import 'package:notes/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';

final sl = GetIt.instance ;

Future<void> init() async{

  // bloc
  sl.registerFactory(() => NotesBloc(getAllNotesUseCase: sl(), addNoteUseCase: sl() ,
      deleteNoteUseCase:  sl() , updateNoteUseCase: sl()));

  // use cases
   sl.registerLazySingleton(() => GetAllNotesUseCase(notesRepositoryInter: sl()));
   sl.registerLazySingleton(() => AddNoteUseCase(notesRepositoryInter: sl()));
   sl.registerLazySingleton(() => DeleteNoteUseCase(notesRepositoryInter: sl()));
   sl.registerLazySingleton(() => UpdateNoteUseCase(notesRepositoryInter: sl()));

  // repositories
  sl.registerLazySingleton<NotesRepositoryInter>(() => NotesRepositoryImpl(notesLocalInter: sl()));

  // dada sources
  sl.registerLazySingleton<NotesLocalInter>(() => NotesLocalImpl(noteHelper: sl()));

  // external
  NoteHelper noteHelper = NoteHelper();
   await noteHelper.db;

  sl.registerLazySingleton(() => noteHelper );


}