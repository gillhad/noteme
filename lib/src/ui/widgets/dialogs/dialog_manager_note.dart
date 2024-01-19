import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noteme/src/config/notes_provider.dart';
import 'package:noteme/src/utils/helpers/database_helper.dart';

import '../../../models/folder_model.dart';
import '../../../models/note_model.dart';
import '../../../utils/dialog_manager.dart';

noteOptionsDialog(context, WidgetRef ref, NoteClass note) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
            bool addToFolder = false;
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
                      ///OPTION1
                      optionDialog(
                          text: note.pinned ? AL.of(context).dialog_unpin : AL.of(context).dialog_pin,
                          onPressed: (){
                            note.pinned = !note.pinned;
                            ref.read(listProvider.notifier).update(note);
                            GoRouter.of(context).pop();
                      }),
                      ///OPTION2
                      optionDialog(text: AL.of(context).dialog_add_folder, onPressed: () {
                       showFolders(context, ref,note);
                      }),

                      ///OPTION3
                      optionDialog(
                          text: AL.of(context).dialog_reminder, onPressed: () {

                      }),
                      ///OPTION4
                      optionDialog(
                          text: AL.of(context).dialog_delete,
                          onPressed: () async {
                            ref.read(listProvider.notifier).remove(note);
                            GoRouter.of(context).pop();
                          }),
                    ]),
                  ),
                ));
          }
        );
      });
}

showFolders(context,WidgetRef ref,NoteClass note){
  var list = ref.watch(listProvider.notifier).getFolders();
  int? indexSelected;
  if(list.isEmpty){
    addNewFolder(context,ref, note);
  }else {
    //TODO: if no folders, create new one
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, state) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery
                            .of(context)
                            .size
                            .height / 2
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 17),
                            shrinkWrap: true,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    state(() {
                                      if (indexSelected == index) {
                                        indexSelected = null;
                                      } else {
                                        indexSelected = index;
                                      }
                                    });
                                  },
                                  child: selectFolder(
                                      list[index], index, indexSelected));
                            }),
                        GestureDetector(
                          onTap: () async{
                            await addNewFolder(context,ref, note);
                            GoRouter.of(context).pop();
                          },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17),
                              child: Container(
                                child: Row(
                                children: [
                                Icon(Icons.add),
                                Text(AL.of(context).home_add_new_folder)
                                ],
                                ),
                              ),
                            ),
                            ),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            TextButton(onPressed: () {
                            GoRouter.of(context).pop();
                            }, child: Text(AL
                                .of(context)
                                .cancel)),
                            TextButton(onPressed: () {
                            if (indexSelected != null) {
                            note.folderId = list[indexSelected].id;
                            ref.read(listProvider.notifier).addToFolder(
                            note);
                            GoRouter.of(context).pop();
                            GoRouter.of(context).pop();
                            }
                          }, child: Text(AL
                                .of(context)
                                .accept)),
                          ],
                        )
                      ],
                    ),
                  )
              );
            }
        );
      },
    );
  }
}

 addNewFolder(context, WidgetRef ref, note){
  TextEditingController _folderTitleController = TextEditingController();
  return DialogManager().showCustomDialog(context,
      title: AL.of(context).home_add_folder_title,
      content: TextFormField(
        controller: _folderTitleController,
      ),
      onCancel: () {
        GoRouter.of(context).pop();
      },
      onAccept: () async{
        Folders newFolder = Folders(title: _folderTitleController.text, creationTime: DateTime.now());
        try {
          await DataBaseHelper.createAndAddToFolder(newFolder, note, ref);
          _folderTitleController.clear();
          GoRouter.of(context).pop();
          GoRouter.of(context).pop();
        }catch(e){

        }


      });
}

Widget selectFolder(Folders folder, index,indexSelected){
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7,horizontal: 10),
            decoration: BoxDecoration(
              color: index == indexSelected ? Colors.black.withOpacity(0.3) : null,
              borderRadius: BorderRadius.circular(3)
            ),
            child: Text(folder.title)),
      )
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
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.secondary,
      ),
      child: Text(text),
    ),
  );
}
