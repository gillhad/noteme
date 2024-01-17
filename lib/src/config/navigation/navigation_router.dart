import 'package:go_router/go_router.dart';
import 'package:noteme/src/app.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/models/arguments.dart';
import 'package:noteme/src/models/folder_model.dart';
import 'package:noteme/src/models/note_model.dart';
import 'package:noteme/src/ui/screens/main_holder.dart';
import 'package:noteme/src/ui/screens/notes/folder_view.dart';
import 'package:noteme/src/ui/screens/notes/note_view.dart';
import 'package:noteme/src/ui/screens/settings/settings_conf.dart';

import '../../ui/screens/notes/home.dart';

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
            return SettingsConf();
          }
      ),

      GoRoute(
          path: routes.noteView,
          builder:(context, state) {
            print(state.extra);
           NoteViewArguments arg = state.extra as NoteViewArguments;
              NoteClass? note = arg.note;
              int? folderId = arg.folderId;
            return NoteView(
              note: note,
              folderId: folderId,
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
    ]

);