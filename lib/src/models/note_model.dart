import 'dart:io';

import 'package:flutter/material.dart';



class NoteClass{
late int id;
late String title;
String? content;
String? tag;
late Color color;
Icon? icon;
late bool hidden;
late bool pinned;
File? background;
DateTime? reminderTime;
late DateTime updateTime;
late DateTime creationTime;
DateTime? deleteTime;

NoteClass({required this.id, required this.title});

}
