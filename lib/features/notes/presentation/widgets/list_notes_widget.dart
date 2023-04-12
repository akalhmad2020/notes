

import 'package:flutter/material.dart';
import 'package:notes/features/notes/domain/entities/note.dart';

import 'note_item.dart';

class ListNotesWidget extends StatefulWidget {
  const ListNotesWidget({Key? key , required this.list}) : super(key: key);

  final List<Note> list ;
  @override
  State<ListNotesWidget> createState() => _ListNotesWidgetState();
}

class _ListNotesWidgetState extends State<ListNotesWidget> {


  @override
  Widget build(BuildContext context)  {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: widget.list.length,
          itemBuilder: (c,i)  {
            return   Padding(
              padding: const  EdgeInsets.symmetric(vertical: 8.0),
              child:  NoteItem(title: widget.list[i].title , subtitle: widget.list[i].subtitle ,
                date: widget.list[i].date , color: widget.list[i].color, id: widget.list[i].id!,),
            );
          }),
    );
  }
}
