import 'package:go_router/go_router.dart';
import 'package:noteme/src/app.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/models/note_model.dart';
import 'package:noteme/src/ui/screens/main_holder.dart';
import 'package:noteme/src/ui/screens/notes/note_view.dart';
import 'package:noteme/src/ui/screens/settings/settings_conf.dart';

final router = GoRouter(
    routes: [
      GoRoute(
        path: routes.home,
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
              NoteClass? note = state.extra as NoteClass?;
            return NoteView(
              note: note,
            );
          }
      ),
    ]

);