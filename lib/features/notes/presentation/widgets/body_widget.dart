import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/notes/domain/entities/note.dart';
import 'package:notes/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:notes/features/notes/presentation/widgets/custom_app_bar_widget.dart';

import 'list_notes_widget.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
         if(state is LoadedState){
           return Column(
             children: [
                 CustomAppBar(isItSearch: true, onTap: (){},),
               Expanded(child: RefreshIndicator(
                   onRefresh: () async {
                     BlocProvider.of<NotesBloc>(context).add(RefreshNotesEvent());
                   },
                   child:   ListNotesWidget(list: state.notes,)))
             ],
           );
         } else if (state is ErrorState){
           return Center(child: Text(state.message , style: const TextStyle(fontSize: 25),));
         } else if (state is LoadingState){
           return const Center(child:  CircularProgressIndicator());
         }
         return    const Center(child:  CircularProgressIndicator());
        },
      ),
    );
  }
}
