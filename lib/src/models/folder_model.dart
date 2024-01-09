import 'package:flutter/material.dart';
import 'package:noteme/src/utils/time_%20manager.dart';

import 'note_model.dart';

class Folders {
  late int id;
  late String title;
   Color? color;
   DateTime? updateTime;
  late DateTime creationTime;
  late String image;
  bool pinned = false;
  List<NoteClass>? notes;

  ///Folder blocked by password
  bool blocked = false;
  String? password;

  Folders({required this.title,required this.creationTime});

   Folders.fromJson(Map<String,dynamic> json){
     print("id type");
     print(json["id"].runtimeType);
    id = json["id"];
    title = json["title"];
    color = json["color"];
    updateTime = json["update_time"];
    creationTime = TimeManager.databaseToDateTime(json["creation_time"]);
    image = json["image"];
    pinned = json["pinned"];
  }

  toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "color": color,
      "update_time":TimeManager.dateTimeToDB(updateTime),
      "creation_time":TimeManager.dateTimeToDB(updateTime),
      "image":image,
      "pinned":pinned ? 1: 0
    };
    return map;
  }
}
