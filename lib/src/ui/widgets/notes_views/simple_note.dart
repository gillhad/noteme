import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:noteme/src/config/app_styles.dart';
import 'package:noteme/src/config/globals.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/config/providers.dart';
import 'package:noteme/src/models/arguments.dart';
import 'package:noteme/src/models/note_model.dart';
import 'package:noteme/src/ui/widgets/dialogs/dialog_manager_note.dart';

import '../../../models/user.dart';

///Views for different notes in the home page
Widget noteItem(context,NoteClass note,WidgetRef ref){
 User? user =  ref.watch(userState);
  return GestureDetector(
    onTap: (){
      GoRouter.of(context).push(routes.noteView, extra: note);
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: user!.settings.simpleMode ? 50 : 100,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: user.settings.simpleMode ? 0 : 10 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
    border: Border.all(color: AppColors.noDarkColor)
      ),
      child: Row(
        crossAxisAlignment: !user.settings.simpleMode ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
              child: const Icon(Icons.text_snippet_outlined)),
          const SizedBox(width: 10,),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: !user.settings.simpleMode ? MainAxisAlignment.start : MainAxisAlignment.center,
                children: [
                  Text(
                    note.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineSmall,),
                  if(!user.settings.simpleMode)Flexible(child: Text(note.content)),
                ],
              ),
            ),
          ),
          const Spacer(flex: 1,),
          if(note.pinned) const Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.push_pin_outlined)),
          Flexible(
            child: IconButton(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.zero,onPressed: ()async{
              await noteOptionsDialog(context,ref,note);
            }, icon: Icon(Icons.more_vert)),
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