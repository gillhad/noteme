import 'package:flutter/material.dart';

import 'note_model.dart';

class Folders{
  late int id;
  late String title;
  late Color color;
  late DateTime updateTime;
  late String image;
  bool pinned = false;
  late List<NoteClass> notes;
  ///Folder blocked by password
  bool blocked = false;
  String? password;
}