import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:noteme/src/config/app_styles.dart';


final List<int> minutes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59];
final List<int> hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23];
final List<String> monthAbbr = [DateFormat('MMM').format(DateTime.utc(0,1)),DateFormat('MMM').format(DateTime.utc(0,2)),DateFormat('MMM').format(DateTime.utc(0,3)),DateFormat('MMM').format(DateTime.utc(0,4)),DateFormat('MMM').format(DateTime.utc(0,5)),DateFormat('MMM').format(DateTime.utc(0,6)),DateFormat('MMM').format(DateTime.utc(0,7)),DateFormat('MMM').format(DateTime.utc(0,8)),DateFormat('MMM').format(DateTime.utc(0,9)),DateFormat('MMM').format(DateTime.utc(0,10)),DateFormat('MMM').format(DateTime.utc(0,11)),DateFormat('MMM').format(DateTime.utc(0,12))];
final List<String> monthFull = [DateFormat('MMMM').format(DateTime.utc(0,1)),DateFormat('MMMM').format(DateTime.utc(0,2)),DateFormat('MMMM').format(DateTime.utc(0,3)),DateFormat('MMMM').format(DateTime.utc(0,4)),DateFormat('MMMM').format(DateTime.utc(0,5)),DateFormat('MMMM').format(DateTime.utc(0,6)),DateFormat('MMMM').format(DateTime.utc(0,7)),DateFormat('MMMM').format(DateTime.utc(0,8)),DateFormat('MMMM').format(DateTime.utc(0,9)),DateFormat('MMMM').format(DateTime.utc(0,10)),DateFormat('MMMM').format(DateTime.utc(0,11)),DateFormat('MMMM').format(DateTime.utc(0,12))];
final List<int> monthNumber = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
final List<int> years = List.generate(10, (index) => DateTime.now().year+index);

const double _kHourMinuteHeight = 25;
const double _timeOffset = TimeOfDay.minutesPerHour*10;
const double _dayOffset = 23;

enum MonthType{
  number,
  abbr,
  full
}

List<dynamic> getMonthList(MonthType? type){
  switch(type){
    case MonthType.number:
      return monthNumber;
    case MonthType.abbr:
      return monthAbbr;
    case MonthType.full:
      return monthFull;
    default: return monthNumber;
  }
}


Future showCustomDateTimePicker(context,
    {DateTime? initialDate,
    MonthType? monthType = MonthType.abbr})
async {
  initialDate = initialDate ?? DateTime.now();
  monthType = monthType ;
  return showDialog(
      context: context,
      builder: (context) {
        return DateTimeCustomPicker(initialDate: initialDate,
          monthType: monthType,);
      });
}

class DateTimeCustomPicker extends StatefulWidget {
const DateTimeCustomPicker(
      {super.key, this.initialDate,
        this.monthType,
        this.restorationId});

  final DateTime? initialDate;
  final String? restorationId;
  final MonthType? monthType;

  @override
  State<DateTimeCustomPicker> createState() => _DateTimeCustomPickerState();
}

class _DateTimeCustomPickerState extends State<DateTimeCustomPicker>{
  late DateTime _selectTime =
      widget.initialDate ?? DateTime.now();
  late final MonthType _monthType = widget.monthType!;

  final Size dialogSize = const Size(300, 200);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(left: 25,right: 25, top: 20,bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AL.of(context).dialog_add_reminder, style: textTheme.bodyLarge,),
            const SizedBox(height: 15,),
            DateCustomPicker(
              currentTime: _selectTime,
              monthType: _monthType,
              handleTime: getCurrentDate,
            ),
            TimeCustomPicker(
              currentTime: _selectTime,
              handleTime: getCurrentTime,
            ),
            actions(),
          ],
        ),
      ),
    );
  }

  getCurrentDate(DateTime value) {
    setState(() {
      _selectTime = _selectTime.copyWith(year: value.year,month: value.month, day: value.day);
    });
      print("actualizamos el día $_selectTime");
  }

  getCurrentTime(DateTime value) {
    setState(() {
      _selectTime =  _selectTime.copyWith(hour: value.hour,minute: value.minute);
      print("actualizamos al hora $_selectTime");
    });
  }

  actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: actionCancel,
            child: Text(AL.of(context).cancel)),
        TextButton(
          onPressed:actionConfirm,
          child: Text(AL.of(context).accept),
        ),
      ],
    );
  }

  actionCancel(){
    GoRouter.of(context).pop();
  }

  actionConfirm(){
    print("Añades un recordatiorio el día y la hora: $_selectTime");
    GoRouter.of(context).pop(_selectTime);
    //TODO: update reminder on databse and create notification
  }

}

class DateCustomPicker extends StatefulWidget {
  const DateCustomPicker({required this.currentTime,
    required this.handleTime,
    required  this.monthType,
    super.key});
  final MonthType monthType;
  final DateTime currentTime;
  final Function handleTime;

  @override
  State<DateCustomPicker> createState() => _DateCustomPickerState();
}

class _DateCustomPickerState extends State<DateCustomPicker> {
  late DateTime _currentTime = widget.currentTime;

  final _yearScrollController = ScrollController();
  final _monthScrollController = ScrollController();
  final _dayScrollController = ScrollController();

   Timer? _dayTimer;
   Timer? _monthTimer;
   Timer? _yearTimer;

   final int _dayVariation = -1;

