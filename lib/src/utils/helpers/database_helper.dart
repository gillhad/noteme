import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteme/src/api/database.dart';
import 'package:noteme/src/config/notes_provider.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/models/item_model.dart';

import '../../models/note_model.dart';

class DataBaseHelper{

  static Future getAll()async{
     List<ItemModel> items = [];
     var folders = await DatabaseInfo.getFolders();
     var notes = await DatabaseInfo.getNotes();
     try {
       // List<dynamic> items = [];
       folders.forEach((folder) => items.add(Folders.fromJson(folder)));
       notes.forEach((note) {
         if(note["folder_id"]==null) {
           items.add(NoteClass.fromJson(note));
         }});
       for(var folder in items) {
         if (folder is Folders) {
           var notes = await getNoteInFolders(folder.id);
           if (notes.isNotEmpty) {
             folder.notes.addAll(notes);
           }
         }
       }
     }catch(e,s){
       print(e);
       print(s);
     }
     return items;
  }


  static Future getNoteInFolders(folderId) async{
    List<NoteClass> items = [];
   var response = await DatabaseInfo.getNotesInFolder(folderId);
   response.forEach((note){
     items.add(NoteClass.fromJson(note));
   });
return items;
  }

  static Future updateFolderNotes(ref,int? folderId, int noteId)async{
      var response = await DatabaseInfo.noteToFolder(noteId,folderId);
      ref.read(listProvider.notifier).getAll();
  }

  static Future createFolder(Folders folder, WidgetRef ref)async{
    var response = await DatabaseInfo.addNewFolder(folder);
    ref.read(listProvider.notifier).add(response);
  }

  static Future createAndAddToFolder(Folders folder,NoteClass note, WidgetRef ref)async{
    var response = await DatabaseInfo.addNewFolder(folder);
    await updateFolderNotes(ref, response.id,note.id);

  }


 static sortList(List list){
    List<dynamic> newList = [];
    newList.addAll(list);
    newList.sort((a,b){
      if(a.creationTime.isBefore(b.creationTime)){
        return -1;
      }else{
        return 1;
      }
    });
    return newList;

  }
  
}