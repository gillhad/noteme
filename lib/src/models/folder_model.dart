import 'package:flutter/material.dart';
import 'package:noteme/src/models/item_model.dart';
import 'package:noteme/src/utils/helpers/database_helper.dart';
import 'package:noteme/src/utils/time_%20manager.dart';

import 'note_model.dart';

class Folders extends ItemModel {
  // late int id;
  // late String title;
  //  Color? color;
  //  DateTime? updateTime;
  // late DateTime creationTime;
  String? image;

  // bool pinned = false;
  List<NoteClass> notes = [];

  ///Folder blocked by password
  bool blocked = false;
  String? password;

  Folders({required super.title, required super.creationTime});

  Folders.fromJson(json) : super.fromJson(json) {
    // id = json["id"];
    // title = json["title"];
    // color = json["color"];
    // updateTime = json["update_time"];
    // creationTime = TimeManager.databaseToDateTime(json["creation_time"]);
    image = json["image"];
    pinned = json["pinned"] == 1 ? true : false;
  }

  toMap() {
    Map<String, dynamic> map = {
      "title": super.title,
      "color": super.color,
      "update_time": TimeManager.dateTimeToDB(super.updateTime),
      "creation_time": TimeManager.dateTimeToDB(super.creationTime),
      "image": image,
      "pinned": super.pinned ? 1 : 0
    };
    return map;
  }

  sortItems() {
    notes.sort((a, b) {
      if(!a.pinned && b.pinned){
        return 1;
      }else if(a.pinned && !b.pinned){
        return -1;
      }
      if (a.updateTime != null && b.updateTime != null) {
        if (a.updateTime!.isBefore(b.updateTime!)) {
          return 1;
        } else {
          return -1;
        }
      } else {
        if (a.updateTime != null && b.updateTime != null) {
          if (b.creationTime.isBefore(a.creationTime)) {
            return -1;
          } else {
            return 1;
          }
        } else {
          if (a.updateTime != null && b.updateTime == null) {
            return -1;
          } else {
            return 1;
          }
        }
      }
    });
  }

  updateNotes()async{
    print("update notes");
    notes = await DataBaseHelper.getNoteInFolders(id);
    sortItems();
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Folders && hashCode == other.hashCode;
  }

  @override
  int get hashCode => id;

  @override
  String toString() {
    return "title: $title, id:$id, creationTime:$creationTime, updateTime:$updateTime, pinned:$pinned";
  }
}
