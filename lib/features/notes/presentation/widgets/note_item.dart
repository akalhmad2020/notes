

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/features/notes/domain/entities/note.dart';
import 'package:notes/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';

import '../pages/edite_note_page.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({Key? key , required this.title , required this.color ,
    required this.date , required this.subtitle , required this.id}) : super(key: key);

  final String title ;
  final String subtitle ;
  final String date ;
  final int color ;
  final int id ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>  EditeNotePage(note:
        Note(date: date, subtitle: subtitle
            , title: title, color: color , id: id),)));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 24 ,  bottom: 8 , left: 16  ),
        decoration: BoxDecoration(
            color: const Color(0xffFFCC80) ,
            borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children:  [
            ListTile(
              title:   Text(title , style: const TextStyle(color: Colors.black , fontSize: 26),),
              subtitle:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(subtitle , style: TextStyle(color: Colors.black.withOpacity(0.4) , fontSize: 18 )),
              ),
              trailing: IconButton(onPressed: (){
                BlocProvider.of<NotesBloc>(context).add(DeleteNotesEvent(id: id));
                BlocProvider.of<NotesBloc>(context).add(RefreshNotesEvent());

              }, icon: const Icon(FontAwesomeIcons.trash , color: Colors.black, size: 26,)),
            ),
            Padding(

              padding: const EdgeInsets.all(24.0),
              child: Text(date , style: TextStyle(color: Colors.black.withOpacity(0.4))),
            )
          ],
        ),
      ),
    );
  }
}