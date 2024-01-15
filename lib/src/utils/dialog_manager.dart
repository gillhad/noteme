import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogManager {

  showCustomDialog(context, {
    required String title,
    required Widget content,
    required Function onCancel,
    required Function onAccept,
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
        }, child: Text(AL.of(context).cancel)),
        TextButton(onPressed: (){
          onAccept();
        }, child: Text(AL.of(context).accept)),
      ],
    );
  });

  }
}

dialogAddFolder(context,WidgetRef ref){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Añade un título"),
      content: Text("el título que pondrás"),
      actions: [

      ],
    );
  });
}