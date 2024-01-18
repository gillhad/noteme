import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormValidation{

  static String? textValidation(context, String? value){
    if(value==null){
      return AL.of(context).error_empty;
    }
    if(value.trim().isEmpty){
      return AL.of(context).error_empty;
    }
    return null;
  }

}