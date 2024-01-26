import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:noteme/src/api/database.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:noteme/src/config/app_styles.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/config/notes_provider.dart';
import 'package:noteme/src/config/providers.dart';
import 'package:noteme/src/models/arguments.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/models/note_model.dart';
import 'package:noteme/src/utils/dialog_manager.dart';
import 'package:noteme/src/ui/widgets/notes_views/simple_folder.dart';
import 'package:noteme/src/ui/widgets/notes_views/simple_note.dart';
import 'package:noteme/src/utils/helpers/database_helper.dart';
import 'package:noteme/src/utils/helpers/user_helper.dart';

import '../../../models/user.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with WidgetsBindingObserver {
  var _searchController = TextEditingController();
  var _folderTitleController = TextEditingController();


  List<dynamic> itemsList = [];
  List<dynamic> showList = [];

  Timer? _searchTimer;

  int _drawerPos = 0;

  bool _isSearching = false;
  bool _keyboard = false;


  @override
  void initState() {
    //TODO: set drawer pos from settings
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _folderTitleController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if(mounted) {
      if (MediaQuery
          .of(Scaffold
          .of(context)
          .context)
          .viewInsets
          .bottom > 0) {
        setState(() {
          _keyboard = true;
        });
      } else {
        setState(() {
          _keyboard = false;
        });
      }
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
   updateShowList();
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).focusedChild?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _appBar(context),
        body: _content(context),
        drawer: _drawer(context),
        floatingActionButton: _keyboard ? null : _addNew(context),
      ),
    );
  }

  updateShowList() {
    if(showList.isEmpty){
      showList.addAll(ref.watch(listProvider));
    }
    ref.listen(listProvider, (previous, next) {
      showList.clear();

      showList.addAll(next);
      setState(() {});
    });
    // print("repintamos las funciones");

  }

  AppBar _appBar(context) {
    return AppBar(
      title: Text(AL.of(context).main_title),
      elevation: 2,
      actions: [
        ///search notes by text
        IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
            icon: Icon(Icons.search)),
        ///TODO: add filters by tag?
        // Icon(Icons.filter),
        ///TODO: Add extra option?
        // IconButton(
        //     onPressed: () async {
        //     },
        //     icon: Icon(Icons.more_vert)),
      ],
    );
  }

  Widget _content(context) {
    // bool changeMode = ref.watch(userState)!.simpleMode;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          if (_isSearching) _searchBar(),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => showItem(context, ref, index),
              separatorBuilder: (context, index) => Container(
                    height: 5,
                  ),
              itemCount: showList.length),
        ],
      ),
    );
  }

  Widget _drawer(context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 5,
      child: _drawerItems(context, ref),
    );
  }

  Widget _drawerItems(context, ref) {
    return Column(
      children: [
        Container(
          height: 100,
        ),
        IconButton(
            onPressed: () {
              FocusScope.of(context).focusedChild?.unfocus();
              setState(() {
                _drawerPos = 0;
                _drawerOptions();
              });
            },
          color: _drawerPos == 0 ? null :AppColors.redNote.withOpacity(0.2),
            icon: Icon(
              Icons.all_inbox,
              // color: AppColors.grey,
              size: MediaQuery.of(context).size.width / 7,
            )),
        IconButton(
            onPressed: () {
              FocusScope.of(context).focusedChild?.unfocus();
              setState(() {
                _drawerPos = 1;
                _drawerOptions();
              });
            },
            icon: Icon(
              Icons.folder,
              color: _drawerPos == 1 ? null : AppColors.redNote.withOpacity(0.2),
              size: MediaQuery.of(context).size.width / 7,
            )),
      ],
    );
  }

  Widget _drawerFolder() {
    return IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.folder_copy_outlined,
          color: AppColors.grey,
          size: MediaQuery.of(context).size.width / 7,
        ));
  }

  Widget _addNew(context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: AppColors.secondaryDark,
          borderRadius: BorderRadius.circular(10)),
      child: PopupMenuButton(
        onOpened: () {
          // setState(() {
          //
          // });
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        offset: const Offset(0, -120),
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () {
              GoRouter.of(context).push(routes.noteView);
            },
            child: Text(AL.of(context).home_add_new_note),
          ),
          //TODO: show dialog to create new folder

            PopupMenuItem(
              onTap: () {
                addFolderDialog();
              },
              child: Text(AL.of(context).home_add_new_folder),
            ),
        ],
        child: Icon(
          Icons.add,
          color: AppColors.onPrimary,
          size: 38,
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      height: 50,
      child: TextFormField(
        controller: _searchController,
        onTap: () {
          Future.delayed(const Duration(milliseconds: 200));
          setState(() {
          });
        },
        onChanged: (value) {
          _searchItems(value);
        },
        decoration: InputDecoration(
          //TODO: check cursor color
          fillColor: AppColors.secondaryDark,
          filled: true,
            hintText: AL.of(context).home_search_hint,
        ),
      ),
    );
  }

  addFolderDialog() {
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
        await ref.read(listProvider.notifier).add(newFolder);
        _folderTitleController.clear();
        setState(() {

        });
        GoRouter.of(context).pop();
      }catch(e){

      }


        });
  }

  ///FUNCTIONS


  showItem(context, WidgetRef ref, index) {
    if (showList[index] is NoteClass) {
      if(_drawerPos == 1){
        return Container();
      }
      return noteItem(context, showList[index], ref, _openNote);
    } else if (showList[index] is Folders) {
      return folderItem(context, showList[index], _openFolder, ref);
    } else {
      return Container();
    }
  }


  _openFolder(folder) {
    setState(() {
      _isSearching = false;
    });
    GoRouter.of(context).push(routes.folderView,extra: folder);
  }

  _openNote(note){
    // setState(() {
      _isSearching = false;
    // });
    GoRouter.of(context).push(routes.noteView,extra: note);
  }

  _searchItems(searchString) {
    // showList.clear();
    if (_searchTimer?.isActive ?? false) {
      _searchTimer!.cancel();
    }
    _searchTimer = Timer(const Duration(milliseconds: 500), () {
      ref.read(listProvider.notifier).getSearch(searchString);
    });
    setState(() {

    });
  }

  _drawerOptions() {
    switch (_drawerPos) {
      case 0:
      case 1:
    }
  }
}
