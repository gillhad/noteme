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
    //TODO: set draweer pos from settings
    initList();
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(context),
      body: _content(context),
      drawer: _drawer(context),
      floatingActionButton: _keyboard ? null : _addNew(context),
    );
  }

  updateShowList() {
    if(showList.isEmpty){
      showList.addAll(ref.watch(listProvider));
    }
    ref.listen(listProvider, (previous, next) {
      print("cambios en la lista");
      print(previous);
      print(next);
      showList.clear();
      showList.addAll(next);
      print(showList.length);
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

        ///TODO: add filters
        // Icon(Icons.filter),
        ///TODO: Add extra option
        IconButton(
            onPressed: () async {
              _reloadList();
            },
            icon: Icon(Icons.more_vert)),
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
              setState(() {
                _drawerPos = 0;
                _drawerOptions();
              });
            },
            icon: Icon(
              Icons.all_inbox,
              color: AppColors.grey,
              size: MediaQuery.of(context).size.width / 7,
            )),
        IconButton(
            onPressed: () {
              setState(() {
                _drawerPos = 1;
                _drawerOptions();
              });
            },
            icon: Icon(
              Icons.folder,
              color: AppColors.grey,
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
          Future.delayed(Duration(milliseconds: 200));
          setState(() {
            print("tap");
          });
        },
        onChanged: (value) {
          _searchItems(value);
        },
        decoration: InputDecoration(
          //TODO: check cursor color
          fillColor: AppColors.secondaryDark,
          filled: true,
          icon: const Icon(Icons.search),
          suffixIcon:
              IconButton(onPressed: _clearText, icon: const Icon(Icons.close)),
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
        print("ref.watch(listProvider)");
        print(ref.watch(listProvider));
        _folderTitleController.clear();
        setState(() {

        });
        GoRouter.of(context).pop();
      }catch(e){

      }


        });
  }

  ///FUNCTIONS

  initList() async {
    print("init");
    try {
      //TODO: read db and create first list
      // await addExampleItems();
      if (itemsList.isEmpty) {
        // await ref.read(itemsRepository).addNote(NoteClass(title: "nueva", content: "content", creationTime: DateTime.now()));
      } else {
        _reloadList();
      }
      // print("ordeno la nota");
      // ref.read(listProvider.notifier).sort();
      showList.clear();
      showList.addAll(itemsList);
      setState(() {});
    }catch(e){
      print(e);
    }
  }

  _reloadList() async {
    // var response = await DataBaseHelper.getAll();
    // response.forEach((item){
    //   if(!itemsList.contains(item)){
    //     itemsList.add(item);
    //   }
    // });
    showList.clear();
    print("tenemos items en la lista ${itemsList.length}");
    showList.addAll(itemsList);
  }

  showItem(context, WidgetRef ref, index) {
    // print(showList[0].toString());
    // print(showList[0].runtimeType);
    // print(showList[0] is NoteClass);
    // print(showList.length);
    ref.watch(userState);
    if (showList[index] is NoteClass) {
      return noteItem(context, showList[index], ref);
    } else if (showList[index] is Folders) {
      print(showList[index]);
      return folderItem(context, showList[index], _openFolder, ref);
    } else {
      print(showList[index]);
      print("cagada");
      return Container();
    }
  }

  _clearText() {
    setState(() {
      _searchController.clear();
    });
    showList.addAll(itemsList);
  }

  _openFolder(folder) {
    GoRouter.of(context).pushNamed(routes.folderView,extra: folder);
  }

  _searchItems(searchString) {
    print(searchString);
    showList.clear();
    if (_searchTimer?.isActive ?? false) {
      _searchTimer!.cancel();
    }
    _searchTimer = Timer(const Duration(milliseconds: 500), () {
      for (var item in ref.watch(listProvider)) {
        if (item is NoteClass) {
          if (item.title.contains(searchString) ||
              item.content.contains(searchString)) {
            showList.add(item);
          }
        } else {
          if (item.title.contains(searchString)) {
            showList.add(item);
          }
        }
      }
    });
  }

  _drawerOptions() {
    print("clear");
    showList.clear();
    switch (_drawerPos) {
      case 0:
        initList();
        // _currentFolder = null;
      case 1:
        showList.addAll(itemsList.where((element) => element is Folders));
        setState(() {
          // _currentFolder = null;
        });
    }
  }
}
