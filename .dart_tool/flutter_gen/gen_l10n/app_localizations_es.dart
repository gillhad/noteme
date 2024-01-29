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
  String get day => 'Día';

  @override
  String get month => 'Mes';

  @override
  String get year => 'Año';

  @override
  String get hour => 'Hora';

  @override
  String get minute => 'Minuto';

  @override
  String get main_title => 'NoteMe';

  @override
  String get home_add_new_note => 'Nueva nota';

  @override
  String get home_add_new_folder => 'Nueva carpeta';

  @override
  String get home_add_folder_title => 'Añade un título';

  @override
  String get home_search_hint => 'Buscar...';

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
  String get dialog_add_to_folder => 'Añadir a carpeta';

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
  String get dialog_add_reminder => 'Elige la fecha del recordatiorio';

  @override
  String get dialog_note_delete => 'Eliminar nota';

  @override
  String get dialog_note_delete_msg => 'Deseas eliminar la nota?';

  @override
  String get error_empty => 'Este valor es obligatorio';
}
