import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/app_colors.dart';

enum SheetThemes{
  none,
  linear,
  noteBook;

  static getTheme(SheetThemes theme){
    switch(theme){
      case linear: return LinePainter();
      case noteBook: return NoteBookPainter();
      default : return null;
    }
  }

  static getSheet(int index){
    switch(index){
      case 1: return SheetThemes.linear;
      case 2: return SheetThemes.noteBook;
      default : return SheetThemes.none;
    }
  }
  static saveSheet(SheetThemes theme) {
    switch (theme) {
      case linear:
        return 1;
      case noteBook:
        return 2;
      default :
        return 0;
    }
  }
}



class NoteBookPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    //TODO: change color depending on theme
    paint.color = AppColors.noDarkColor.withOpacity(0.3);

    for(var offset = 0.0 ;offset < size.height;offset =  offset+21) {
      canvas.drawLine(Offset(0, offset), Offset(size.width,offset), paint);
      // canvas.drawLine(Offset(30, 30), Offset(50,50), paint);
    }
    for(var offset = 0.0 ;offset < size.width;offset =  offset+21){
      canvas.drawLine(Offset(offset, 0), Offset(offset,size.height), paint);
    }
    final paint2 = Paint()..color = Colors.red;
    canvas.drawRect(Rect.fromPoints(Offset(20,0), Offset(21, size.height)), paint2);
    // canvas.drawLine(Offset(21, 0), Offset(21, size.height), paint2);
    // canvas.drawLine(Offset(19, 0), Offset(19, size.height), paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    print("repintar");
    return true;
  }

}


class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    //TODO: change color depending on theme
    paint.color = AppColors.noDarkColor.withOpacity(0.1);

    for(var offset = 0.0 ;offset < size.height;offset =  offset+21) {
      canvas.drawLine(Offset(0, offset), Offset(size.width,offset), paint);
      // canvas.drawLine(Offset(30, 30), Offset(50,50), paint);
    }
    // for(var offset = 0.0 ;offset < size.width;offset =  offset+21){
    //   canvas.drawLine(Offset(offset, 0), Offset(offset,size.height), paint);
    // }
    // final paint2 = Paint()..color = Colors.red;
    // canvas.drawLine(Offset(20, 0), Offset(20, size.height), paint2);
    // canvas.drawLine(Offset(19, 0), Offset(19, size.height), paint2);
    // canvas.drawLine(Offset(18, 0), Offset(18, size.height), paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}