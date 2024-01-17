import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/ui/widgets/notes_views/simple_note.dart';

class FolderView extends ConsumerStatefulWidget {
final  Folders folder;
 const  FolderView({required this.folder,super.key});

  @override
  ConsumerState<FolderView> createState() => _FolderViewState();
}

  class _FolderViewState extends ConsumerState<FolderView>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: _appBar(),
    body:  _content(),
  );
  }

  AppBar _appBar(){
    return AppBar();
  }

  Widget _content(){
    return ListView.builder(
        itemCount: widget.folder.notes!.length,
        itemBuilder: (context, index) => noteItem(context, widget.folder.notes![index], ref));
  }

  }