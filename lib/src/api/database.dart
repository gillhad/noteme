import 'package:noteme/src/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

import '../models/folder_model.dart';

class DatabaseInfo {
  static Database? db;

  static setDatabase(Database data) {
    db = data;
  }

  Database? get dataBase{
    return db;
  }

   static onCreateDatabase(Database db) async {
      print("creamos base de datos");
      await db.execute(
          'CREATE TABLE folders (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, color TEXT,update_time DATETIME,creation_time DATETIME NOT NULL  DEFAULT "2023-01-01 00:00", image TEXT, pinned BOOLEAN DEFAULT "false" NOT NULL, blocked BOOLEAN DEFAULT "false" NOT NULL, password VARCHAR(8))');
      await db.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, folder_id INTEGER,title VARCHAR,content TEXT,tag TEXT, color TEXT, icon TEXT,hidden BOOLEAN DEFAULT "false", pinned BOOLEAN DEFAULT "false",background TEXT, reminder_time DATETIME, update_time DATETIME, creation_time DATETIME NOT NULL  DEFAULT "2023-01-01 00:00", delete_time DATETIME, FOREIGN KEY (folder_id) REFERENCES folders(id) )');
    }


   static addNewNote(NoteClass note) async {
      try {
        await db!.insert('notes', note.toMap());
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }

   static addNewFolder(Folders folder) async {
      try {
        await db!.insert('notes', folder.toMap());
      } catch (e) {
        return false;
      }
    }

   static noteToFolder(int noteId, int folderId) async {
      try {
        await db!.update(
            "notes", {"folder_id": folderId}, where: 'id = noteId');
      } catch (e) {
        return false;
      }
    }

   static deleteNote(noteId) async {
      try {
        await db!.delete("notes", where: 'id = noteId');
      } catch (e) {
        return false;
      }
    }

   static deleteFolder(folderId) async {
     try {
       await db!.delete("folder", where: 'id=folderId');
     } catch (e) {
       return false;
     }
   }

    static getDatabaseInfo() async {
        print("printar notes");
        print(await getFolders());
        print(await getNotes());
      }

    static getFolders()async{
    var info = await DatabaseInfo.db!.rawQuery('SELECT * FROM folders');
    return info;
    }

  static getNotes()async{
    var info = await DatabaseInfo.db!.rawQuery('SELECT * FROM notes');
    return info;
  }

}


addExampleItems()async{
  NoteClass exampleNote = NoteClass(title: "title", content: "",creationTime:DateTime.now() );
  Folders folder = Folders(title: "folder",creationTime: DateTime.now());
  try {
    await DatabaseInfo.addNewNote(exampleNote);
    await DatabaseInfo.addNewNote(exampleNote);
    await DatabaseInfo.addNewNote(exampleNote);
    await DatabaseInfo.addNewFolder(folder);
  }catch(e){
    print(e);
  }
}


