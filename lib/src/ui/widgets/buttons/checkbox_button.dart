import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckBoxOption extends ConsumerStatefulWidget {
  final String label;
  final bool currentValue;
  final Function? callback;
 const  CheckBoxOption({required this.label,required  this.currentValue, this.callback,super.key});

  @override
  ConsumerState<CheckBoxOption> createState() => _CheckBoxOptionState();
}

  class _CheckBoxOptionState extends ConsumerState<CheckBoxOption>{
    bool checkStatus = true;

    @override
  void didUpdateWidget(covariant CheckBoxOption oldWidget) {
    if(oldWidget.currentValue != widget.currentValue){
      setState(() {
        checkStatus = widget.currentValue;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    checkStatus = widget.currentValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return  SizedBox(
    width: MediaQuery
        .of(context)
        .size
        .width,
    height: 40,
    child: Row(
      children: [
        Expanded(child: Text(widget.label,maxLines: 1,),
        ),
        const SizedBox(width: 10,),
        GestureDetector(
          onTap: (){
            setState(() {
              checkStatus = !checkStatus;
             _callback(checkStatus);
            });
          },
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.grey,
                ),
                color: checkStatus ? AppColors.primary : null
            ),
          ),
        )
      ],
    ),
  );
  }

  _callback(value){
      if(widget.callback!=null){
        widget.callback!(value);
      }
  }
  }

