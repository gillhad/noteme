import 'package:flutter/material.dart';

import '../utils/time_ manager.dart';

class ItemModel{
  late int id;
  late String title;
  Color? color;
  DateTime? updateTime;
  late DateTime creationTime;
  bool pinned = false;

  ItemModel({required this.title, required this.creationTime});

  ItemModel.fromOther(this.id, this.title, this.updateTime,this.creationTime);

  ItemModel.fromJson(json){
    id = json["id"];
    title = json["title"];
    color = json["color"];
    updateTime =  TimeManager.databaseToDateTime(json["update_time"]);
    creationTime = TimeManager.databaseToDateTime(json["creation_time"])!;
    pinned = json["pinned"] == 1 ? true : false;
  }

  @override
  String toString() {
    return "id:$id, creationTime:$creationTime, updateTime:$updateTime, title:$title";
  }

  @override
  bool operator == (Object other){
    return identical(this,other) || other is ItemModel && hashCode == other.hashCode;
  }

  @override
  int get hashCode => id;
}