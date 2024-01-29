import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:noteme/src/config/notes_provider.dart';
import 'package:noteme/src/models/note_model.dart';


Future colorSelector(context, item)async{
  var response = await showDialog(context: context , builder: (context){
  return ColorSelector(item: item,);
  });
return response;


}



class ColorSelector extends ConsumerStatefulWidget {
  final dynamic item;
 const  ColorSelector({this.item,super.key});

  @override
  ConsumerState<ColorSelector> createState() => _ColorSelectorState();
}

  class _ColorSelectorState extends ConsumerState<ColorSelector>{
  List<Color> colors = [AppColors.redNote,AppColors.blueNote,AppColors.orangeNote,AppColors.purpleNote,AppColors.yellowNote,AppColors.brownDarkNote];
  late Color? _selectedColor = widget.item?.color;
  @override
  Widget build(BuildContext context) {
  return  Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
    ),
      child: Padding(
        padding: const EdgeInsets.only(left: 17,right: 17, top: 20,bottom: 0),
        child: SizedBox(
          width: 100,
          height: 170,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for(var color in colors) _colorItem(color)
                ],
              ),
            _buttons()
            ],
          ),
        ),
      ),
  );
  }

  _colorItem(color){
    return GestureDetector(
      onTap: (){
        setState(() {
        _selectedColor = color;
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: _selectedColor == color ? Colors.white : color),
          color: color
        ),
      ),
    );
  }

  _buttons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: onCancel, child: Text(AL.of(context).cancel)),
        TextButton(onPressed: onAccept, child: Text(AL.of(context).accept)),
      ],
    );
  }

  onAccept() {
    if(widget.item!=null) {
      widget.item.color = _selectedColor;
      ref.read(listProvider.notifier).update(widget.item);
      GoRouter.of(context).pop();
    }else{
    GoRouter.of(context).pop(_selectedColor);
    }
  }

onCancel(){
GoRouter.of(context).pop();
}
  }