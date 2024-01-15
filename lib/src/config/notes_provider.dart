


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
      print("carga items de inicio");
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
      try {
      var newNote =  await DatabaseInfo.addNewNote(item);
      state.add(newNote);
      state = [...state];
      }catch(e,s){
        print(e);
        print(s);
      }
      }else if(item is Folders){
      print("voy a añadir un folder");
      var newFolder =  await DatabaseInfo.addNewFolder(item);
      print(newFolder);
      state.add(newFolder);
      state= [...state];
    }


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
    print(items.length);
    var newItems = itemList.where((item) => item is Folders);
    print(newItems);
    return itemList.whereType<Folders>();
  }

  sort()async{
    print("intento ordenar");
    print(state);
   final newState = state.sort((a,b){
      if(a.creationTime.isBefore(b.creationTime)){
        return 1;
      }else{
        return -1;
      }
    });
   state = [...state];
    print(itemList);
    print(state);
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

