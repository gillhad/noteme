import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:noteme/src/config/app_styles.dart';
import 'package:noteme/src/config/globals.dart';
import 'package:noteme/src/config/providers.dart';
import 'package:noteme/src/models/note_model.dart';

import '../../../models/user.dart';

///Views for different notes in the home page

Widget noteItem(context,NoteClass note,WidgetRef ref){
  print("repintamos");
 User? user =  ref.watch(userState);
 print("user?.simpleMode");
 print(user?.simpleMode);
  return GestureDetector(
    onTap: (){
      //TODO: abrir la nota
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: user!.simpleMode ? 50 : 100,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: user!.simpleMode ? 0 : 10 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
    border: Border.all(color: AppColors.noDarkColor)
      ),
      child: Row(
        crossAxisAlignment: !user.simpleMode ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
              child: Icon(Icons.text_snippet_outlined)),
          const SizedBox(width: 10,),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisAlignment: !user.simpleMode ? MainAxisAlignment.start : MainAxisAlignment.center,
                children: [
                  Text(
                    longString,
                    maxLines: 1,
                    // note.title,
                    style: textTheme.headlineSmall,),
                  if(!user.simpleMode)Flexible(child: Text(longString))
                ],
              ),
            ),
          ),
          const Spacer(flex: 1,),
          Flexible(
            child: Container(
              child: IconButton(onPressed: (){
                //TODO: abre opcions com añadir recordatorio,pinear, eliminar o subir posición
              }, icon: Icon(Icons.more_vert)),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _moreInfo(){
  return Column(
    children: [

    ],
  );
}