
import 'package:noteme/src/utils/sheet_theme_paints.dart';

class UserSettings{

  ///dark or light mode
  bool darkMode = true;
  /// Simple (list) or complex (grid)
  bool simpleMode = false;
  bool notifications =  true;

  ///user sheetTheme
  SheetThemes sheetTheme = SheetThemes.none;

  UserSettings.fromJson(json){
    simpleMode = json["simple_mode"];
    notifications = json["notifications"];
    sheetTheme = SheetThemes.getSheet(json['sheet_theme']);
  }

}