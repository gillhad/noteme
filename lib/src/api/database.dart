import 'package:noteme/src/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

import '../models/folder_model.dart';

class DatabaseInfo{
  static Database? db;


  static setDatabase(Database data){
    db = data;
  }
}

onCreateDatabase(Database db)async{
  print("creamos base de datos");
  await db.execute('CREATE TABLE folders (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, color TEXT,update_time DATETIME NOT NULL,creation_time DATETIME NOT NULL image TEXT, pinned BOOLEAN DEFAULT "false" NOT NULL, blocked BOOLEAN DEFAULT "false" NOT NULL, password VARCHAR(8))');
  await db.execute('CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, folderId INTEGER,title VARCHAR,content TEXT,tag TEXT, color TEXT, icon TEXT,hidden BOOLEAN DEFAULT "false", pinned BOOLEAN DEFAULT "false",background TEXT, reminder_time DATETIME, update_time DATETIME NOT NULL, creation_time DATETIME NOT NULL, delete_time DATETIME, update_time DATETIME, FOREIGN KEY (folderId) REFERENCES folders(id) )');
  // await db.execute('CREATE TABLE folder_reference (folder_id INTEGER NOT NULL, note_id INTEGER NOT NULL)');
  await db.rawInsert('INSERT INTO notes(title) VALUES ("SuperTitle")');

  getDatabaseInfo();

  addNewNote(NoteClass note)async{
    await db.insert('notes', note.toMap());
  }

  addNewFolder(Folders folder)async{
    await db.insert('notes', folder.toMap());
  }

  noteToFolder(int noteId, int folderId)async{
    await db.update("notes",{"folder_id":folderId},where: 'id = noteId');
  }


}



getDatabaseInfo()async{
  print("printar notes");
  print(await DatabaseInfo.db!.rawQuery('SELECT * FROM notes'));
}