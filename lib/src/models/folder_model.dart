import 'package:flutter/material.dart';
import 'package:noteme/src/models/item_model.dart';
import 'package:noteme/src/utils/time_%20manager.dart';

import 'note_model.dart';

class Folders extends ItemModel{
  // late int id;
  // late String title;
  //  Color? color;
  //  DateTime? updateTime;
  // late DateTime creationTime;
  String? image;
  // bool pinned = false;
  List<NoteClass>? notes;

  ///Folder blocked by password
  bool blocked = false;
  String? password;

  Folders({required this.title,required this.creationTime}) : super.fromJson(null);

   Folders.fromJson(json) : super.fromJson(json){

    id = json["id"];
    title = json["title"];
    color = json["color"];
    updateTime = json["update_time"];
    creationTime = TimeManager.databaseToDateTime(json["creation_time"]);
    image = json["image"];
    pinned = json["pinned"] == 1 ? true : false;
  }

  toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "color": color,
      "update_time":TimeManager.dateTimeToDB(updateTime),
      "creation_time":TimeManager.dateTimeToDB(creationTime),
      "image":image,
      "pinned":pinned ? 1: 0
    };
    return map;
  }

  @override
  bool operator == (Object other){
    return identical(this,other) || other is Folders && hashCode == other.hashCode;
  }

  @override
  int get hashCode => id;

  @override
  String toString() {
    return "title: $title, id:$id, creationTime:$creationTime, updateTime:$updateTime";
  }


}
