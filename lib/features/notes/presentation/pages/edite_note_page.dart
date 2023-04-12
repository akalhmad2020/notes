

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/strings/app_strings.dart';

import '../../../../core/utils/snack_bar.dart';
import '../../../../core/widgets/loading.dart';
import '../../domain/entities/note.dart';
import '../bloc/notes_bloc/notes_bloc.dart';
import '../widgets/custom_app_bar_widget.dart';
import 'notes_page.dart';

class EditeNotePage extends StatefulWidget {
  const EditeNotePage({Key? key , required this.note}) : super(key: key);
final Note note ;

  @override
  State<EditeNotePage> createState() => _EditeNoteViewState();
}

class _EditeNoteViewState extends State<EditeNotePage> {


  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();


  @override
  void initState() {
    titleController.text = widget.note.title ;
    bodyController.text = widget.note.subtitle ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:  Form(
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
                          hintText: kHintSubTitle ,
                        ),
                      ),
                      const SizedBox(height: 32,),
                      InkWell(
                        onTap: () async{
                          if(formKey.currentState!.validate()){
                            formKey.currentState!.save();
                            print(bodyController.text);
                            BlocProvider.of<NotesBloc>(context).add(UpdateNoteEvent(
                                note: Note(date: DateTime.now().toString(), subtitle: bodyController.text, title: titleController.text, color: 9 , id: widget.note.id) ));
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
                          child: const Center(child:  Text('Update' , style: TextStyle(color: Colors.black , fontSize: 18),)),
                        ),
                      ) ,
                      const SizedBox(height: 32,),
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }
  OutlineInputBorder buildBorder([Color? color]){
    return  OutlineInputBorder(
      borderSide:   BorderSide(color:  color ?? Colors.white),
      borderRadius: BorderRadius.circular(16) ,
    ) ;
  }
}
