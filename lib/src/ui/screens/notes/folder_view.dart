import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/config/notes_provider.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/ui/widgets/notes_views/simple_note.dart';

class FolderView extends ConsumerStatefulWidget {
final  Folders folder;
 const  FolderView({required this.folder,super.key});

  @override
  ConsumerState<FolderView> createState() => _FolderViewState();
}

  class _FolderViewState extends ConsumerState<FolderView> {
  final _titleController = TextEditingController();
  bool _editTitle = false;

  @override
  void initState() {
    _titleController.text = widget.folder.title;
    _titleController.addListener(() { });
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: _appBar(),
        body: _content(),
      );
    }

    AppBar _appBar() {
      return AppBar(
        title: _editTitle ? titleManage() : Text(widget.folder.title),
        actions: [IconButton(onPressed: ()async{
            if(_editTitle){
              await updateFolder(ref);
            }
          setState(() {
            _editTitle = !_editTitle;
          });
        }, icon: Icon(_editTitle ? Icons.save:   Icons.edit))],
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(Icons.chevron_left),
        ),
      );
    }

    titleManage(){
    return TextFormField(
      controller: _titleController,
    );
    }

    Widget _content() {
      ref.listen(listProvider, (previous, next) {
        updateNotes();
      });
      return ListView.builder(
          itemCount: widget.folder.notes.length,
          itemBuilder: (context, index) =>
              noteItem(context, widget.folder.notes[index], ref,_openNote ));
    }

  _openNote(note){
    GoRouter.of(context).push(routes.noteView,extra: note);
  }
    updateNotes() async {
      await widget.folder.updateNotes();
      setState(() {});
    }

    updateFolder(WidgetRef ref)async{
    if(_titleController.text.trim().isEmpty){
      return;
    }
      widget.folder.title = _titleController.text;
      await ref.read(listProvider.notifier).update(widget.folder);

    }
  }