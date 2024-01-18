

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/ui/widgets/dialogs/dialog_folder.dart';
import 'package:noteme/src/utils/dialog_manager.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_styles.dart';
import '../../../config/globals.dart';
import '../../../config/providers.dart';
import '../../../models/user.dart';

Widget folderItem(context,Folders folder,Function openFolder,WidgetRef ref){
    User? user =  ref.watch(userState);
    return GestureDetector(
      onTap: (){
        openFolder(folder);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: user!.settings.simpleMode ? 60 : 60,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: user.settings.simpleMode ? 0 : 10 ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.noDarkColor)
        ),
        child: Row(
          crossAxisAlignment: !user.settings.simpleMode ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            if(folder.pinned) const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.push_pin_outlined)),
            const Padding(
                padding:  EdgeInsets.all(5),
                child:  Icon(Icons.folder)),
            const SizedBox(width: 10,),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      folder.title,
                      maxLines: 1,
                      // note.title,
                      style: textTheme.headlineSmall,),
                    //TODO: in search mode show amount of notes matching the result or notes with the results
                    // if(!user.settings.simpleMode)Flexible(child: Column(
                    //   children: [
                    //
                    //   ],
                    // ))
                  ],
                ),
              ),
            ),
            const Spacer(flex: 1,),
            Flexible(
              child: IconButton(onPressed: ()async{
                await folderOptionsDialog(context, ref, folder);
              }, icon: const Icon(Icons.more_vert)),
            )
          ],
        ),
      ),
    );

}
    manageFolder()async{

    }
