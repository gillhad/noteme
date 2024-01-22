import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class ALEs extends AL {
  ALEs([String locale = 'es']) : super(locale);

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get accept => 'Aceptar';

  @override
  String get main_title => 'NoteMe';

  @override
  String get home_add_new_note => 'Nueva nota';

  @override
  String get home_add_new_folder => 'Nueva carpeta';

  @override
  String get home_add_folder_title => 'Añade un título';

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

  @override
  String get dialog_add_folder => 'Añadir a carpeta';

  @override
  String get dialog_move_folder => 'Mover de carpeta';

  @override
  String get dialog_delete => 'Eliminar';

  @override
  String get dialog_reminder => 'Añadir recordatorio';

  @override
  String get dialog_rename => 'Renombrar';

  @override
  String get dialog_pin => 'Fijar';

  @override
  String get dialog_unpin => 'Desfijar';

  @override
  String get dialog_folder_not_empty => 'Eliminar carpeta';

  @override
  String get dialog_folder_msg => 'La carpeta contiene notas, deseas eliminarlas o mantenerlas?';

  @override
  String get dialog_folder_keep => 'Mantener';

  @override
  String get error_empty => 'Este valor es obligatorio';
}