  @override
  void didUpdateWidget(covariant DateCustomPicker oldWidget) {
    if(oldWidget.currentTime!=widget.currentTime){
      setState(() {
        _currentTime = widget.currentTime;
        defaultPosition(_dayScrollController, _currentTime.day,(_getMonthLength()+_dayVariation));
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    print("me devuelve ${widget.monthType}");
    defaultPosition(_dayScrollController, _currentTime.day,(_getMonthLength()+_dayVariation));
    defaultPosition(_monthScrollController, _currentTime.month,11);
    super.initState();
  }

 int _getMonthLength(){
    return DateTime(_currentTime.year, _currentTime.month + 1, 0).day;

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            inputItem(AL.of(context).day,_currentTime.day,List.generate(_getMonthLength(), (index) => index+1),_dayScrollController,returnToPositionDay ),
            const SizedBox(width: 13,),
            inputItem(AL.of(context).month,_currentTime.month,getMonthList(widget.monthType),_monthScrollController,returnToPositionMonth, showMonth: widget.monthType == MonthType.full),
            const SizedBox(width: 13,),
            inputItem(AL.of(context).year, _currentTime.year,years,_yearScrollController,returnToPositionYear),
          ],
        ),
      );
    });
  }


  returnToPositionDay() async {
    if (_dayTimer?.isActive ?? false) {
      _dayTimer!.cancel();
    }
    _dayTimer = Timer(const Duration(milliseconds: 100), () {
      var currentPos = _dayScrollController.position.pixels / 25;
      _dayScrollController.jumpTo(currentPos.round() * 25.0);
      widget.handleTime(_currentTime.copyWith(day: (currentPos%_getMonthLength()).round().toInt()+1));
    });
  }

  returnToPositionMonth() async {
    if (_monthTimer?.isActive ?? false) {
      _monthTimer!.cancel();
    }
    _monthTimer = Timer(const Duration(milliseconds: 100), () {
      var currentPos = _monthScrollController.position.pixels / 25;
      _monthScrollController.jumpTo(currentPos.round() * 25.0);
      widget.handleTime(_currentTime.copyWith(month: ((currentPos%12)).round().toInt()+1));
    });
  }
  returnToPositionYear() async {
    if (_yearTimer?.isActive ?? false) {
      _yearTimer!.cancel();
    }
    _yearTimer = Timer(const Duration(milliseconds: 100), () {
      var currentPos = _yearScrollController.position.pixels / 25;
      _yearScrollController.jumpTo(currentPos.round() * 25.0);
      widget.handleTime(_currentTime.copyWith(year: DateTime.now().year+currentPos.round().toInt()));
    });
  }

}

class TimeCustomPicker extends StatefulWidget {
  const TimeCustomPicker({required this.currentTime,required this.handleTime,this.restorationId ,super.key});
  final DateTime currentTime;
  final String? restorationId;
  final Function handleTime;

  @override
  State<TimeCustomPicker> createState() => _TimeCustomPickerState();
}

class _TimeCustomPickerState extends State<TimeCustomPicker> {
  final _minScrollController = ScrollController();
  final _hourScrollController = ScrollController();
  Timer? _minTimer;
  Timer? _hourTimer;


  late DateTime _currentTime = widget.currentTime;

  @override
  void initState() {
    ///Set start position for minutes
    defaultPosition(_minScrollController, _currentTime.minute, _timeOffset);
    ///Set start position for hours
    defaultPosition(_hourScrollController, _currentTime.hour,_timeOffset);
    super.initState();
  }

  @override
  void dispose() {
    _minScrollController.dispose();
    _hourScrollController.dispose();
    _minTimer?.cancel();
    _hourTimer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TimeCustomPicker oldWidget) {
    if(oldWidget.currentTime!=widget.currentTime){
      setState(() {
      _currentTime = widget.currentTime;

      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            inputItem(AL.of(context).hour, _currentTime.hour, hours,
                _hourScrollController, returnToPositionHour),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.only(bottom: 20),
              child: const Text(
                ":",
                style: TextStyle(fontSize: 30),
              ),
            ),
            inputItem(AL.of(context).minute, _currentTime.minute, minutes,
                _minScrollController, returnToPositionMin),

          ],
        ),
      );
    });
  }


  returnToPositionHour() async {
    if (_hourTimer?.isActive ?? false) {
      _hourTimer!.cancel();
    }
    _hourTimer = Timer(const Duration(milliseconds: 100), () {
      var currentPos = _hourScrollController.position.pixels / 25;
      _hourScrollController.jumpTo(currentPos.round() * 25.0);
      print("cambiando las horas de $_currentTime");
      widget.handleTime(_currentTime.copyWith(hour: currentPos.round().toInt()));
    });
  }

  returnToPositionMin() async {
    if (_minTimer?.isActive ?? false) {
      _minTimer!.cancel();
    }
    _minTimer = Timer(const Duration(milliseconds: 100), () {
      var currentPos = _minScrollController.position.pixels / 25;
      _minScrollController.jumpTo(currentPos.round() * 25.0);
      print("cambiando los minutos de $_currentTime");
      widget.handleTime(_currentTime.copyWith(minute: (currentPos%60).round().toInt()));
    });
  }

}

inputItem(String label, int value, List<dynamic> list,
    ScrollController controller, Function toPos, {int? initValue, bool showMonth=false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 50,
        width: showMonth ? 100 : 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.primary)),
        child: Listener(
          onPointerUp: (_) {
            toPos();
          },
          child: ListView.builder(
              itemExtent: 25,
              padding: const EdgeInsets.symmetric(vertical: 12.5),
              controller: controller,
              itemBuilder: (context, index) {
                index = index % list.length;
                return Container(
                    height: 25,
                    width: 50,
                    alignment: Alignment.center,
                    child: Text(list[index].toString()));
              }),
        ),
      ),
      const SizedBox(height: 5,),
      Text(label, style: textTheme.labelMedium,)
    ],
  );
}

defaultPosition(ScrollController controller,initValue,offset){
    Timer(Duration.zero,()=>controller.jumpTo((initValue+offset)*_kHourMinuteHeight));
}