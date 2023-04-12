
import 'package:notes/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({required String date, required String subtitle, required String title, required int color, int? id})
      :super(title: title , id: id , subtitle: subtitle ,color: color , date:  date);

   factory NoteModel.fromJson (Map<String,dynamic> json){
    return NoteModel(date: json['date'], subtitle: json['subtitle'], title: json['title'], color: json['color'], id: json['id']);
  }

    Map<String,dynamic> toJson(){
     return {
       'title':title ,
       'subtitle':subtitle ,
       'date':date ,
       'color':color ,
     };
    }


}