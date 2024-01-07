import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteme/src/models/note_model.dart';

class NoteView extends ConsumerStatefulWidget {
  final NoteClass? note;
 const NoteView({this.note,super.key});

  @override
  ConsumerState<NoteView> createState() => _NoteViewState();
}

  class _NoteViewState extends ConsumerState<NoteView>{

  var _titleController = TextEditingController();
  var _noteController = TextEditingController();

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
      title: _addTitle(),
      leading: Container(),
      leadingWidth: 0,
      elevation: 4,
      actions: [
        _saveNote()
      ],
    );
  }

  Widget _content(){
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      physics: const ClampingScrollPhysics(),
      child:
      SizedBox(
          height: MediaQuery.of(context).size.height,
          child: TextFormField(
            maxLines: null,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none
            ),
          )),
    );
  }

  ///TextForm for note title
  ///if empty, New Note
  _addTitle(){
    return Container(
      child: TextFormField(),
    );
  }

  ///Shows done/edit option
  _saveNote(){
    return IconButton(onPressed: (){

    }, icon: Icon(Icons.save));
  }
  }