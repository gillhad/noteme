import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteme/src/models/item_model.dart';
import 'package:noteme/src/utils/time_%20manager.dart';



class NoteClass extends ItemModel{
late String content;
String? tag;
Icon? icon;
bool hidden = false;
int? folderId;
File? background;
DateTime? reminderTime;
DateTime? deleteTime;

NoteClass({required super.title,required this.content, required super.creationTime});

NoteClass.fromJson(json) : super.fromJson(json){
  content = json["content"];  
  tag = json["tag"];
  icon = json["icon"];
  hidden = json["hidden"] == 1 ? true :false;
  folderId = json["folder_id"];
  background = json["background"];
  reminderTime = TimeManager.databaseToDateTime(json["reminder_time"]);
  deleteTime = TimeManager.databaseToDateTime(json["delete_time"]);
  
}

toMap(){
  Map<String,dynamic> map = {
    "title":title,
    "content":content,
    "tag":tag,
    "color":color,
    "icon":icon,
    "hidden":hidden ? 1 : 0,
    "pinned":pinned ? 1 : 0,
    "folder_id":folderId,
    "background":background,
    "reminder_time":TimeManager.dateTimeToDB(reminderTime),
    "update_time":TimeManager.dateTimeToDB(updateTime),
    "creation_time":TimeManager.dateTimeToDB(creationTime),
    "delete_time":TimeManager.dateTimeToDB(deleteTime),
  };
  return map;
}

updateNote(title,content){
  this.title = title;
  this.content = content;
  updateTime = DateTime.now();
}

@override
bool operator == (Object other){
  return identical(this,other) || other is NoteClass && hashCode == other.hashCode;
}

  @override
  int get hashCode => id;


@override
  String toString() {
    return "title: $title, id:$id,content:$content, updateTime:$updateTime";
  }

}
