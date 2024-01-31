import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/app_colors.dart';
import 'package:noteme/src/utils/sheet_theme_paints.dart';

class SettingsThemes extends ConsumerStatefulWidget {
 const  SettingsThemes({super.key});

  @override
  ConsumerState<SettingsThemes> createState() => _SettingsThemesState();
}

  class _SettingsThemesState extends ConsumerState<SettingsThemes>{

  SheetThemes _currentTheme = SheetThemes.none;

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: _appBar(),
    body: _content(),
  );
  }

  AppBar _appBar(){
    return AppBar(
      leadingWidth: 25,
      leading: IconButton(
        padding: EdgeInsets.zero,
        onPressed: (){
          GoRouter.of(context).pop();
        },
        icon: const Icon(Icons.chevron_left),
      ),
      title: Text(AL.of(context).settings_theme),
    );
  }

  Widget _content(){
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          _showThemes(),
        ],
      ),
    );
  }

  _showThemes(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AL.of(context).settings_theme_select_sheet),
        SizedBox(height: 12,),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Row(
            children: [
              _themeOption(SheetThemes.none),
              _themeOption(SheetThemes.linear),
              _themeOption(SheetThemes.noteBook)
            ],
          ),
        ),
      ],
    );
  }

  Widget _themeOption(SheetThemes theme){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: CustomPaint(
          painter: SheetThemes.getTheme(theme),
          child: GestureDetector(
            onTap: (){
              _selectTheme(theme);
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _currentTheme == theme ? AppColors.primary : Colors.white),
                  borderRadius: BorderRadius.circular(5)
                ),
            ),
          ),
        ),
      ),
    );
  }

  _selectTheme(theme){
    setState(() {
      _currentTheme = theme;
    });
  }

  }