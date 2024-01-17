import 'package:flutter/material.dart';

import '../utils/time_ manager.dart';

class ItemModel{
  late int id;
  late String title;
  Color? color;
  DateTime? updateTime;
  late DateTime creationTime;
  bool pinned = false;

  ItemModel.fromJson(json){
    id = json["id"];
    title = json["title"];
    color = json["color"];
    updateTime = json["update_time"];
    creationTime = TimeManager.databaseToDateTime(json["creation_time"]);
    pinned = json["pinned"] == 1 ? true : false;
  }
}