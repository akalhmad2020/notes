


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/utils/snack_bar.dart';
import 'package:notes/core/widgets/loading.dart';
import 'package:notes/features/notes/domain/entities/note.dart';
import 'package:notes/features/notes/presentation/bloc/notes_bloc/notes_bloc.dart';
import 'package:notes/features/notes/presentation/pages/notes_page.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {

  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 32),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: BlocConsumer<NotesBloc, NotesState>(
                   listener: (context, state) {

                     if(state is SuccessState){
                       SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
                       BlocProvider.of<NotesBloc>(context).add(RefreshNotesEvent());
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const NotesPage()), (route) => false);
                     } else if(state is ErrorState){
                       SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
                     }
                         },
                  builder: (context, state) {
                if(state is LoadingState){
                  return const Center(child: LoadingWidget(),);
                }
                return Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      autovalidateMode: autoValidateMode,
                      validator: (v){
                        if(v?.isEmpty ?? true){
                          return 'Title can\'t be empty';
                        }
                      },
                      maxLines: 1,
                      minLines: 1,
                      decoration: InputDecoration(
                          border: buildBorder(),
                          enabledBorder: buildBorder(),
                          focusedBorder: buildBorder(const Color(0xff63FCD7)),
                          hintText: 'Title'
                      ),
                    ),
                    const SizedBox(height: 32,),
                    TextFormField(
                      controller: bodyController,
                      autovalidateMode: autoValidateMode,
                      validator: (v){
                        if(v?.isEmpty ?? true){
                          return 'Subtitle can\'t be empty';
                        }
                      },
                      maxLines: 6,
                      minLines: 6,
                      decoration: InputDecoration(
                        border: buildBorder(),
                        enabledBorder: buildBorder(),
                        focusedBorder: buildBorder(const Color(0xff63FCD7)),
                        hintText: 'Subtitle' ,
                      ),
                    ),
                    const SizedBox(height: 32,),
                    InkWell(
                      onTap: () async{
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          BlocProvider.of<NotesBloc>(context).add(AddNoteEvent(
                              note: Note(date: DateTime.now().toString(), subtitle: bodyController.text, title: titleController.text, color: 9) ));

                        } else {

                          autoValidateMode = AutovalidateMode.always;
                          setState(() {

                          });
                        }
                      },
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xff63FCD7) ,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: const Center(child:  Text('Add' , style: TextStyle(color: Colors.black , fontSize: 18),)),
                      ),
                    ) ,
                    const SizedBox(height: 32,),
                  ],
                );
  },
),
              ),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder([Color? color]){
    return  OutlineInputBorder(
      borderSide:   BorderSide(color:  color ?? Colors.white),
      borderRadius: BorderRadius.circular(16) ,
    ) ;
  }
}
