import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:noteme/src/config/app_styles.dart';
import 'package:noteme/src/config/providers.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/models/note_model.dart';
import 'package:noteme/src/ui/widgets/notes_views/simple_folder.dart';
import 'package:noteme/src/ui/widgets/notes_views/simple_note.dart';
import 'package:noteme/src/utils/helpers/user_helper.dart';

import '../../../models/user.dart';



class Home extends ConsumerStatefulWidget {
 const  Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

  class _HomeState extends ConsumerState<Home>{
  NoteClass exampleNote = NoteClass(id: 0, title: "title");
  Folders folder = Folders("title");

  List<dynamic> itemsList = [];

@override
  void initState() {
    itemsList = [exampleNote,exampleNote,folder,exampleNote];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool simpleMode = ref.watch(userState)!.simpleMode;
    // print("hay cambios");
    return Scaffold(
      appBar: _appBar(context),
      body: _content(context),
      drawer: _drawer(context),
      floatingActionButton: _addNote(context),
    );
  }

  AppBar _appBar(context) {
    return AppBar(
      title: Text(AL.of(context).main_title),
      elevation: 2,
      actions: const [
        Icon(Icons.search),
        Icon(Icons.filter),
        Icon(Icons.more_vert),
      ],
    );
  }

  Widget _content(context) {
  // bool changeMode = ref.watch(userState)!.simpleMode;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => showItem(context,ref,index),
          separatorBuilder: (context, index) => Container(
                height: 5,
              ),
          itemCount: itemsList.length),
    );
  }

  Widget _drawer(context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 5,
      child: _drawerItems(context,ref),
    );
  }

  Widget _drawerItems(context,ref) {
    return Column(
      children: [
        Container(
          height: 100,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.all_inbox,
              color: AppColors.grey,
              size: MediaQuery.of(context).size.width / 7,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.folder,
              color: AppColors.grey,
              size: MediaQuery.of(context).size.width / 7,
            )),
      ],
    );
  }

  Widget _addNote(context) {
    return FloatingActionButton(
      onPressed: () {
        ///TODO: Create new note
        UserHelper.user!.simpleMode = !UserHelper.user!.simpleMode;

        setState(() {

        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("añadir nota")));
      },
      child: Icon(
        Icons.add,
        color: AppColors.onPrimary,
        size: 38,
      ),
    );
  }

  showItem(context,WidgetRef ref,index){
  ref.watch(userState);
  print("repitnar");
    if(itemsList[index] is NoteClass) {
      return noteItem(context, itemsList[index], ref);
    }else{
      return folderItem(context, itemsList[index], ref);
    }
  }


}
