import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noteme/src/utils/dialog_manager.dart';
import 'package:noteme/src/utils/form_validation.dart';

import '../../../config/app_colors.dart';
import '../../../config/notes_provider.dart';
import '../../../models/folder_model.dart';
import '../../../models/folder_model.dart';

folderOptionsDialog(context, WidgetRef ref, Folders folder) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        bool addToFolder = false;
        return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                  shape:
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [

                        ///OPTION1
                        optionDialog(text: AL
                            .of(context)
                            .dialog_rename, onPressed: () {
renameDialog(context, ref, folder);
                        }),

                        ///OPTION2
                        optionDialog(
                            text: folder.pinned ? AL
                                .of(context)
                                .dialog_unpin : AL
                                .of(context)
                                .dialog_pin, onPressed: () {
                          folder.pinned = !folder.pinned;
                          ref.read(listProvider.notifier).update(folder);
                          GoRouter.of(context).pop();
                        }),

                        ///OPTION3
                        optionDialog(
                            text: AL
                                .of(context)
                                .dialog_delete,
                            onPressed: () async {
                              if (!folder.notes.isEmpty) {
                                ref.read(listProvider.notifier).remove(folder);
                                GoRouter.of(context).pop();
                              } else {
                                //TODO: delete everything inside os move outside?
                                deleteOptions(context,ref,folder);
                              }
                            }),
                      ]),
                    ),
                  ));
            }
        );
      });
}

deleteOptions(context,WidgetRef ref,folder) async {
  return DialogManager().showCustomDialog(context,
      title: AL.of(context).dialog_folder_not_empty,
      content: Text(AL.of(context).dialog_folder_msg),
      onCancel: (){
        ref.read(listProvider.notifier).remove(folder);
        GoRouter.of(context).pop();
        GoRouter.of(context).pop();
      },
      onAccept: (){
    GoRouter.of(context).pop();
      },
      cancelMsg: AL.of(context).dialog_delete,
      acceptMsg: AL.of(context).dialog_folder_keep
  );
}

renameDialog(context,WidgetRef ref,Folders folder){
  var textController =  TextEditingController();
  var titleKey = GlobalKey<FormState>();
  textController.text = folder.title;
  return DialogManager().showCustomDialog(
      context,
      title: AL.of(context).dialog_rename,
      content: Form(
        key: titleKey,
        child:
          TextFormField(
            controller: textController,
            validator: (value)=>FormValidation.textValidation(context, value),
          ),
      ),
      onCancel:(){
        GoRouter.of(context).pop();
      },
      onAccept:
      () {
        if (titleKey.currentState!.validate()) {
          folder.title = textController.text;
          ref.read(listProvider.notifier).update(folder);
          GoRouter.of(context).pop();
          GoRouter.of(context).pop();
        }
      }
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
