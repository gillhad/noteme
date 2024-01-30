import 'package:go_router/go_router.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/models/note_model.dart';
import 'package:noteme/src/ui/screens/main_holder.dart';
import 'package:noteme/src/ui/screens/notes/folder_view.dart';
import 'package:noteme/src/ui/screens/notes/note_view.dart';
import 'package:noteme/src/ui/screens/settings/settings_conf.dart';
import 'package:noteme/src/ui/screens/settings/settings_feedback.dart';

import '../../ui/screens/settings/settings_info.dart';
import '../../ui/screens/settings/settings_themes.dart';


final router = GoRouter(
    routes: [
      GoRoute(
        path: routes.mainHolder,
        builder:(context, state) {
          return MainHolder();
        }
      ),
      GoRoute(
          path: routes.settingsConf,
          builder:(context, state) {
            return const SettingsConf();
          }
      ),

      GoRoute(
          path: routes.noteView,
          builder:(context, state) {
              NoteClass? note = state.extra as NoteClass?;
            return NoteView(
              note: note,
            );
          }
      ),
      GoRoute(
          path: routes.folderView,
          builder:(context, state) {
            print(state.extra);
            Folders folder = state.extra as Folders;
            return FolderView(
              folder: folder,
            );
          }
      ),
      GoRoute(
          path: routes.settingsThemes,
          builder:(context, state) {
            print(state.extra);
            return SettingsThemes(
            );
          }
      ),
      GoRoute(
          path: routes.settingsInfo,
          builder:(context, state) {
            print(state.extra);
            return SettingsInfo(
            );
          }
      ),
      GoRoute(
          path: routes.settingsFeedback,
          builder:(context, state) {
            print(state.extra);
            return SettingsFeedback(
            );
          }
      ),
    ]

);