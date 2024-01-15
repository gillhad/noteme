import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noteme/src/config/notes_provider.dart';

import '../../../models/folder_model.dart';
import '../../../models/note_model.dart';

noteOptionsDialog(context, WidgetRef ref, NoteClass note) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
            bool _addToFolder = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      optionDialog(text: AL.of(context).dialog_add_folder, onPressed: () {
                        setState((){
                          _addToFolder = !_addToFolder;
                          print(_addToFolder);
                        });
                      }),
                      if(_addToFolder) showFolders(context, ref),
                      optionDialog(
                          text: AL.of(context).dialog_reminder, onPressed: () {}),
                      optionDialog(
                          text: AL.of(context).dialog_delete,
                          onPressed: () async {
                            print("se procede a eliminar una nota");
                            ref.read(listProvider.notifier).remove(note);
                            print("eliminación correcta");
                            GoRouter.of(context).pop();
                          }),
                    ]),
                  ),
                ));
          }
        );
      });
}

Widget showFolders(context,WidgetRef ref){
  var list = ref.watch(listProvider.notifier).getFolders();
  //TODO: if no folders, create new one
  print("list");
  print(list.length);
  return ConstrainedBox(
    constraints: BoxConstraints(maxHeight: 50,minWidth: MediaQuery.of(context).size.width,minHeight: 0),
    child: ListView.builder(
      shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context,index){
      return Container(height: 5,width: 5,color: Colors.red,);
    }),
  );
}

Widget selectFolder(Folders folder){
  return Row(
    children: [
      Text(folder.title)
    ],
  );
}

Widget optionDialog({required String text, required Function onPressed}) {
  return GestureDetector(
    onTap: () {
      onPressed();
    },
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.secondary,
      ),
      child: Text(text),
    ),
  );
}
