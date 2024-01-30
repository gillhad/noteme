import 'package:noteme/src/models/note_model.dart';
import 'package:noteme/src/utils/time_%20manager.dart';
import 'package:sqflite/sqflite.dart';

import '../models/folder_model.dart';

class DatabaseInfo {
  static Database? db;

  static setDatabase(Database data) {
    // print(data.path);
    db = data;
    // getDatabaseInfo();
  }

  Database? get dataBase{
    return db;
  }

  ///creates database if does not exist
   static onCreateDatabase(Database db) async {
      // print("creamos base de datos");
      await db.execute(
          'CREATE TABLE folders (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, color INTEGER,update_time DATETIME,creation_time DATETIME NOT NULL  DEFAULT "2023-01-01 00:00", image TEXT, pinned BOOLEAN DEFAULT "false" NOT NULL, blocked BOOLEAN DEFAULT "false" NOT NULL, password VARCHAR(8))');
      await db.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, folder_id INTEGER,title VARCHAR,content TEXT,tag TEXT, color INTEGER, icon TEXT,hidden BOOLEAN DEFAULT "false", pinned BOOLEAN DEFAULT "false",background TEXT, reminder_time DATETIME, update_time DATETIME, creation_time DATETIME NOT NULL  DEFAULT "2023-01-01 00:00", delete_time DATETIME, FOREIGN KEY (folder_id) REFERENCES folders(id) ON DELETE SET NULL)');
    }


    ///Create a new note & returns the note
   static addNewNote(NoteClass note) async {
      try {
        await db!.insert('notes', note.toMap());
        var newNote = await db!.rawQuery('SELECT * FROM notes ORDER BY id DESC LIMIT 1');
        return NoteClass.fromJson(newNote[0]);
      } catch (e,s) {
        print(e);
        print(s);
        return false;
      }
    }


    ///Create a new folder and returns the folder
   static addNewFolder(Folders folder) async {
      try {
        await db!.insert('folders', folder.toMap());
        var newFolder = await db!.rawQuery('SELECT * FROM folders ORDER BY id DESC LIMIT 1');
        return Folders.fromJson(newFolder[0]);
      } catch (e,s) {
        print(e);
        print(s);
        return false;
      }
    }


    ///Add note to a folder
   static noteToFolder(int noteId, int? folderId) async {
      try {
        await db!.update(
            "notes", {"folder_id": folderId}, where: 'id = $noteId');
      } catch (e) {
        return false;
      }
    }


    ///Delete a note
   static deleteNote(noteId) async {
      try {
        await db!.delete("notes", where: 'id = $noteId');
      } catch (e) {
        return false;
      }
    }



    ///Delete a folder
   static deleteFolder(folderId) async {
     try {
       await db!.delete("folders", where: 'id=$folderId');
     } catch (e) {
       return false;
     }
   }


   ///Update a note & return the note updated
   static updateNote(NoteClass note) async{
     try {
       var oldNote = await db!.rawQuery('SELECT * FROM notes WHERE id= ${note.id}');
       await db!.update(
           "notes", note.toMap(), where: 'id = ${note.id}');
       if(note.folderId!=null){
         await db!.update('folders', {"update_time":TimeManager.dateTimeToDB(DateTime.now())},where: 'id = ${note.folderId}');
       }
       var newNote = await db!.rawQuery('SELECT * FROM notes WHERE id=  ${note.id}');
       return newNote;
     } catch (e) {
       return false;
     }
   }


   ///Update a folder
   static updateFolder(folders)async{
     try {
       await db!.update(
           "folders", folders.toMap(), where: 'id = ${folders.id}');
       return true;
     } catch (e) {
       return false;
     }
   }


   ///print current folders and notes
    static getDatabaseInfo() async {
        print("print info");
        print(await getFolders());
        print(await getNotes());
      }

      ///Return all folders
    static getFolders()async{
    var info = await db!.rawQuery('SELECT * FROM folders');
    return info;
    }


    ///Return notes in a folder
    static getNotesInFolder(folderId)async{
    var info = await db!.rawQuery("SELECT * FROM notes WHERE folder_id = $folderId");
    return info;
    }

    ///Return all notes not in folders
  static getNotes()async{
    var info = await db!.rawQuery('SELECT * FROM notes WHERE folder_id IS NULL');
    return info;
  }

  ///Get note by ID
  static getNoteById(){}

  ///Get folder by ID
  static getFolderById(){}

}


// addExampleItems()async{
//   NoteClass exampleNote = NoteClass(title: "title", content: "",creationTime:DateTime.now() );
//   Folders folder = Folders(title: "folder",creationTime: DateTime.now());
//   try {
//     await DatabaseInfo.addNewNote(exampleNote);
//     await DatabaseInfo.addNewNote(exampleNote);
//     await DatabaseInfo.addNewNote(exampleNote);
//     await DatabaseInfo.addNewFolder(folder);
//   }catch(e){
//     print(e);
//   }
// }


