import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/config/notes_provider.dart';
import 'package:noteme/src/models/note_model.dart';
import 'package:noteme/src/utils/dialog_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoteView extends ConsumerStatefulWidget {
  final NoteClass? note;
  final int? folderId;
 const NoteView({this.note,this.folderId,super.key});

  @override
  ConsumerState<NoteView> createState() => _NoteViewState();
}

  class _NoteViewState extends ConsumerState<NoteView>{
  late NoteClass? currentNote;
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  Timer? updateTimer;

  late bool _editingTitle = widget.note!=null ? false : true;

  @override
  void initState() {
    initNote();
    _titleController.addListener(() {setState(() {
print("cambio de title");
    });});
    _noteController.addListener(() {setState(() {

    });});
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return GestureDetector(
    onTap: (){
      FocusScope.of(context).focusedChild?.unfocus();
    },
    child: Scaffold(
      appBar: _appBar(),
      body:  _content(),
    ),
  );
  }
  AppBar _appBar(){
    return AppBar(
      title: SizedBox(
        width: double.infinity,
        height: 40,
        child: Row(
          children: [
            _changeColor(),
         const SizedBox(width: 10,),
          _addTitle(),
          ],
        ),
      ),
      leading: _editingTitle && widget.note!=null ? Container() : IconButton(
        padding: EdgeInsets.zero,
        onPressed: (){
         dialogSaveNote();
        },
        icon: const Icon(Icons.chevron_left, size: 30,),
      ),
      leadingWidth: 20,
      elevation: 4,
      actions: [
       widget.note==null ? _saveNote(ref) : _editTitle()
      ],
    );
  }

  _editTitle(){
    return IconButton(onPressed: (){
      setState(() {
        if(_editingTitle){
          _manageNewTitle();
          _updateNote();
        }
        _editingTitle = !_editingTitle;
      });
    }, icon: Icon(_editingTitle ? Icons.save : Icons.edit));
  }

  dialogSaveNote() {
    if (_checkIfEmpty()) {
      dialogDeleteNote(context);
    }else{
      GoRouter.of(context).pop();
    }
  }

  Widget _content(){
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: const ClampingScrollPhysics(),
      child:
      Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            //TODO: add background/color decoration
          ),
          child: TextFormField(
            onTap: (){

            },
            onChanged: (value){
             _manageNewTitle();
              if(widget.note!=null){
                _updateNote();
              }
            },
            controller: _noteController,
            maxLines: null,
            decoration: const InputDecoration(
              focusedBorder: InputBorder.none
            ),
          )),
    );
  }

  ///TextForm for note title
  ///if empty, New Note
  Widget _addTitle(){
    return Expanded(
      child: Container(
        // height: 40,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: TextFormField(
          controller: _titleController,
          enabled: _editingTitle,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 0,bottom: 0,left: 10),
            fillColor: AppColors.secondaryDark,
            filled: true,
          ),
        ),
      ),
    );
  }

  ///Changes Color of note
  Widget _changeColor(){
    return Container(
      width: 30,
      height: 30,
      color: AppColors.noDarkColor,
    );
  }

  ///FUNCTIONS
   initNote(){
    if(widget.note!=null){
      currentNote = widget.note;
      _titleController.text = currentNote?.title ?? "";
      _noteController.text = currentNote?.content ?? "";
    }
  }

  _manageNewTitle(){
    if(_titleController.text.isEmpty&&_noteController.text.trim().length>5){
      ///Adds a default title if empty
      _titleController.text = _noteController.text.trim().substring(0,_noteController.text.trim().length > 5 ? 5 : _noteController.text.trim().length) + "...";
    }
  }


  _saveNote(WidgetRef ref){
    return IconButton(onPressed: ()async {
      if(!_checkIfEmpty()){
        NoteClass newNote = NoteClass(title: _titleController.text, content: _noteController.text, creationTime: DateTime.now());
        try {
          if(widget.note!=null){
            print("update note");

          }else {
            await ref.read(listProvider.notifier).add(newNote);
            GoRouter.of(context).go(routes.mainHolder);
          }
        }catch(e,s){

    print(e);
    print(s);
        }
        }else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Debes añadir almenos un título")));
        // GoRouter.of(context).go(routes.mainHolder);
      }
    }, icon: const Icon(Icons.save));
  }

  _updateNote(){
      if(updateTimer?.isActive ?? false){
       updateTimer!.cancel();
      }
      updateTimer = Timer(const Duration(milliseconds: 500),(){
        widget.note!.updateNote(_titleController.text, _noteController.text);
        print("se gestriona el update");
        print(widget.note);
        ref.read(listProvider.notifier).update(widget.note);
      });
    }

  bool _checkIfEmpty(){
      print(_titleController.text);
    if(_titleController.text.isEmpty){
      return true;
    }
    return false;
  }



  }