import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteme/src/utils/time_%20manager.dart';



class NoteClass{
late int id;
late String title;
late String content;
String? tag;
late Color color;
Icon? icon;
late bool hidden;
late bool pinned;
int? folderId;
File? background;
DateTime? reminderTime;
DateTime? updateTime;
late DateTime creationTime;
DateTime? deleteTime;

NoteClass({required this.id, required this.title,required this.content});

toMap(){
  Map<String,dynamic> map = {
    "title":title,
    "content":content,
    "tag":tag,
    "color":color,
    "icon":icon,
    "hidden":hidden,
    "pinned":pinned,
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
