import 'package:flutter/material.dart';
import 'package:noteme/src/utils/time_%20manager.dart';

import 'note_model.dart';

class Folders {
  late int id;
  late String title;
  late Color color;
  late DateTime updateTime;
  late DateTime creationTime;
  late String image;
  bool pinned = false;
  late List<NoteClass> notes;

  ///Folder blocked by password
  bool blocked = false;
  String? password;

  Folders({required this.title, required this.notes});

  toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "color": color,
      "update_time":TimeManager.dateTimeToDB(updateTime),
      "creation_time":TimeManager.dateTimeToDB(updateTime),
      "image":image,
      "pinned":pinned
    };
    return map;
  }
}
