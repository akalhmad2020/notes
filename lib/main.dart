import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/helpers/notes_helper.dart';
import 'package:notes/features/notes/domain/use_cases/get_all_notes.dart';
import 'package:notes/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:notes/features/notes/presentation/pages/notes_page.dart';
import 'core/strings/app_strings.dart';
import 'dependency_injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteHelper().initDb();
  // await NoteHelper().db ;
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (context) => di.sl<NotesBloc>()..add(GetAllNotesEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kAppTitle,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home:    const NotesPage(),
      ),
    );
  }
}
