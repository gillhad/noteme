import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

/// Callers can lookup localized strings with an instance of AL
/// returned by `AL.of(context)`.
///
/// Applications need to include `AL.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AL.localizationsDelegates,
///   supportedLocales: AL.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AL.supportedLocales
/// property.
abstract class AL {
  AL(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AL of(BuildContext context) {
    return Localizations.of<AL>(context, AL)!;
  }

  static const LocalizationsDelegate<AL> delegate = _ALDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('es')
  ];

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @accept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get accept;

  /// No description provided for @day.
  ///
  /// In es, this message translates to:
  /// **'Día'**
  String get day;

  /// No description provided for @month.
  ///
  /// In es, this message translates to:
  /// **'Mes'**
  String get month;

  /// No description provided for @year.
  ///
  /// In es, this message translates to:
  /// **'Año'**
  String get year;

  /// No description provided for @hour.
  ///
  /// In es, this message translates to:
  /// **'Hora'**
  String get hour;

  /// No description provided for @minute.
  ///
  /// In es, this message translates to:
  /// **'Minuto'**
  String get minute;

  /// No description provided for @send.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get send;

  /// No description provided for @main_title.
  ///
  /// In es, this message translates to:
  /// **'NoteMe'**
  String get main_title;

  /// No description provided for @home_add_new_note.
  ///
  /// In es, this message translates to:
  /// **'Nueva nota'**
  String get home_add_new_note;

  /// No description provided for @home_add_new_folder.
  ///
  /// In es, this message translates to:
  /// **'Nueva carpeta'**
  String get home_add_new_folder;

  /// No description provided for @home_add_folder_title.
  ///
  /// In es, this message translates to:
  /// **'Añade un título'**
  String get home_add_folder_title;

  /// No description provided for @home_search_hint.
  ///
  /// In es, this message translates to:
  /// **'Buscar...'**
  String get home_search_hint;

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settings;

  /// No description provided for @setttings_conf.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get setttings_conf;

  /// No description provided for @settings_not.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get settings_not;

  /// No description provided for @settings_theme.
  ///
  /// In es, this message translates to:
  /// **'Temas'**
  String get settings_theme;

  /// No description provided for @settings_theme_select_sheet.
  ///
  /// In es, this message translates to:
  /// **'Elige un tema de fondo'**
  String get settings_theme_select_sheet;

  /// No description provided for @settings_info.
  ///
  /// In es, this message translates to:
  /// **'Información'**
  String get settings_info;

  /// No description provided for @settings_fdb.
  ///
  /// In es, this message translates to:
  /// **'Feedback'**
  String get settings_fdb;

  /// No description provided for @settings_conf_view.
  ///
  /// In es, this message translates to:
  /// **'Configurar vista'**
  String get settings_conf_view;

  /// No description provided for @settings_conf_viewMode.
  ///
  /// In es, this message translates to:
  /// **'Activar vista simple'**
  String get settings_conf_viewMode;

  /// No description provided for @settings_conf_light.
  ///
  /// In es, this message translates to:
  /// **'Activar modo oscuro'**
  String get settings_conf_light;

  /// No description provided for @settings_feedback.
  ///
  /// In es, this message translates to:
  /// **'Feedback'**
  String get settings_feedback;

  /// No description provided for @settings_feedback_msg.
  ///
  /// In es, this message translates to:
  /// **'¡Hola! Gracias por usar NoteMe. Si tienes alguna sugerencia o te has encontrado con algún problema puedes enviarme un mensaje aquí:'**
  String get settings_feedback_msg;

  /// No description provided for @dialog_add_to_folder.
  ///
  /// In es, this message translates to:
  /// **'Añadir a carpeta'**
  String get dialog_add_to_folder;

  /// No description provided for @dialog_move_folder.
  ///
  /// In es, this message translates to:
  /// **'Mover de carpeta'**
  String get dialog_move_folder;

  /// No description provided for @dialog_delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get dialog_delete;

  /// No description provided for @dialog_reminder.
  ///
  /// In es, this message translates to:
  /// **'Añadir recordatorio'**
  String get dialog_reminder;

  /// No description provided for @dialog_rename.
  ///
  /// In es, this message translates to:
  /// **'Renombrar'**
  String get dialog_rename;

  /// No description provided for @dialog_pin.
  ///
  /// In es, this message translates to:
  /// **'Fijar'**
  String get dialog_pin;

  /// No description provided for @dialog_unpin.
  ///
  /// In es, this message translates to:
  /// **'Desfijar'**
  String get dialog_unpin;

  /// No description provided for @dialog_folder_not_empty.
  ///
  /// In es, this message translates to:
  /// **'Eliminar carpeta'**
  String get dialog_folder_not_empty;

  /// No description provided for @dialog_folder_msg.
  ///
  /// In es, this message translates to:
  /// **'La carpeta contiene notas, deseas eliminarlas o mantenerlas?'**
  String get dialog_folder_msg;

  /// No description provided for @dialog_folder_keep.
  ///
  /// In es, this message translates to:
  /// **'Mantener'**
  String get dialog_folder_keep;

  /// No description provided for @dialog_add_reminder.
  ///
  /// In es, this message translates to:
  /// **'Elige la fecha del recordatiorio'**
  String get dialog_add_reminder;

  /// No description provided for @dialog_note_delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar nota'**
  String get dialog_note_delete;

  /// No description provided for @dialog_note_delete_msg.
  ///
  /// In es, this message translates to:
  /// **'Deseas eliminar la nota?'**
  String get dialog_note_delete_msg;

  /// No description provided for @error_empty.
  ///
  /// In es, this message translates to:
  /// **'Este valor es obligatorio'**
  String get error_empty;

  /// No description provided for @error_no_title.
  ///
  /// In es, this message translates to:
  /// **'Debes añadir almenos un título'**
  String get error_no_title;
}

class _ALDelegate extends LocalizationsDelegate<AL> {
  const _ALDelegate();

  @override
  Future<AL> load(Locale locale) {
    return SynchronousFuture<AL>(lookupAL(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_ALDelegate old) => false;
}

AL lookupAL(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es': return ALEs();
  }

  throw FlutterError(
    'AL.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
