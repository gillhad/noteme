import 'package:noteme/src/api/database.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../models/note_model.dart';

class DataBaseHelper{

  static Future getAll()async{
     List<dynamic> items = [];
     var folders = await DatabaseInfo.getFolders();
     var notes = await DatabaseInfo.getNotes();
     print("folders");
     print(folders);
     try {
       folders.forEach((folder) => items.add(Folders.fromJson(folder)));
       notes.forEach((note) => items.add(NoteClass.fromJson(note)));
     }catch(e,s){
       print(e);
       print(s);
     }
     return items;
  }
  
  
}