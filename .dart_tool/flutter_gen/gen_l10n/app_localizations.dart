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

  /// No description provided for @main_title.
  ///
  /// In es, this message translates to:
  /// **'NoteMe'**
  String get main_title;

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
