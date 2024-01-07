import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class ALEs extends AL {
  ALEs([String locale = 'es']) : super(locale);

  @override
  String get delete => 'Eliminar';

  @override
  String get main_title => 'NoteMe';

  @override
  String get settings => 'Ajustes';

  @override
  String get setttings_conf => 'Configuración';

  @override
  String get settings_not => 'Notificaciones';

  @override
  String get settings_theme => 'Temas';

  @override
  String get settings_info => 'Información';

  @override
  String get settings_fdb => 'Feedback';

  @override
  String get settings_conf_view => 'Configurar vista';

  @override
  String get settings_conf_viewMode => 'Activar vista simple';

  @override
  String get settings_conf_light => 'Activar modo oscuro';
}
