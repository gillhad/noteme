import 'dart:async';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/api/database.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/config/notes_provider.dart';
import 'package:noteme/src/models/note_model.dart';

class NoteView extends ConsumerStatefulWidget {
  final NoteClass? note;
  final int? folderId;
 const NoteView({this.note,this.folderId,super.key});

  @override
  ConsumerState<NoteView> createState() => _NoteViewState();
}

  class _NoteViewState extends ConsumerState<NoteView>{
  late NoteClass? currentNote;
  var _titleController = TextEditingController();
  var _noteController = TextEditingController();

  Timer? updateTimer;


  @override
  void initState() {
    initNote();
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
    child: Scaffold(
      appBar: _appBar(),
      body:  _content(),
    ),
  );
  }
  AppBar _appBar(){
    return AppBar(
      title: Container(
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
      leading: IconButton(
        padding: EdgeInsets.zero,
        onPressed: (){
          GoRouter.of(context).pop();
        },
        icon: Icon(Icons.chevron_left, size: 30,),
      ),
      leadingWidth: 20,
      elevation: 4,
      actions: [
        _saveNote(ref)
      ],
    );
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
              print("tap en el notecontroller");
              print("_noteController.selection.base.offset");
            },
            onChanged: (value){
              //TODO: guardar la nota cada X tiempo si se hacen cambios
              print("_noteController.selection.base.offset");
              print(widget.note);
              if(widget.note!=null){
                print("update");
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
    print(widget.note);
    if(widget.note!=null){
      currentNote = widget.note;
      print(currentNote!.content);
      print(currentNote!.title);
      _titleController.text = currentNote?.title ?? "";
      _noteController.text = currentNote?.content ?? "";
    }
  }

  ///Shows done/edit option
  _saveNote(WidgetRef ref){
    return IconButton(onPressed: ()async {
      if(_checkIfEmpty()){
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Debes añadir almenos un título")));
        // GoRouter.of(context).go(routes.mainHolder);
      }
    }, icon: widget.note !=null ? const Icon(Icons.edit) : const Icon(Icons.save));
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
    if(_titleController.text.isNotEmpty){
      return true;
    }
    return false;
  }

  _updatNote(){

  }

  }