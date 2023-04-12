import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notes_bloc/notes_bloc.dart';
import '../widgets/body_widget.dart';
import 'add_note_page.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddNotePage()));
      }, child: const Icon(Icons.add),),
      body:  const  SafeArea(
        child:     BodyWidget()
      ),
    );
  }
}