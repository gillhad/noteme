import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:noteme/src/config/app_styles.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/config/providers.dart';
import 'package:noteme/src/models/arguments.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/models/note_model.dart';
import 'package:noteme/src/ui/widgets/notes_views/simple_folder.dart';
import 'package:noteme/src/ui/widgets/notes_views/simple_note.dart';
import 'package:noteme/src/utils/helpers/user_helper.dart';

import '../../../models/user.dart';

class Home extends ConsumerStatefulWidget {

  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> with WidgetsBindingObserver {
  var _searchController = TextEditingController();

  NoteClass exampleNote = NoteClass(id: 0, title: "title", content: "");
  Folders folder = Folders(title: "folder",notes: [NoteClass(id: 1,title: "Dentro del folder",content: "Con texto")]);

  Folders? _currentFolder;

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
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (MediaQuery.of(Scaffold.of(context).context).viewInsets.bottom > 0) {
      setState(() {
        _keyboard = true;
      });
    } else {
      setState(() {
        _keyboard = false;
      });
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    // bool simpleMode = ref.watch(userState)!.simpleMode;
    // print("hay cambios");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _appBar(context),
      body: _content(context),
      drawer: _drawer(context),
      floatingActionButton: _keyboard ? null : _addNew(context),
    );
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
        Icon(Icons.more_vert),
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
        if (_currentFolder != null) _drawerFolder()
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
          print("on open");
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
          //TODO: send to noteview
          PopupMenuItem(
            onTap: () {
              GoRouter.of(context).push(routes.noteView,extra: NoteViewArguments(folderId: _currentFolder?.id));
            },
            child: Text(AL.of(context).home_add_new_note),
          ),
          //TODO: show dialog to create new folder
          if(_currentFolder==null) PopupMenuItem(
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

  ///FUNCTIONS

  initList() {
    //TODO: read db and create first list
    if (itemsList.isEmpty) {
      itemsList = [exampleNote, exampleNote, folder, exampleNote];
    }
    showList.addAll(itemsList);
    setState(() {});
  }

  showItem(context, WidgetRef ref, index) {
    ref.watch(userState);
    if (showList[index] is NoteClass) {
      return noteItem(context, showList[index], ref);
    } else {
      return folderItem(context, showList[index],_openFolder, ref);
    }
  }

  _clearText() {
    setState(() {
      _searchController.clear();
    });
    showList.addAll(itemsList);
  }

  _openFolder(folder){
    setState(() {
    _currentFolder = folder;
    showList.clear();
    showList.addAll(_currentFolder!.notes);
    });
  }

  _searchItems(searchString) {
    print(searchString);
    showList.clear();
    if (_searchTimer?.isActive ?? false) {
      _searchTimer!.cancel();
    }
    _searchTimer = Timer(const Duration(milliseconds: 500), () {

      for (var item in itemsList) {
        if (item is NoteClass) {
          print(item.title);
          print(item.content);
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
      print(showList);
      setState(() {});
    });
  }

  _drawerOptions() {
    print("clear");
    showList.clear();
    switch (_drawerPos) {
      case 0:
        initList();
        _currentFolder = null;
      case 1:
        showList.addAll(itemsList.where((element) => element is Folders));
        setState(() {
          _currentFolder = null;
        });
    }
  }
}
