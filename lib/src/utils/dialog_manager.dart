import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/models/item_model.dart';

class DialogManager {

  showCustomDialog(context, {
    required String title,
    required Widget content,
    required Function onCancel,
    required Function onAccept,
    String? cancelMsg,
    String? acceptMsg
  }) {
  return showDialog(
      context: context,
      builder: (context){
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(onPressed: (){
          onCancel();
        }, child: Text(cancelMsg ?? AL.of(context).cancel)),
        TextButton(onPressed: (){
          onAccept();
        }, child: Text( acceptMsg ?? AL.of(context).accept)),
      ],
    );
  });

  }
}

dialogAddFolder(context,WidgetRef ref){
  return showDialog(context: context, builder: (context){
    return const AlertDialog(
      title: Text("Añade un título"),
      content: Text("el título que pondrás"),
      actions: [

      ],
    );
  });
}

///Dialog for delete note
///[delete] Function to delete the note if saved in database
dialogDeleteNote(context, {Function? delete})async{
  return DialogManager().showCustomDialog(
      context, title: AL.of(context).dialog_note_delete,
      content: Text(AL.of(context).dialog_note_delete_msg),
      onCancel: () {
        GoRouter.of(context).pop();
      },
      onAccept: () {
        if(delete!=null){
          delete();
        }
        GoRouter.of(context).pop();
        GoRouter.of(context).pop();
      },
      acceptMsg: AL.of(context).delete);
}