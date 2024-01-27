import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteme/src/api/database.dart';
import 'package:noteme/src/app.dart';
import 'package:noteme/src/models/user.dart';
import 'package:noteme/src/utils/helpers/user_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  UserHelper.user = User();
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'notes.db');

  // databaseFactory.deleteDatabase(path);

  DatabaseInfo.setDatabase(await openDatabase("notes.db", version: 1,onCreate: (Database db, int version){
  DatabaseInfo.onCreateDatabase(db);
  }));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);



  runApp(const ProviderScope(child: NoteMe()));
}

