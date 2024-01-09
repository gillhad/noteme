import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteme/src/utils/time_%20manager.dart';



class NoteClass{
late int id;
late String title;
late String content;
String? tag;
Color? color;
Icon? icon;
bool hidden = false;
bool pinned = false;
int? folderId;
File? background;
DateTime? reminderTime;
DateTime? updateTime;
late DateTime creationTime;
DateTime? deleteTime;

NoteClass({required this.title,required this.content, required this.creationTime});

NoteClass.fromJson(json){
  print("id type");
  print(json);
  print(json["id"].runtimeType);
  id = json["id"];
  title = json["title"];  
  content = json["content"];  
  tag = json["tag"];
  color = json["color"];
  icon = json["icon"];
  hidden = json["hidden"] == 1 ? true :false;
  pinned = json["pinned"]  == 1 ? true :false;
  folderId = json["folder_id"];
  background = json["background"];
  reminderTime = json["reminder_time"];
  updateTime = json["update_time"]; 
  creationTime = TimeManager.databaseToDateTime(json["creation_time"]);
  deleteTime = json["delete_time"];
  
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

}
