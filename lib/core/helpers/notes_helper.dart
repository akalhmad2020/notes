

import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
class NoteHelper {


  static Database? _db ;

  Future<Database?> get db async{
    _db ??= await initDb();
    return _db ;
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String fullPath = join(databasePath , 'notes.db');
    Database db = await openDatabase(fullPath, version: 1, onCreate: _onCreate , onUpgrade: _onUpgrade);
    return db ;
  }

  Future<void> _onUpgrade(Database db , int oldVersion , int newVersion ) async{

  }

  Future<void> _onCreate(Database db , int version)async{
    await  db.execute(''' 
    CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT , 
    "title" TEXT NOT NULL ,
    "subtitle" TEXT NOT NULL ,
    "date" TEXT NOT NULL ,
    "color" INTEGER NOT NULL 
    )
    ''');

  }


  Future<List<Map<String , dynamic>>> readData({required String table})async{
    Database? myDb = await db ;
    List<Map<String , dynamic>> response = await myDb!.query(table);
    return response ;
  }

  Future<int> insertNote({required String table, required Map<String, dynamic> values})async{
    Database? myDb = await db ;
    int response = await myDb!.insert(table , values);
    return response ;
  }

  Future<int> updateNote({required String table, required Map<String, dynamic> values, required String where ,
  required List<dynamic> whereArgs})async{
    Database? myDb = await db ;
    int response = await myDb!.update(table , values , where: where , whereArgs: whereArgs);
    return response ;
  }

  Future<int> deleteNote({required String table,required String where ,required List<dynamic> whereArgs})async{
    Database? myDb = await db ;
    int response = await myDb!.delete(table , where: where , whereArgs: whereArgs);
    return response ;
  }

}