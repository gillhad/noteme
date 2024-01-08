import 'package:sqflite/sqflite.dart';

class DatabaseInfo{
  static Database? db;


  static setDatabase(Database data){
    db = data;
  }
}

onCreateDatabase(Database db)async{
  print("creamos base de datos");
  await db.execute('CREATE TABLE folders (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, color TEXT,update_Time DATETIME NOT NULL,create_time DATETIME NOT NULL image TEXT, pinned BOOLEAN DEFAULT "false" NOT NULL, blocked BOOLEAN DEFAULT "false" NOT NULL, password VARCHAR(8))');
  await db.execute('CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, folderId INTEGER,title VARCHAR,content TEXT,tag TEXT, color TEXT, icon TEXT,hidden BOOLEAN DEFAULT "false", pinned BOOLEAN DEFAULT "false",background TEXT, reminder_time DATETIME, update_time DATETIME NOT NULL, creation_time DATETIME NOT NULL, delete_time DATETIME, update_time DATETIME, CONSTRAINT folder_reference FOREIGN KEY (folderId) REFERENCES folders(id) )');
  await db.rawInsert('INSERT INTO notes(title) VALUES ("SuperTitle")');

  getDatabaseInfo();
}

getDatabaseInfo()async{
  print("printar notes");
  print(await DatabaseInfo.db!.rawQuery('SELECT * FROM notes'));
}