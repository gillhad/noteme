


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteme/src/api/database.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/models/list_model.dart';
import 'package:noteme/src/utils/helpers/database_helper.dart';

import '../models/note_model.dart';



// final itemsRepository = Provider<NoteProvider>(
//         (ref) => NoteProvider(ref)
// );

final listProvider = StateNotifierProvider<ItemListState, List<dynamic>>(ItemListState.new);

class ItemListState extends StateNotifier<List<dynamic>>{
  ItemListState(this._ref):super([]){
    _init();
  }
  final Ref _ref;
  List<dynamic> itemList = [];

  _init() async {
    try {
      state = await DataBaseHelper.getAll();
      sort();
    }catch(e,s){
      print(e);
      print(s);
    }
    }


  void getAll()async{
    state = await DataBaseHelper.getAll();
  }
  
  

  Future add(item)async{
    print(state.length);
    if(item is NoteClass) {
      var newNote =  await DatabaseInfo.addNewNote(item);
      state.insert(0,newNote);
      }else if(item is Folders){
      var newFolder =  await DatabaseInfo.addNewFolder(item);
      if(newFolder!=false) {
        state.insert(0,newFolder);
      }
    }
    sort();
      state= [...state];
  }

  Future update(item)async{
    if(item is NoteClass){
      await DatabaseInfo.updateNote(item);
    }else if(item is Folders){
      await DatabaseInfo.updateFolder(item);
    }else{
      return null;
    }
    state[state.indexWhere((listItem) => listItem.id == item.id && listItem.runtimeType == item.runtimeType)] = item;
    sort();
    state = [...state];
  }


  Future remove(item)async{
    if(item is NoteClass) {
      await DatabaseInfo.deleteNote(item.id);
    }else{
      // await _ref.read(itemsRepository).deleteNote(item);
    }
    state.remove(item);
    state = [...state];
  }

  getFolders(){
    var items =  itemList.whereType<Folders>();
    var newItems = itemList.where((item) => item is Folders);
    return itemList.whereType<Folders>();
  }

  sort()async{
   state.sort((a,b){
     if(a.updateTime!=null && b.updateTime!=null){
       if(a.updateTime.isBefore(b.updateTime)){
         return 1;
       }else{
         return -1;
       }
     }else{
       if(a.updateTime==null && b.creationTime!=null){
         return -1;
       }else{
         if(a.creationTime.isBefore(b.creationTime)){
           return 1;
         }else{
           return -1;
         }
       }
     }
    });
   state = [...state];
  }
}

//
// class NoteProvider{
//
// final Ref ref;
// final itemList = [];
// NoteProvider(this.ref);
//
//
// Future getAll()async{
// var response = await DataBaseHelper.getAll();
// response.forEach((item) {
//   if(!itemList.contains(item)){
//     itemList.add(item);
//   }
// });
// return itemList;
// }
//
// Future addNote(NoteClass note)async{
//   try{
//    var newNote = await DatabaseInfo.addNewNote(note);
//
//   }catch(e){}
// }
//
// Future updateNote(NoteClass note)async{
//
// }
//
// Future updateFolder()async{
//
// }
//
// Future deleteNote(note)async{
//   try {
//     await DatabaseInfo.deleteNote(note.id);
//     itemList.remove(note);
//     print("se ha eliminado la nota en ref");
//   }catch(e){
// print(e);
//   }
// }
//
//   Future deleteFolder()async{}
//
//
//
// }

